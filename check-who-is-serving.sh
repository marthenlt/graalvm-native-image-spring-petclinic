#!/usr/bin/env bash

for i in {1..1000}; do curl -s http://petclinic-knative-serving.default.127.0.0.1.xip.io/doscale | grep served && sleep 0.3; done