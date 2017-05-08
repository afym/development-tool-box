#!/bin/bash

TERRAFORM="https://releases.hashicorp.com/terraform/0.9.4/terraform_0.9.4_linux_amd64.zip?_ga=2.93593816.490776699.1494273345-1065763048.1494273345"
PACKER="https://releases.hashicorp.com/packer/1.0.0/packer_1.0.0_linux_amd64.zip?_ga=2.61043948.157987214.1494273286-70238317.1494273286"
CONSUL="https://releases.hashicorp.com/consul/0.8.1/consul_0.8.1_linux_amd64.zip?_ga=2.137799600.144444728.1494277813-1505192070.1494277764"
NOMAD="https://releases.hashicorp.com/nomad/0.5.6/nomad_0.5.6_linux_amd64.zip?_ga=2.194989741.144444728.1494277813-1505192070.1494277764"
VAULT="https://releases.hashicorp.com/vault/0.7.2/vault_0.7.2_linux_amd64.zip?_ga=2.233679134.144444728.1494277813-1505192070.1494277764"
KOPS="https://github.com/kubernetes/kops/releases/download/1.6.0-beta.1/kops-linux-amd64"

# base tasks
sudo apt-get update
sudo apt-get install unzip
sudo apt-get install zip

# hashicorpo cli tools
function hashicorp {
    TOOL_NAME=$1
    ZIP_URL=$2
    mkdir /tmp/$TOOL_NAME
    cd /tmp/$TOOL_NAME
    echo "$ZIP_URL :: downloading ..."
    curl -sS $ZIP_URL > $TOOL_NAME.zip
    unzip $TOOL_NAME.zip
    sudo cp $TOOL_NAME /usr/local/bin/$TOOL_NAME
    rm -rf /tmp/$TOOL_NAME
    echo "$TOOL_NAME :: is installed successfully"
}  

hashicorp "terraform" "$TERRAFORM"
hashicorp "packer" "$PACKER"
hashicorp "consul" "$CONSUL"
hashicorp "nomad" "$NOMAD"
hashicorp "vault" "$VAULT"

# installing ansible
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get install ansible

# installing the aws cli
sudo apt-get install python-pip
pip install awscli

# installing kops
function kops {
    KOPS=$1
    cd /tmp
    curl -Lo kops $KOPS
    chmod +x kops
    sudo mv kops /usr/local/bin/
}

kops "$KOPS"