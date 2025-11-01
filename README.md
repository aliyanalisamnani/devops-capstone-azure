# DevOps Capstone Project (Local + Azure DevOps CI/CD)

## 📘 Overview

This project demonstrates a complete DevOps workflow that includes application development, containerization, orchestration, and CI/CD automation.

It’s designed to run **locally** using Docker and Minikube while being integrated with **Azure DevOps pipelines** for automated builds and deployments.

---

## ⚙️ Tech Stack

| Tool                      | Purpose                   |
| ------------------------- | ------------------------- |
| **Python / Flask**        | Backend Application       |
| **Docker**                | Containerization          |
| **Kubernetes / Minikube** | Local Orchestration       |
| **Terraform**             | Infrastructure as Code    |
| **Azure DevOps**          | CI/CD Automation          |
| **GitHub**                | Source Control Repository |

---

## 🧩 Pipeline Flow

1. **Run Unit Tests** – Automatically tests your Flask app using PyTest.
2. **Build Docker Image** – Builds the `devops-capstone:local` Docker image.
3. **Load into Minikube** – Loads the Docker image into Minikube’s local registry.
4. **Deploy using kubectl** – Applies Deployment, Service, and HPA YAMLs.
5. **(Optional)** – Terraform can provision cloud infrastructure for future extensions.

---

## 🖥️ How to Run Locally

### Run Flask app directly

```bash
git clone https://github.com/<your-username>/devops-capstone-azure.git
cd devops-capstone-azure
python app/app.py
```

Access the app at:

```
http://localhost:8080/
http://localhost:8080/healthz
```

### Run with Docker

```bash
docker build -t devops-capstone .
docker run -p 8080:8080 devops-capstone
```

---

## 🚀 Deploy to Minikube

```bash
minikube start
minikube image load devops-capstone:local
kubectl apply -f k8s/
minikube service devops-capstone -n devops-capstone --url
```

You’ll get a URL like:

```
http://127.0.0.1:xxxxx/
```

---

## 🧰 Azure DevOps CI/CD

This project uses **Azure DevOps Pipelines** integrated with a **self-hosted agent** (running locally).

### Pipeline Stages:

1. **Run Unit Tests** – Uses local Python 3.11 for tests.
2. **Build Docker Image** – Builds and tags the app container.
3. **Deploy to Minikube** – Loads image and applies Kubernetes manifests.

### Agent Details:

* Pool: `capstone`
* Environment: Windows (Docker Desktop + Minikube)
* CI/CD triggered automatically on `main` branch commits.

---

## 🪄 Terraform (Infrastructure as Code)

Located in the `terraform/` directory, the IaC defines:

* Kubernetes Namespace
* ConfigMap
* Deployment Configuration

You can initialize and apply with:

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

---

## 🧑‍💻 Author Information

| Field                     | Details                                                                                                |
| ------------------------- | ------------------------------------------------------------------------------------------------------ |
| **Name:**                 | Aliyan Ali                                                                                             |
| **Program:**              | BS Computer Science                                                                                    |
| **University:**           | Salim Habib University                                                                                 |
| **Azure DevOps Project:** | https://dev.azure.com/S21CSC02/DevOps-Capstone                                                         |
| **GitHub Repository:**    | https://github.com/aliyanalisamnani/devops-capstone-azure                                              |

---

## 💬 Notes

* This project runs fully **locally** using Docker Desktop and Minikube.
* Azure DevOps automates CI/CD using a **self-hosted agent**.
* Terraform is optional but included for understanding infrastructure automation.

---


