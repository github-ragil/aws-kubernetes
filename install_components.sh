#!/usr/bin/env bash
echo "###################################################################################"
echo "# DOCKER INSTALLATION                                                             #"
echo "###################################################################################"
echo " "

echo "###################################################################################"
echo "# Uninstall old versions, Disable Unattended Upgrade, & Swapoff              #"
echo "###################################################################################"
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo swapoff -a
sudo sed -i.bak '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo apt remove unattended-upgrades -y
echo " "

echo "###################################################################################"
echo "# Install Helm, Make, Curl, Wget & Git                                                    #"
echo "###################################################################################"
sudo apt-get update
sudo apt-get install -y make git curl wget
sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo bash get_helm.sh

echo " "

sudo apt-get update -y  && sudo apt-get install apt-transport-https -y
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update

sudo modprobe br_netfilter
sudo sysctl net.bridge.bridge-nf-call-iptables=1
sudo sysctl -p
sudo apt-get install docker.io -y

sudo usermod -aG docker ubuntu && newgrp docker

sudo systemctl restart docker
sudo systemctl enable docker.service


sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni

sudo systemctl daemon-reload
sudo systemctl start kubelet
sudo systemctl enable kubelet.service
sudo systemctl status docker