#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y curl

curl -sfL https://get.k3s.io | sh -s - --node-ip=192.168.56.110 --advertise-address=192.168.56.110 --bind-address=192.168.56.110

mkdir -p $HOME/.kube
sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
sudo chown $(whoami):$(whoami) $HOME/.kube/config

if ! grep -q "192.168.56.110 app1.com app2.com" /etc/hosts; then
    echo "192.168.56.110 app1.com app2.com" | sudo tee -a /etc/hosts
    echo "/etc/hosts updated with app1.com and app2.com"
else
    echo "/etc/hosts already contains app1.com and app2.com"
fi

if kubectl get nodes &> /dev/null; then
    echo "K3s Server setup complete and kubectl is working correctly!"
else
    echo "K3s is installed but kubectl cannot communicate with the cluster."
    echo "Please check logs with: sudo journalctl -u k3s"
fi