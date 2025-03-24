#!/bin/bash

# Obtenir le mot de passe admin d'Argo CD
TEMP_PASSWORD_FILE=$(mktemp)
chmod 600 "$TEMP_PASSWORD_FILE"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > "$TEMP_PASSWORD_FILE"
echo "Le mot de passe est stocké dans le fichier : $TEMP_PASSWORD_FILE"

# Créer une application Argo CD
kubectl apply -f ./confs/agrocd-application.yaml
kubectl apply -f ./confs/ingress.yaml

# Run server and get account
echo "Accédez à Argo CD à l'adresse: https://argocd.hosts.local/"
echo "Utilisateur: admin"
echo "Mot de passe: voir $TEMP_PASSWORD_FILE"
