# IoT Project - Bonus Part

## Overview

This project implements a CI/CD pipeline for the IoT application using K3d, Kubernetes, ArgoCD, and GitLab. The setup automates the deployment process, enabling continuous delivery of application changes.

## Architecture

The architecture consists of:

- **K3d cluster**: Lightweight Kubernetes cluster for local development
- **GitLab**: Source code management and CI
- **ArgoCD**: Continuous delivery tool that synchronizes Kubernetes manifests from GitLab
- **NGINX Ingress Controller**: Manages external access to the services

## Prerequisites

- Docker
- kubectl
- k3d
- helm

## Setup Instructions

### 1. Start the K3d Cluster and Dependencies

Run the setup script to create a K3d cluster and install necessary components:

```bash
chmod +x ./scripts/setup.sh
./scripts/setup.sh
```

This script will:

- Create a K3d cluster named "iot-bonus"
- Extract the CA certificate
- Install the NGINX Ingress Controller
- Create required namespaces (gitlab, argocd, dev)
- Install ArgoCD
- Install GitLab

### 2. Configure ArgoCD

After the initial setup completes, configure ArgoCD ingress:

```bash
chmod +x ./scripts/argocd.sh
./scripts/argocd.sh
```

### 3. Access GitLab

Get GitLab access credentials:

```bash
chmod +x ./scripts/gitlab.sh
./scripts/gitlab.sh
```

### 4. Set Up GitLab Repository

1. Log in to GitLab using the credentials from the previous step
2. Generate a token with all scope (Profil > Preferences > Access Token)
3. Export the token with this command :

```sh
export GITLAB_TOKEN=<your-token>
```

4. Update the file `confs/argocd-gitlab-token.yaml` and give the token at key password
5. Create a new project named "wil", with root user, and at public
6. Set the certificate gitlab, at bonus repertory, with this command :

```sh
git config --global http.sslCAInfo $PWD/gitlab.crt
```

5. Clone the project `wil`
6. Copy and past the `manifests.yaml`
7. Update the repo url with this command :

```sh
git remote set-url origin https://root:$TOKEN_GITLAB@gitlab.hosts.local/root/wil.git
```

8. Push your application code to this repository

### 5. Deploy Application with ArgoCD

Deploy the application using ArgoCD:

```bash
chmod +x ./scripts/setup_app.sh
./scripts/setup_app.sh
```

## Accessing the Services

- **GitLab**: http://gitlab.hosts.local/
- **ArgoCD**: https://argocd.hosts.local/
- **Application**: Access through configured ingress routes

## Configuration Files

- `confs/gitlab-values.yaml`: GitLab Helm chart configuration
- `confs/argocd-ingress.yaml`: ArgoCD ingress configuration
- `confs/argocd-gitlab-token.yaml`: Secret for GitLab authentication
- `confs/argocd-application.yaml`: ArgoCD application configuration

## CI/CD Workflow

1. Changes are pushed to the GitLab repository
2. ArgoCD detects changes in the Git repository
3. ArgoCD automatically applies the changes to the Kubernetes cluster
4. The application is updated with the new version
