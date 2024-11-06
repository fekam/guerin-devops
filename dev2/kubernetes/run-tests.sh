#!/bin/bash

docker rm -f $(docker ps -aqf "name=guerindb")
docker network rm guerin 

docker network create guerin

( cd database ; ./run.sh )

sleep 5

db_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' guerindb)
sed -i -e "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}:[0-9]\{1,5\}/$db_ip:3306/g" ../src/main/resources/application.properties

cd .. && mvn clean test && cd kubernetes

docker rm -f $(docker ps -aqf "name=guerindb")
docker network rm migration 

















