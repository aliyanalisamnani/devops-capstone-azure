#!/usr/bin/env bash
set -euo pipefail

# --- Config ---
PREFIX="${PREFIX:-student}"
IMAGE_TAG="${IMAGE_TAG:-v1}"
APP_IMAGE="${APP_IMAGE:-devops-capstone}"

# --- 1) Login (interactive or already logged in) ---
echo "[+] Ensuring Azure CLI login (use 'az login' first if needed)"
az account show >/dev/null 2>&1 || az login -o table

# --- 2) Terraform apply infra ---
echo "[+] Terraform: creating RG + ACR + AKS"
pushd terraform-azure >/dev/null
terraform init -input=false
terraform apply -auto-approve
RG=$(terraform output -raw resource_group || true)
AKS=$(terraform output -raw aks_name || true)
ACR_LOGIN_SERVER=$(terraform output -raw acr_login_server || true)
KUBECONFIG_RAW=$(terraform output -raw kubeconfig || true)
popd >/dev/null

# Write kubeconfig to file
echo "[+] Writing kubeconfig"
KCFG=".kubeconfig_aks"
echo "$KUBECONFIG_RAW" > "$KCFG"
export KUBECONFIG="$PWD/$KCFG"

# --- 3) Build and push image to ACR ---
echo "[+] Building and pushing image to ACR"
az acr login --name "${ACR_LOGIN_SERVER%%.*}"
FULL_IMAGE="$ACR_LOGIN_SERVER/$APP_IMAGE:$IMAGE_TAG"
docker build -t "$FULL_IMAGE" .
docker push "$FULL_IMAGE"

# --- 4) Create namespace and ConfigMap (via kubectl for simplicity) ---
echo "[+] Ensuring namespace exists"
kubectl get ns devops-capstone >/dev/null 2>&1 || kubectl create ns devops-capstone

kubectl -n devops-capstone create configmap app-config \
  --from-literal=APP_NAME=devops-capstone \
  --from-literal=GREETING="Hello from Azure AKS!" \
  --dry-run=client -o yaml | kubectl apply -f -

# --- 5) Render deployment with ACR image and apply manifests ---
echo "[+] Rendering deployment with image: $FULL_IMAGE"
sed "s#__IMAGE__#${FULL_IMAGE}#g" k8s/deployment.tmpl.yaml > k8s/deployment.azure.yaml

kubectl apply -n devops-capstone -f k8s/deployment.azure.yaml
kubectl apply -n devops-capstone -f k8s/service.yaml
kubectl apply -n devops-capstone -f k8s/hpa.yaml

echo "[+] Done. Get service (ClusterIP). For external access, create LoadBalancer Service or Ingress."
kubectl -n devops-capstone get deploy,svc,hpa,pods -o wide
