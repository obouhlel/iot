#!/bin/bash

# Create cluster
echo "Create cluster..."
k3d cluster create iot-bonus

# Add gitlab helm charts
echo "Get Helm charts..."
helm repo add gitlab https://charts.gitlab.io/
helm repo update

# Create namespace
echo "Create namespaces..."
kubectl create namespace gitlab
kubectl create namespace argocd
kubectl create namespace dev

# Configure gitlab
echo "Install gitlab on http://gitlab.hosts.local/ ..."
helm install gitlab gitlab/gitlab --namespace gitlab --create-namespace -f ./confs/values.yaml

echo "Waiting gitlab..."
kubectl wait --for=condition=Ready pods --all -n gitlab --timeout=600s

# Mot de passe gitlab
echo -n "Password : "
kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -o jsonpath="{.data.password}" | base64 --decode