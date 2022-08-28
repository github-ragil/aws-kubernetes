#!/usr/bin/env bash
echo "###################################################################################"
echo "# KUBE INIT ON MASTER NODE ONLY                                                   #"
echo "###################################################################################"
echo " "

echo "###################################################################################"
echo "# 1/5 Install Helm                                                                #"
echo "###################################################################################"
sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo bash get_helm.sh
echo " "

echo "###################################################################################"
echo "# 2/5 Kubeadm Init & Git Clone TriviaApp                                          #"
echo "###################################################################################"
sudo kubeadm init --ignore-preflight-errors=all
sudo git clone https://github.com/github-ragil/go-trivia.git
echo " "

echo "###################################################################################"
echo "# 3/5 Startup Cluster Configurations                                              #"
echo "###################################################################################"
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
echo " "

echo "###################################################################################"
echo "# 4/5 Install Weave CNI                                                           #"
echo "###################################################################################"
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')" 
echo " "

echo "###################################################################################"
echo "# 5/5 Get Nodes & Make Install go-trivia                                       #"
echo "###################################################################################"
kubectl get nodes
echo " "