#!/usr/bin/env bash

mvn package -DskipTests

docker build -f Dockerfile-multistage -t marthenl/petclinic-mysql-native-image:0.8 .
