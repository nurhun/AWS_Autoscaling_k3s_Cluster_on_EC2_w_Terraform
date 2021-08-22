#!/bin/bash

# Set timezone
sudo timedatectl set-timezone Africa/Cairo


# Update Repositories, install some basic packages.
sudo apt-get update && \
sudo apt-get install -y net-tools && \
sudo apt-get install -y rpcbind && \
sudo apt-get install -y nfs-common && \
sudo apt-get autoremove -y


# nfs service is masked, we need to unmask and enable to be able to dynamically provision PVCs.
sudo rm /lib/systemd/system/nfs-common.service && \
sudo systemctl daemon-reload && \
sudo systemctl start nfs-common && \
sudo systemctl enable nfs-common


# Set the hostname
hostnamectl set-hostname $(curl -s http://169.254.169.254/latest/meta-data/local-hostname)
CUR_HOSTNAME=$(cat /etc/hostname)
echo -e "127.0.0.1  $CUR_HOSTNAME" | sudo tee -a /etc/hosts > /dev/null 2>&1

provider_id="$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)/$(curl -s http://169.254.169.254/latest/meta-data/instance-id)"


# K3s with AWS Cloud Controller Manger & Kubernetes ingress-nginx controller 

# Using PostgreSQL DB.

# export K3S_URL=https://${lb_dns_name}:6443
# export K3S_TOKEN=${token}

# curl -sfL https://get.k3s.io | sh -
curl -sfL https://get.k3s.io | K3S_URL=https://${lb_dns_name}:6443 K3S_TOKEN=${token} INSTALL_K3S_EXEC="--kubelet-arg provider-id=aws:///$provider_id" sh -


sudo apt install -y docker.io
sudo usermod -aG docker ubuntu
sudo apt-get install -y acl
sudo setfacl -m user:1000:rw /var/run/docker.sock
# sudo getfacl /var/run/docker.sock
