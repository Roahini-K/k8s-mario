#!/bin/bash

set -e

# ==========================================
# Update system
# ==========================================

sudo apt-get update
sudo apt-get upgrade -y


# ==========================================
# Install basic packages
# ==========================================

sudo apt-get install -y \
    curl \
    wget \
    unzip \
    gnupg \
    software-properties-common \
    ca-certificates


# ==========================================
# Install Terraform
# ==========================================

wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt-get update
sudo apt-get install -y terraform


# ==========================================
# Install kubectl
# ==========================================

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

rm -f kubectl


# ==========================================
# Install AWS CLI v2
# ==========================================

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
    -o "awscliv2.zip"

unzip -q awscliv2.zip

sudo ./aws/install

rm -rf aws awscliv2.zip


# ==========================================
# Verify installations
# ==========================================

echo ""
echo "=========================================="
echo "Installation completed successfully!"
echo "=========================================="

echo ""
echo "Terraform:"
terraform version

echo ""
echo "kubectl:"
kubectl version --client

echo ""
echo "AWS CLI:"
aws --version
