#!/usr/bin/env bash

for i in {1..5000}; do curl -s http://petclinic-knative-serving.default.127.0.0.1.xip.io/doscale | grep served | sed -e 's/<[^>]*>//g' && sleep 0.2; done