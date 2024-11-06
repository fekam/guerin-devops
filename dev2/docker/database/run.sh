#!/bin/bash

docker build -t "guerindb" .
docker run --rm --network=guerin -d -p 3306:3306 --name "guerindb" "guerindb"
