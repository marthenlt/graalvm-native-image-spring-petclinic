#!/usr/bin/env bash

kubectl apply -f mysql-pv.yaml
sleep 2
kubectl apply -f mysql-deployment.yaml
sleep 45
kubectl apply -f petclinic-app-deployment.yaml