#!/bin/bash

kubectl delete application wil -n argocd
kubectl delete secret gitlab-repo-token -n argocd

kubectf apply -f ./confs/argocd-custom-ca.yaml
kubectl apply -f ./confs/argocd-gitlab-token.yaml
kubectl apply -f ./confs/argocd-application.yaml