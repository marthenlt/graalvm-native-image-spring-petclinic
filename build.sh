#!/usr/bin/env bash

BLUE='\033[0;34m'
NC='\033[0m'

printf "=== ${BLUE}Building %s sample${NC} ===\n" "${PWD##*/}"
./compile.sh

docker build -t marthenl/petclinic-mysql-native-image:0.7 .
