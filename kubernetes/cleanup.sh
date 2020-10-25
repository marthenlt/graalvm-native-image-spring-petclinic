#!/usr/bin/env bash

kubectl delete -f mysql-deployment.yaml
sleep 10
kubectl delete -f mysql-pv.yaml
kubectl delete -f petclinic-app-deployment.yaml
kubectl delete -f knative-serving.yaml
