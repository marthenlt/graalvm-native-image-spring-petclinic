#!/usr/bin/env bash

# for mac
otool -l target/petclinic-jpa | grep -w "name"

# for linux
#ldd target/petclinic-jpa
