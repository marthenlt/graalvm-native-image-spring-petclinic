#!/usr/bin/env bash

mvn package -DskipTests

docker build -t marthenl/petclinic-mysql-native-image:0.3 .
