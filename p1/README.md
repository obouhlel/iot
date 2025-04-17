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

## Vagrantfile

This project's Vagrantfile configures a minimal K3s Kubernetes cluster with two virtual machines:

### Global Configuration

- **Box used**: Ubuntu Jammy 64-bit (`ubuntu/jammy64`)

### Server Node (sredjiniS)

- **Hostname**: sredjiniS
- **IP**: 192.168.56.110 (private network)
- **Resources**: 1024MB RAM, 1 CPU
- **Provisioning**: Executes the `server.sh` script which configures the K3s server node (control plane)

### Worker Node (sredjiniSW)

- **Hostname**: sredjiniSW
- **IP**: 192.168.56.111 (private network)
- **Resources**: 1024MB RAM, 1 CPU
- **Provisioning**: Executes the `worker.sh` script which configures the K3s worker node connecting to the server

## Scripts

### Server Script (server.sh)

The server script configures the K3s control plane node:

1. Updates the system packages and installs curl
2. Installs K3s in server mode using the official installation script
3. Sets up the kubectl configuration for the current sredjini
4. Verifies the installation by checking if kubectl can communicate with the cluster
5. Retrieves the node token from the K3s server
6. Saves this token to a shared folder so worker nodes can access it for authentication

### Worker Script (worker.sh)

The worker script configures K3s agent nodes that connect to the server:

1. Updates the system packages and installs curl
2. Gets the server node's IP address (192.168.56.110)
3. Retrieves the authentication token saved by the server script
4. Installs K3s in agent mode, configuring it to connect to the server using the provided IP and token
5. The worker node will automatically register with the K3s server upon successful installation

## Checks

To check if the server is running with the worker, use the connection ssh in the server, and type :

```sh
sudo kubectl get nodes -o wide
```

You need to have 2 lines, the first is the server and the seconde the agent

```sh
NAME         STATUS   ROLES                  AGE   VERSION        INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION       CONTAINER-RUNTIME
sredjinis    Ready    control-plane,master   14m   v1.31.6+k3s1   10.0.2.15     <none>        Ubuntu 22.04.5 LTS   5.15.0-134-generic   containerd://2.0.2-k3s2
sredjinisw   Ready    <none>                 13m   v1.31.6+k3s1   10.0.2.15     <none>        Ubuntu 22.04.5 LTS   5.15.0-134-generic   containerd://2.0.2-k3s2
```
