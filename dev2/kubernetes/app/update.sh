#!/bin/bash

VERSION=""

# Function to process arguments
process_arguments() {
    while [ -n "$1" ]
    do
        case $1 in
            -h|--help) 
                echo "Usage: update.sh -v '0.0.1'"
                exit 1
                ;;
            -v) 
                VERSION=$2
                shift 
                break
                ;;
            *) 
                echo "Invalid argument. Usage: update.sh -v '0.0.1'"
                exit 1
                ;;
        esac
        shift
    done
}

process_arguments "$@"

# Ensure the version is provided
if [ -z "$VERSION" ]; then
  echo "Error: Version not specified. Use -v to provide the version."
  exit 1
fi

# Get the node port of the Kubernetes service
node_port=$(kubectl get service antarezdb-deployment --output jsonpath='{.spec.ports[*].nodePort}')

if [ -z "$node_port" ]; then
  echo "Error: Node port could not be retrieved. Check the Kubernetes service."
  exit 1
fi

# Update application.properties with the new IP and port
sed -i -e "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}:[0-9]\{1,5\}/192.168.99.100:$node_port/g" ../../src/main/resources/application.properties

# Build the Maven project
cd ../.. && mvn clean package -DskipTests
if [ $? -ne 0 ]; then
  echo "Error: Maven build failed."
  exit 1
fi

# Navigate to the Kubernetes app directory
cd kubernetes/app

# Copy the newly built JAR
cp ../../target/spring-boot-sample-hateoas-*.jar ./

# Build the Docker image
docker build -t "antarezapp:$VERSION" .
if [ $? -ne 0 ]; then
  echo "Error: Docker build failed."
  exit 1
fi

# Tag and push the Docker image
docker tag antarezapp:$VERSION marcelomata/antarezapp:$VERSION
docker push marcelomata/antarezapp:$VERSION
if [ $? -ne 0 ]; then
  echo "Error: Docker push failed."
  exit 1
fi

# Clean up by removing the JAR
rm spring-boot-sample-hateoas-*.jar

# Apply the Kubernetes update
kubectl apply -f newversion.yaml --record
kubectl rollout status deployment antarezapp-deployment
if [ $? -ne 0 ]; then
  echo "Error: Kubernetes rollout failed."
  exit 1
fi

echo "Update complete. Version $VERSION successfully deployed."
