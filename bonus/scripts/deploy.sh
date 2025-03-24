#!/bin/bash

kubectl delete application wil -n argocd
kubectl delete secret gitlab-repo-token -n argocd

kubectl apply -f ./confs/argocd-gitlab-token.yaml
kubectl apply -f ./confs/argocd-application.yaml