#!/bin/bash
if [ -z "$1"]; then
    echo "image version is required, example: ./deploy-remote-image.sh 0.2.1"
    exit
fi
cd terraform/pre-production/k8s
terraform init
terraform apply --auto-approve -var="image_version"=$1
sleep 4
kubectl get pods