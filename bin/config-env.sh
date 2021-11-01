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

if terraform --version; then
    echo "terraform already installed"
else
    curl -s -qL -o terraform.zip https://releases.hashicorp.com/terraform/1.0.8/terraform_1.0.8_linux_amd64.zip
    unzip terraform.zip
    mv ./terraform /usr/bin/
fi

if terragrunt --version; then
    echo "terragrunt is already installed"
else
    wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.35.4/terragrunt_linux_amd64
    2757  mv terragrunt_linux_amd64 terragrunt
    2758  chmod u+x terragrunt
    2759  sudo mv terragrunt /usr/local/bin/terragrunt
fi


tput setaf 2; echo 'Please, add this lines into /etc/hosts file'
echo '127.0.1.1       wefox.challenge.registry'
echo '127.0.0.1       hello.wefox.localhost';
