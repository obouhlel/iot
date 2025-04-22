#!/bin/bash

# Créer un cluster K3d
echo "Création du cluster K3d..."
k3d cluster create iot-cluster \
    --api-port 6550 \
    --agents 1 \
    --port "80:80@loadbalancer" \
    --port "443:443@loadbalancer"

# Créer les namespaces
echo "Création des namespaces..."
kubectl create namespace argocd
kubectl create namespace ingress-nginx
kubectl create namespace dev

echo "Install NGINX"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.1/deploy/static/provider/cloud/deploy.yaml

# Installer Argo CD
echo "Installation d'Argo CD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Attendre que tous les pods Argo CD soient prêts
echo "Attente du démarrage d'Argo CD..."
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=300s

echo "Installation terminée!"