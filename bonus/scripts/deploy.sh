#!/bin/bash

kubectl apply -f ./confs/argocd-gitlab-token.yaml
kubectl apply -f ./confs/argocd-application.yaml