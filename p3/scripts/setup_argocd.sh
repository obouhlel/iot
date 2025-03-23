#!/bin/bash

# Obtenir le mot de passe admin d'Argo CD
TEMP_PASSWORD_FILE=$(mktemp)
chmod 600 "$TEMP_PASSWORD_FILE"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > "$TEMP_PASSWORD_FILE"
echo "Le mot de passe est stocké dans le fichier : $TEMP_PASSWORD_FILE"

# Créer une application Argo CD
kubectl apply -f ./confs/agrocd-application.yaml

# Run server and get account
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
echo "Accédez à Argo CD à l'adresse: https://argocd.localhost/"
echo "Utilisateur: admin"
echo "Mot de passe: voir $TEMP_PASSWORD_FILE"
