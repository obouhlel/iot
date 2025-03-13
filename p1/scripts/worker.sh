#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y curl

MASTER_IP=192.168.56.110

# Get the token from the shared folder
TOKEN=$(cat /vagrant/.vagrant/token)
if [ -z "$TOKEN" ]; then
    echo "Error: Unable to retrieve the K3S token."
    exit 1
fi

curl -sfL https://get.k3s.io | K3S_URL="https://${MASTER_IP}:6443" K3S_TOKEN="$TOKEN" sh -

echo "K3s Worker setup complete!"