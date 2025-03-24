#!/bin/bash

# Configure ingress for argocd
kubectl apply -f ./confs/argocd-ingress.yaml

# Get account
PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo "===== ArgoCD Access Information ====="
echo "URL: https://argocd.hosts.local/"
echo "Username: admin"
echo "Password: ${PASSWORD}"
echo "===================================="
