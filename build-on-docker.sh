#!/usr/bin/env bash

./mvnw package -DskipTests

#docker build -f Dockerfile-multistage -t marthenl/petclinic-mysql-native-image:0.12 .

#workshop..
docker build -f Dockerfile-multistage-workshop -t localhost:5000/petclinic-mysql-native-image:0.12 .
