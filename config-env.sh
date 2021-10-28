#!/bin/bash
if k3d --version; then
    echo "k3d already installed"
else
    curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
fi

if kubectl version --client; then
    echo "kubectl already installed"
else
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.22.0/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    mv ./kubectl /usr/local/bin/kubectl
fi