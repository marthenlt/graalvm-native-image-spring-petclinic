#!/usr/bin/env bash

for i in {1..100}; do curl -s http://localhost:8080/mem-leak-operation/200000 && sleep 1; done
