#!/bin/bash

# System update
sudo apt-get update -y
sudo apt-get install -y curl

# K3s Installation
curl -sfL https://get.k3s.io | sh -

# kubectl configuration
mkdir -p $HOME/.kube
sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
sudo chown $(whoami):$(whoami) $HOME/.kube/config

# Check if everything works
if kubectl get nodes &> /dev/null; then
    echo "K3s Server setup complete and kubectl is working correctly!"
else
    echo "K3s is installed but kubectl cannot communicate with the cluster."
    echo "Please check logs with: sudo journalctl -u k3s"
fi

# Get the token for the worker nodes
TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)

# Store the token for the workers to use
echo $TOKEN > /vagrant/.vagrant/token