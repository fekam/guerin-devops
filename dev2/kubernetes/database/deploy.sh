#!/bin/bash

docker build -t "guerindb:0.0.1" .
docker tag guerindb:0.0.1 fekam/guerindb:0.0.1
docker push fekam/guerindb:0.0.1

# fazer o deploy no kubernetes
kubectl create -f deployment.yaml
kubectl rollout status deployment guerindb-deployment
kubectl expose deployment guerindb-deployment --type=NodePort


