#!/usr/bin/env pwsh
# (IMPORTANT! Make sure docker-desktop daemon is running on background)

# Create minikube cluster
Write-Host "Starting minikube..."
minikube start

# #Start minikube
# powershell wsl minikube start

#Apply Terraform Plan
Write-Host "Running Terraform Plan and Apply..."
terraform init
terraform plan -out jenkins.plan
terraform apply jenkins.plan

# # mv jenkins jobs
# Write-Host "Copying jenkins job from local to pod..."
# $POD=$(kubectl get pods -n jenkins)
# kubectl cp ./jenkins/jenkins_home/jobs/Console_App/config.xml ${POD}:var/jenkins_home/jobs/Console_App/config.xml -n jenkins

# Run cluster binding command
kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts

# Start minikube service
Write-Host "Open jenkins in browser window..."
minikube service jenkins -n jenkins

#restart jenkins
#kubectl rollout restart deployment jenkins -n jenkins

# adding a test
