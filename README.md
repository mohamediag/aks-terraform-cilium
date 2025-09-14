# AKS Terraform GitOps Test Environment

A test environment for Azure Kubernetes Service (AKS) with GitOps workflow using ArgoCD.

## Overview

This is a test setup for experimenting with:
- **AKS cluster** deployment via Terraform
- **GitOps workflow** using ArgoCD
- **Application deployment** through Kubernetes manifests
- **Service mesh** with Istio

> **Note**: Cilium is planned but not yet implemented in this test environment.

## Quick Start

### 1. Deploy AKS Cluster

```bash
# Initialize and apply Terraform
terraform init
terraform apply

# Configure kubectl
terraform output -raw kube_config
```

### 2. Install ArgoCD

```bash
# Install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Deploy applications using GitOps
kubectl apply -f gitops-apps/argo-apps/argo-apps.yaml
```

## Applications

The GitOps setup includes:
- **n8n** - Workflow automation
- **nginx** - Web server for testing
- **k6-load** - Load testing with Prometheus metrics
- **Istio** - Service mesh
- **Monitoring** - Prometheus stack

## Configuration

Default variables in `variables.tf`:
- Cluster name: `demo-aks`
- Location: `eastus`
- Node count: `2`
- VM size: `Standard_B2ms`

## Accessing ArgoCD

```bash
# Port forward to ArgoCD UI
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Get admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## Cleanup

```bash
terraform destroy
```