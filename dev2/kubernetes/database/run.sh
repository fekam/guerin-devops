#!/bin/bash

docker build -t "guerindb:0.0.1" .
docker run --rm --network=antarez -d -p 3306:3306 --name "guerindb" "guerindb:0.0.1"
