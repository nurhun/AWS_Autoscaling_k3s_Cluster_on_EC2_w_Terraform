#!/bin/bash


# Set timezone
sudo timedatectl set-timezone Africa/Cairo


# Update Repositories, install some basic packages.
sudo apt-get update && \
sudo apt-get install -y net-tools && \
sudo apt-get install -y awscli && \
sudo apt-get install -y rpcbind && \
sudo apt-get install -y nfs-common && \
sudo apt-get autoremove -y


# nfs service is masked, we need to unmask and enable to be able to dynamically provision PVCs.
sudo rm /lib/systemd/system/nfs-common.service && \
sudo systemctl daemon-reload && \
sudo systemctl start nfs-common && \
sudo systemctl enable nfs-common


# To enable running docker commands inside agent pods on kubernetes cluste:
sudo apt-get install -y docker.io
sudo usermod -aG docker ubuntu
sudo apt-get install -y acl
sudo setfacl -m user:1000:rw /var/run/docker.sock
# sudo getfacl /var/run/docker.sock


# # Install docker compose v1.29.2
# sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose
# sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


# sudo apt-get install curl ca-certificates gnupg
# curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
# sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
# sudo apt-get update
# sudo apt install -y postgresql-client-11


# Set the hostname & loopback IP Address.
hostnamectl set-hostname $(curl -s http://169.254.169.254/latest/meta-data/local-hostname)
CUR_HOSTNAME=$(cat /etc/hostname)
echo -e "127.0.0.1  $CUR_HOSTNAME" | sudo tee -a /etc/hosts > /dev/null 2>&1



# # Install k3s using the High Availability with an External DB option.

# # There are 2 ways:

# Way 1: K3s with AWS Cloud Controller Manger & Kubernetes ingress-nginx controller 

# # Using MySQL DB. (Not recommended, faced performance "lag & hanging" issues.)
# PROVIDER_ID="$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)/$(curl -s http://169.254.169.254/latest/meta-data/instance-id)"

# curl -sfL https://get.k3s.io | sh -s - server \
# --datastore-endpoint="mysql://${dbuser}:${dbpass}@tcp(${db_endpoint})/${dbname}" \
# --token ${token} \
# --disable servicelb \
# --disable traefik \
# --disable local-storage \
# --disable metrics-server \
# --disable-cloud-controller \
# --kubelet-arg provider-id=aws:///$PROVIDER_ID \
# --write-kubeconfig-mode 644 \
# --tls-san ${lb_dns_name}



# Using PostgreSQL DB.
PROVIDER_ID="$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)/$(curl -s http://169.254.169.254/latest/meta-data/instance-id)"

curl -sfL https://get.k3s.io | sh -s - server \
  --token ${token} \
  --datastore-endpoint="postgres://${dbuser}:${dbpass}@${db_endpoint}/${dbname}" \
  --disable servicelb \
  --disable traefik \
  --disable local-storage \
  --disable metrics-server \
  --disable-cloud-controller \
  --kubelet-arg provider-id=aws:///$PROVIDER_ID \
  --write-kubeconfig-mode 644 \
  --tls-san ${lb_dns_name}


sleep 30


# Overwrite node label to allow AWS Cloud Controller DaemonSet to work.
kubectl label $(kubectl get node -l node-role.kubernetes.io/master=true -o=name) --overwrite node-role.kubernetes.io/master=""

# Untaint master nodes of NoSchedule to allow pods running.
kubectl taint node --all node.cloudprovider.kubernetes.io/uninitialized=true:NoSchedule-


# Install Helm 3:
sudo apt-get install -y apt-transport-https --yes
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install -y helm
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# As the default $KUBECONFIG env of helm is (default "~/.kube/config"). Let's copy k3s.yaml to it to avoid "dial tcp 127.0.0.1:8080: connect: connection refused"
# cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
# export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

#helm repo add --force-update stable https://charts.helm.sh/stable
#helm repo add --force-update bitnami https://charts.bitnami.com/bitnami


# Install AWS cloud controller manager:

# Note: Used version is 0.0.2 for the 1.20 kubernetes
helm repo --kubeconfig /etc/rancher/k3s/k3s.yaml add aws-cloud-controller-manager https://kubernetes.github.io/cloud-provider-aws
helm repo update
helm install aws-cloud-controller-manager aws-cloud-controller-manager/aws-cloud-controller-manager --version 0.0.2


# Install ingress controller:

# Note: Ingress is installed as DaemonSet instead of Deployment.
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
kubectl create namespace ingress-nginx
helm  --kubeconfig /etc/rancher/k3s/k3s.yaml install my-ingress ingress-nginx/ingress-nginx -n ingress-nginx \
--set controller.hostNetwork=true,controller.kind=DaemonSet

# In AWS we use a Network load balancer (NLB) to expose the NGINX Ingress controller behind a Service of Type=LoadBalancer.
# #kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.45.0/deploy/static/provider/aws/deploy.yaml
# kubectl apply -f https://raw.githubusercontent.com/nurhun/ingress-nginx/master/deploy/static/provider/aws/deploy.yaml


# NFS Storage for persistent volumes:

# Using NFS is preferred as it supports ReadWriteMany (RWX)

# 1- Local NFS provisioner

# Installing nfs-server-provisioner replacing local-storage.
# Doesn't require extra terraform modules, as it creates NFS server POD locally inside the cluster.
# nfs-ganesha-server-and-external-provisioner is an out-of-tree dynamic provisioner for Kubernetes.
# This provisioner includes a built in NFS server, and is not intended for connecting to a pre-existing NFS server.
# It intiates a pod called "my-nfs-nfs-server-provisioner-0" and a service called "my-nfs-nfs-server-provisioner" as the NFS server.
# PV volumes are stored on this pod. running "kubectl exec -it my-nfs-nfs-server-provisioner-0 -- ls /export" will list existing PVs.
# https://github.com/kubernetes-sigs/nfs-ganesha-server-and-external-provisioner.git 

# Helm: (Recommended)
# helm repo add --force-update stable https://charts.helm.sh/stable
# helm repo add stable https://charts.helm.sh/stable
# helm repo update
# helm --kubeconfig /etc/rancher/k3s/k3s.yaml install my-nfs stable/nfs-server-provisioner \
# --set storageClass.defaultClass=true \
# --set storageClass.reclaimPolicy=Retain

# OR

# Manifests:
# kubectl apply -f https://raw.githubusercontent.com/nurhun/nfs-ganesha-server-and-external-provisioner/master/deploy/kubernetes/rbac.yaml
# kubectl apply -f https://raw.githubusercontent.com/nurhun/nfs-ganesha-server-and-external-provisioner/master/deploy/kubernetes/deployment.yaml
# kubectl apply -f https://raw.githubusercontent.com/nurhun/nfs-ganesha-server-and-external-provisioner/master/deploy/kubernetes/class.yaml


# 2- AWS EFS provisioner

# The efs-provisioner allows you to mount EFS storage as PersistentVolumes in kubernetes. Requires extra efs terraform module if folowing IaC.
# It consists of a container that has access to an AWS EFS resource. The container reads a configmap which contains the EFS filesystem ID, the AWS region and the name you want to use for your efs-provisioner.
# This name will be used later when you create a storage class. 
# https://artifacthub.io/packages/helm/isotoma/efs-provisioner
helm repo add stable https://charts.helm.sh/stable
helm repo update
helm --kubeconfig /etc/rancher/k3s/k3s.yaml install my-efs stable/efs-provisioner \
--set efsProvisioner.efsFileSystemId=${efs_id} \
--set efsProvisioner.awsRegion=${aws_region} \
--set efsProvisioner.provisionerName=nfs/aws-efs \
--set efsProvisioner.path=/k3s-pvs \
--set efsProvisioner.storageClass.isDefault=true \
--set efsProvisioner.storageClass.reclaimPolicy=Retain


# 3- Longhorn:
# Also support RWX but requires high resources.
# kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/master/deploy/longhorn.yaml
# OR
# https://longhorn.io/docs/0.8.0/install/install-with-helm/
# Modify frontend service to Lb to get access to UI.


# # ArgoCD
# kubectl create namespace argocd
# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# kubectl patch svc argocd-server -n argocd -p '{"spec": {"ports": [{"name": "http", "port": 6060, "protocol": "TCP", "targetPort": 8080},{"name": "https", "port": 443, "protocol": "TCP", "targetPort": 8080}] }}' --type merge
# kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# # To get admin user initial password:
# printf $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d);echo


# sleep 60

 
#### Jenkins ####

# #### AWS K3s ####
# helm repo add jenkinsci https://charts.jenkins.io
# helm repo update
# kubectl create ns jenkins
# kubectl apply -f https://raw.githubusercontent.com/nurhun/jenkisn_pvc/main/pvc_jks.yaml
# kubectl apply -f https://raw.githubusercontent.com/jenkins-infra/jenkins.io/master/content/doc/tutorials/kubernetes/installing-jenkins-on-kubernetes/jenkins-sa.yaml 
# cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
# helm install my-jenkins jenkinsci/jenkins -n jenkins \
# --set controller.serviceType=LoadBalancer \
# --set controller.servicePort=8888 \
# --set persistence.existingClaim=jenkins-pvc \
# --set persistence.accessMode=ReadWriteMany \
# --set agent.enabled=true \
# --set agent.image=nurhun/jenkins-inbound-agent-w-docker \
# --set agent.tag=v0.6 \
# --set agent.workingDir=/home/jenkins/agent \
# --set agent.args="" \
# --set agent.volumes[0].type=HostPath \
# --set agent.volumes[0].hostPath=/var/run/docker.sock \
# --set agent.volumes[0].mountPath=/var/run/docker.sock \
# --set agent.runAsUser=1000 \
# --set agent.runAsGroup=412 \
# --set agent.privileged=true

# --set agent.image=nurhun/my_custom_jenkins_inboud_agent \
# --set agent.tag=v1.0 \


# #### GKE ####
# helm repo add jenkinsci https://charts.jenkins.io
# helm repo update
# kubectl create ns sir
# kubectl apply -f https://raw.githubusercontent.com/nurhun/jenkisn_pvc/main/jenkins_pvc_gcp.yaml
# kubectl apply -f https://raw.githubusercontent.com/jenkins-infra/jenkins.io/master/content/doc/tutorials/kubernetes/installing-jenkins-on-kubernetes/jenkins-sa.yaml 
# helm install my-jenkins jenkinsci/jenkins -n sir \
# --set controller.serviceType=LoadBalancer \
# --set controller.servicePort=8888 \
# --set persistence.existingClaim=jenkins-pvc \
# --set persistence.accessMode=ReadWriteOnce \
# --set agent.enabled=true \
# --set agent.image=nurhun/jenkins-inbound-agent-w-docker \
# --set agent.tag=v0.6 \
# --set agent.workingDir=/home/jenkins/agent \
# --set agent.volumes[0].type=HostPath \
# --set agent.volumes[0].hostPath=/var/run/docker.sock \
# --set agent.volumes[0].mountPath=/var/run/docker.sock \
# --set agent.runAsGroup=412
# # --set agent.privileged=true

# # Get admin password:
# printf $(kubectl get secret --namespace sir my-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo


# # Way 2: K3s with native K3s Cloud Controller manager (ccm)

# curl -sfL https://get.k3s.io | sh -s - server \
#   --datastore-endpoint="mysql://${dbuser}:${dbpass}@tcp(${db_endpoint})/${dbname}" \
#   --write-kubeconfig-mode 644 \
#   --tls-san ${lb_dns_name}




# Login
# ssh -o StrictHostKeyChecking=no -i ~/.ssh/k8s_ec2_auth ubuntu@<ip_addr>


# #  kubectl autocomplete
# source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
# echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.
# alias k=kubectl
# complete -F __start_kubectl k