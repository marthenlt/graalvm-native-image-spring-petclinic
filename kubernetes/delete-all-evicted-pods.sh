#!/usr/bin/env bash

kubectl get pods --all-namespaces | awk '{if ($4 ~ /Evicted/) system ("kubectl -n " $1 " delete pods " $2)}'
