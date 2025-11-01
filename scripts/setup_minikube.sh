#!/usr/bin/env bash
set -euo pipefail
minikube start
eval $(minikube docker-env)
docker build -t devops-capstone:local .
(cd terraform && terraform init && terraform apply -auto-approve)
kubectl apply -n devops-capstone -f k8s/
