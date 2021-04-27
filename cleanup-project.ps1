#!/usr/bin/env pwsh
# (IMPORTANT! Make sure docker-desktop daemon is running on background)

# Create minikube cluster
Write-Host "Removing deployment"
Terraform destroy -y

Write-Host " Deleting Minikube"
minikube delete --all


