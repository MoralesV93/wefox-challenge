#!/bin/bash
cd terraform/pre-production/k8s
terraform init
terraform apply --auto-approve
sleep 4
kubectl get pods