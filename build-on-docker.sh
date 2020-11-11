#!/usr/bin/env bash

./mvnw package -DskipTests

docker build -f Dockerfile-multistage -t marthenl/petclinic-mysql-native-image:0.11 .
