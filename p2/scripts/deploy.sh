#!/bin/bash

cd /vagrant/confs

# Deploy
sudo kubectl apply -f app1-deployement.yaml
sudo kubectl apply -f app2-deployement.yaml
sudo kubectl apply -f app3-deployement.yaml
sudo kubectl apply -f ingress.yaml

# Wait for all pods to be ready
sudo kubectl wait --for=condition=Ready pods --all

# Check
sudo kubectl get pods
sudo kubectl get deployments
sudo kubectl get services
sudo kubectl get ingress