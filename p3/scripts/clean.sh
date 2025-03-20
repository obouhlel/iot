#!/bin/bash

echo "Nettoyage des ressources créées pour la partie 3 du projet Inception-of-Things..."

# Étape 1: Supprimer tous les port-forward en cours
echo "Arrêt des processus port-forward..."
pkill -f "kubectl port-forward"

# Étape 2: Supprimer toutes les applications Argo CD
echo "Suppression des applications Argo CD..."
if kubectl get namespace argocd &>/dev/null; then
  kubectl delete applications -n argocd --all
  
  # Attendre que les applications soient supprimées
  echo "Attente de la suppression des applications..."
  sleep 5
fi

# Étape 3: Supprimer tous les namespaces que nous avons créés
echo "Suppression des namespaces..."
kubectl delete namespace argocd dev --ignore-not-found

# Étape 4: Supprimer tous les clusters K3d
echo "Suppression des clusters K3d..."
k3d cluster list &>/dev/null && k3d cluster rm -a

# Étape 5: Nettoyer les conteneurs Docker orphelins liés à K3d
echo "Nettoyage des conteneurs Docker orphelins..."
docker ps -a | grep k3d | awk '{print $1}' | xargs -r docker rm -f

# Étape 6: Nettoyer les réseaux Docker créés par K3d
echo "Nettoyage des réseaux Docker..."
docker network ls | grep k3d | awk '{print $1}' | xargs -r docker network rm

# Étape 7: Nettoyer les volumes Docker créés par K3d
echo "Nettoyage des volumes Docker..."
docker volume ls | grep k3d | awk '{print $2}' | xargs -r docker volume rm

# Étape 8: Nettoyer les images Docker utilisées par K3d si nécessaire
echo "Voulez-vous supprimer les images Docker associées? (y/n)"
read -r answer
if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
  echo "Suppression des images Docker..."
  docker images | grep 'rancher/k3s\|rancher/k3d' | awk '{print $3}' | xargs -r docker rmi
  docker images | grep 'argoproj/argocd' | awk '{print $3}' | xargs -r docker rmi
  docker images | grep 'wil42/playground' | awk '{print $3}' | xargs -r docker rmi
fi

# Étape 9: Vérification finale
echo "Vérification des ressources restantes..."
echo "Clusters K3d restants:"
k3d cluster list 2>/dev/null || echo "Aucun"
echo "Conteneurs Docker liés à K3d restants:"
docker ps -a | grep k3d || echo "Aucun"
echo "Réseaux Docker liés à K3d restants:"
docker network ls | grep k3d || echo "Aucun"

echo "Nettoyage terminé!"