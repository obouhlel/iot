#!/bin/bash

# Vérifier si Docker est en cours d'exécution
if ! docker info > /dev/null 2>&1; then
  echo "Docker n'est pas en cours d'exécution."
  exit 1
fi

# Créer un cluster K3d
echo "Création du cluster K3d..."
k3d cluster create iot-cluster -p "8090:80@loadbalancer" -p "8043:443@loadbalancer" --agents 1

# Vérifier que le cluster fonctionne
echo "Vérification du cluster..."
kubectl get nodes

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