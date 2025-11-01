# Azure DevOps Setup Guide (CI/CD with ACR + AKS)

## 1) Import repo
Push this project to your Azure DevOps repo.

## 2) Service connections
Create two service connections (Project Settings → Service connections):
- **acr-sc**: Docker Registry → Authenticate to your **Azure Container Registry (ACR)**.
- **aks-sc**: Kubernetes → Connect to your **AKS** (or use Azure subscription auth + AKS context task).

## 3) Pipeline variables
In the pipeline Variables tab (or a Variable Group), set:
- `ACR_NAME` = `<yourregistry>.azurecr.io`
- `IMAGE_NAME` = `devops-capstone`
- `IMAGE_TAG` = `$(Build.SourceVersion)` (default is fine)
- `PUSH_TO_ACR` = `true` to push images, else `false`
- `DEPLOY_TO_AKS` = `true` to deploy, else `false`

## 4) Run pipeline
- Pipeline stages: **test → build → (push) → (deploy)**.
- If `PUSH_TO_ACR=true`, the image is pushed to `ACR_NAME/IMAGE_NAME:IMAGE_TAG` and `:latest`.
- If `DEPLOY_TO_AKS=true`, manifests in `k8s/` are applied to AKS in namespace `devops-capstone` and the deployment image is patched to the pushed ACR image.

### Notes
- For local learning, keep using **Minikube** + **Terraform** as in README.
- For cloud, you can add a new Terraform stack that provisions **AKS + ACR**; or create them via Azure Portal and only use this pipeline for CI/CD.
