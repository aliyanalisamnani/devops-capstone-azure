SHELL := /bin/bash
IMG ?= devops-capstone:latest
NS  ?= devops-capstone
docker-build: ; docker build -t $(IMG) .
docker-run: ; docker run --rm -d --name devops-capstone -p 8080:8080 $(IMG)
docker-stop: ; -docker rm -f devops-capstone
tf-init: ; cd terraform && terraform init
tf-apply: ; cd terraform && terraform apply -auto-approve
tf-destroy: ; cd terraform && terraform destroy -auto-approve
k8s-apply: ; kubectl apply -n $(NS) -f k8s/deployment.yaml ; kubectl apply -n $(NS) -f k8s/service.yaml ; kubectl apply -n $(NS) -f k8s/hpa.yaml
k8s-destroy: ; -kubectl delete -n $(NS) -f k8s/hpa.yaml ; -kubectl delete -n $(NS) -f k8s/service.yaml ; -kubectl delete -n $(NS) -f k8s/deployment.yaml
