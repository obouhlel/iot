#!/bin/bash

# Mise à jour du système
sudo apt-get update -y
sudo apt-get install -y curl

# Get the master node's IP from the arguments
MASTER_IP=192.168.56.110

# Get the token from the shared folder
TOKEN=$(cat /vagrant/.vagrant/token)

# Vérification si le token K3S_TOKEN est vide
if [ -z "$TOKEN" ]; then
    echo "Error: Unable to retrieve the K3S token."
    exit 1
fi

# Installation de K3s en mode worker
curl -sfL https://get.k3s.io | K3S_URL="https://${MASTER_IP}:6443" K3S_TOKEN="$TOKEN" sh -

echo "K3s Worker setup complete!"