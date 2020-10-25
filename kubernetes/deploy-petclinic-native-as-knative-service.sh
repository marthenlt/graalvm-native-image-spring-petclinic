#!/usr/bin/env bash

echo "Make sure you have your Knative and Istio installed and running correctly."

# Commented out MySQL deployment if you already run Petclinic Native app as a standard Pod using the other Shell script.
kubectl apply -f mysql-pv.yaml
sleep 2
kubectl apply -f mysql-deployment.yaml
sleep 45
kubectl apply -f istio-minimal-operator.yaml