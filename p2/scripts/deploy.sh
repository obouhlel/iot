#!/bin/bash

cd /vagrant/k3s-apps

# Deploy
sudo kubectl apply -f app1-deployement.yaml
sudo kubectl apply -f app2-deployement.yaml
sudo kubectl apply -f app3-deployement.yaml
sudo kubectl apply -f ingress.yaml

# Wait to start
sleep 30

# Check
sudo kubectl get pods
sudo kubectl get deployments
sudo kubectl get services
sudo kubectl get ingress