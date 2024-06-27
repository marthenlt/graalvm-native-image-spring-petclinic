#!/usr/bin/env bash

for i in {1..100}; do curl -s http://localhost:8081/mem-leak-operation/200 && sleep 1; done
