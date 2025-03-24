#!/bin/bash

# Set secrets
kubectl apply -f ./confs/argocd-secret.yaml

# Use the application
kubectl apply -f ./confs/agrocd-application.yaml