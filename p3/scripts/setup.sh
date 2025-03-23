#!/bin/bash

# Créer un cluster K3d
echo "Création du cluster K3d..."
k3d cluster create iot-cluster
# Créer les namespaces
echo "Création des namespaces..."
kubectl create namespace argocd
kubectl create namespace dev

# Installer Argo CD
echo "Installation d'Argo CD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Attendre que tous les pods Argo CD soient prêts
echo "Attente du démarrage d'Argo CD..."
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=300s

echo "Installation terminée!"