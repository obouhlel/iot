# Vagrant

The README to configure the Vagrantfile.

## Prerequisites

You need to install:

- [Vagrant](https://developer.hashicorp.com/vagrant/install)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Architecture

This project uses a simple two-node architecture with Vagrant to create a basic Kubernetes cluster using K3s:

- **Server Node**: The control plane node running K3s server
- **Worker Node**: A single worker node running K3s agent, connecting to the server

This minimal setup provides all the necessary components for a functional Kubernetes environment while being resource-efficient.

## Vagrant CLI

Common Vagrant commands for managing your environment:

- `vagrant up`: Start and provision the virtual machines
- `vagrant halt`: Stop the virtual machines
- `vagrant destroy`: Remove all traces of the virtual machines
- `vagrant ssh <node-name>`: Connect to a specific node via SSH
- `vagrant status`: Check the status of all VMs in the Vagrantfile
- `vagrant reload`: Restart VMs and load new Vagrantfile configuration
- `vagrant provision`: Run provisioning scripts on running VMs
