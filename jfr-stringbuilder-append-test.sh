#!/usr/bin/env bash

for i in {1..5}; do curl -s http://localhost:8081/stringbuilder-append/100 && sleep 1; done