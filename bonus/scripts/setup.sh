#!/bin/bash

# Créer le cluster k3d
echo "Creating K3d cluster..."
k3d cluster create iot-bonus \
    --api-port 6550 \
    --agents 1 \
    --port "80:80@loadbalancer" \
    --port "443:443@loadbalancer" \
    --network k3d-network

# Installer le contrôleur Ingress NGINX
echo "Installing NGINX Ingress Controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml

# Attendre que le contrôleur Ingress soit prêt
echo "Waiting for NGINX Ingress Controller..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s

# Créer les namespaces
echo "Creating namespaces..."
kubectl create namespace gitlab
kubectl create namespace argocd
kubectl create namespace dev

# Ajouter le repo Helm GitLab
echo "Adding GitLab Helm repository..."
helm repo add gitlab https://charts.gitlab.io/
helm repo update

# Installer Argo CD
echo "Installation d'Argo CD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Attendre que tous les pods Argo CD soient prêts
echo "Attente du démarrage d'Argo CD..."
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=300s

# Installer GitLab avec le fichier values.yaml
echo "Installing GitLab using values.yaml configuration..."
helm install gitlab gitlab/gitlab --namespace gitlab --timeout=300s -f ./confs/gitlab-values.yaml