# IoT Project Part 3 - Kubernetes with Argo CD

This project demonstrates Kubernetes deployment automation using Argo CD with a containerized application.

## Prerequisites

- Docker
- kubectl
- k3d
- Git

## Setup Process

### 1. Initial Setup

Run the setup script to create a Kubernetes cluster and install Argo CD:

```bash
./scripts/setup.sh
```

This script performs the following actions:

- Verifies Docker is running
- Creates a K3d cluster named "iot-cluster" with port mappings (8090:80, 8043:443)
- Creates two namespaces: "argocd" and "dev"
- Installs Argo CD in the "argocd" namespace
- Waits for all Argo CD pods to be ready

### 2. Setting Up Argo CD

After the initial setup, configure Argo CD:

```bash
./scripts/setup_argocd.sh
```

This script:

- Retrieves the Argo CD admin password and stores it in a temporary file
- Creates an Argo CD application to manage our deployment
- Sets up port forwarding for the Argo CD server

## What is Argo CD?

Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes. It automates the deployment of applications to Kubernetes by using Git repositories as the source of truth for the desired state of applications.

### Why Argo CD?

- **GitOps workflow**: Changes to your application are made through Git, providing a clear history and easy rollbacks
- **Automated synchronization**: Keeps your Kubernetes cluster in sync with the desired state defined in Git
- **Self-healing**: Automatically corrects drift between the desired state and the actual state
- **UI visualization**: Provides a web interface to monitor application deployments and their health

## Accessing Argo CD UI

Once the port forwarding is set up, you can access the Argo CD UI:

1. Open your browser and navigate to: https://localhost:8095/
2. Username: admin
3. Password: Find it in the temporary file location shown during setup

## Working with the Git Submodule

This project uses a Git submodule for the Argo CD application configuration. To update it:

```bash
# Initialize and fetch the submodule
git submodule update --init --recursive

# Pull the latest changes
git submodule update --remote
```

## Cleaning Up

When you're done with the project, run the cleanup script:

```bash
./scripts/clean.sh
```

This will remove all resources created for this project, including Argo CD applications, namespaces, and the K3d cluster.
