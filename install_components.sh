#!/usr/bin/env bash
echo "###################################################################################"
echo "# DOCKER INSTALLATION                                                             #"
echo "###################################################################################"
echo " "

echo "###################################################################################"
echo "# 1/2 Uninstall old versions, Disable Unattended Upgrade, & Swapoff              #"
echo "###################################################################################"
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo swapoff -a
sudo sed -i.bak '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo apt remove unattended-upgrades
echo " "

echo "###################################################################################"
echo "# 2/2 Install Helm, Make, Curl, Wget & Git                                                    #"
echo "###################################################################################"
sudo apt-get update
sudo apt-get install -y make git curl wget
sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo bash get_helm.sh

echo " "
