#!/bin/bash

# Créer une application Argo CD
kubectl apply -f ./confs/agrocd-application.yaml
kubectl apply -f ./confs/ingress.yaml

# Get account
PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo "===== ArgoCD Access Information ====="
echo "URL: https://argocd.hosts.local/"
echo "Username: admin"
echo "Password: ${PASSWORD}"
echo "===================================="
