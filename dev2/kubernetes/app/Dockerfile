FROM openjdk:17-jdk 

# Defines a volume for temporary files
VOLUME /tmp

# Adds the JAR file to the /app directory inside the container
ADD spring-boot-sample-hateoas-*.jar /app/app.jar

# Defines the entry point to run the Java application
ENTRYPOINT [ "sh", "-c", "java -Djava.security.egd=file:/dev/./urandom -jar /app/app.jar" ]

# Exposes port 8090 to make the app accessible from outside the container
EXPOSE 8090

