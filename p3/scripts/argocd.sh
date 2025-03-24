#!/bin/bash

# Créer une application Argo CD
kubectl apply -f ./confs/agrocd-application.yaml
kubectl apply -f ./confs/ingress.yaml

# Run server and get account
PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo "Accédez à Argo CD à l'adresse: https://argocd.hosts.local/"
echo "User: admin"
echo "Password: $PASSWORD"
