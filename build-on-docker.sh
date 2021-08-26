#!/usr/bin/env bash

./mvnw package -DskipTests

<<<<<<< HEAD
docker build -f Dockerfile-multistage -t marthenl/petclinic-mysql-native-image:0.15test .
=======
#docker build -f Dockerfile-multistage -t marthenl/petclinic-mysql-native-image:0.12 .

#workshop..
docker build -f Dockerfile-multistage-workshop -t localhost:5000/petclinic-mysql-native-image:0.12 .
>>>>>>> 0e81fc875d7bc63c8e28034973f56a4742359dfa
