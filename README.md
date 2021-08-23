# Self-managed Autoscaling K3s Kubernetes Cluster with CI & CD tools.

This project is intended to provide self-managed autoscaling **k3s kubernetes cluster** using **Terraform** IaC approach on **AWS**.

**K3s** is a lightweight, certified Kubernetes distribution sandbox project by **[CNCF](https://www.cncf.io/sandbox-projects/)**, packaged as a single binary. Natively, it requires some external dependencies, including:
* containerd
* Flannel
* CoreDNS
* CNI
* Host utilities (iptables, socat, etc)
* Ingress controller (traefik)
* Embedded service loadbalancer
* Embedded network policy controller

**Note:** we will replace some of these dependencies with better fit solutions.

**Terrafrom** is a great tool for cloud infrastructure provisioning. It’s ability to work with various Cloud providers, high level IaaC syntax and simplicity of dependencies set it right in front of the queue as an Enterprise level as well as low level cloud infra provisioning.

This project utilize **[Kubernetes AWS Cloud Provider](https://github.com/kubernetes/cloud-provider-aws)** to afford the interface between a Kubernetes cluster and AWS service APIs. This project allows a Kubernetes cluster to provision, monitor and remove AWS resources necessary for operation of the cluster. This will replace the native K3s cloud controller.

**List of utilized AWS:**
- EC2
- Autoscaling Groups (ASG)
- Elastic Load Balancers (ELB)
- RDS
- DynamoDB
- S3
- EFS
- IAM



## Architecture
![Architecture](k3s_cluster.svg)


**Cluster will be consisting of:**
- 3 Control planes (so that it’s possible to form quorum, for DevTest purpose we start with 1).
- 1 worker node could be scaled up to 3 worker nodes. (increases as needed)



## Main Terraform modules:
Based on Terraform modular approach which raises the level of abstraction and helps in organizing and maintaining your code, this is the way I'm going to pursue. We have 5 modules as below:

### Networking module:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This module defines main network resources needed like, vpc and its availability zones based on the selected region, internet gateway, routing tables, different subnets and security groups.

### Compute module:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This module defines resources of control planes and nodes. It contains all needed componenets from images, keys, IAM roles (as required by Kubernetes AWS Cloud Provider), instance profiles, lauch templates, autoscaling groups and its policy.

Similar to [Kubernetes Cluster Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler), AWS Autoscaling groups configured to automatically adjusts the size of the Kubernetes cluster across multi-zones using the "Target Tracking Scaling" which increase or decrease the current capacity of the group based on a target value for a specific metric. ASG health check type is configured to be on ELB not EC2s directly.

Both control planes and nodes have their own ASG with "Average CPU utilization" set to "target_value = 80.0". More info about Dynamic Scaling Polices [Here](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scale-based-on-demand.html)

Note: [Cluster Autoscalar on AWS](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/README.md) also works in a quite similar way.


### Load_Balancing module:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A load balancer serves as the single point of contact for clients. The load balancer distributes incoming traffic across multiple targets using listeners. A listener checks for connection requests from clients, using the protocol and port that you configure, and forwards requests to a target group, each target group routes requests to one or more registered targets, such as EC2 instances, using the TCP protocol and the port number that you specify.

So, Here I'm configuring 2 LBs, one for masters and the other for nodes, each is Network LB that makes routing decisions at the transport layer (TCP/SSL). Network LB are used to enable cross-zone load balancing.

Each LB has a listener checks on service ports, masters' listener checks on 6443 Kubernetes API server port and nodes' listener checks on 10250 kubelet API port and they both redirect traffic to the corresponding target groups. Masters' LB used to automate nodes' registration.


### Database module:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This module defines the RDS for PostgreSQL instance.
It's recommended to use PostgresQL over MySQL for better performance and avoiding lagging and hanging issues.
I'm using the free tier "db.t2.micro" class with web subnets only granted access and it behaves sufficient enough.
Confidential parameters such as username and password should be passed secretly through the "terraform.tfvars" file.

### Storage module:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In this module, I'm defining the EFS file system storage on AWS.

Natively, K3s comes with [Rancher’s Local Path Provisioner](https://github.com/rancher/local-path-provisioner) which provides a way for the Kubernetes users to utilize the local storage in each node. The Local Path Provisioner will create hostPath based persistent volume on the node. When deploying an application that needs to retain data while it spans across nodes, this solution won't be the right one.

Then, for dynamic provisioning, we might use:
* **Longhorn:** k3s supports Longhorn. Longhorn is an open-source distributed block storage system for Kubernetes but requires high resources.
* **Local NFS provisioner:** This provisioner includes a built in NFS server. It intiates a pod called "my-nfs-nfs-server-provisioner-0" and a service called "my-nfs-nfs-server-provisioner" as the NFS server. However it works but still data redundancy is at risk.
* **AWS EFS provisioner:** The efs-provisioner allows you to mount EFS storage as PersistentVolumes in kubernetes. It supports ReadWriteMany (RWX). 
It consists of a container that has access to an AWS EFS resource. The container reads a configmap which contains the EFS filesystem ID, the AWS region and the name you want to use for your efs-provisioner. And, It's accessible only from web subnets.



**Note:** Terraform, as of v0.9, offers locking remote state management. To get it up and running in AWS create a terraform s3 backend, an s3 bucket and a dynamDB table. This state file contains information about the infrastructure and configuration that terraform is managing. When working on a team, it is better to store this state file remotely so that more folks can access it to make changes to the infrastructure.


**Note:** Traefik Ingress is disables and NGINX Ingress is installed instead using Helm in the masters_userdata.tpl



## Usage
To be able to use this project, follow below steps:
- Clone this project on a machine with Terraform installed.  

&nbsp;&nbsp;&nbsp;&nbsp;**Note:** Tested versions are:\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Terraform v0.14.10\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+ provider registry.terraform.io/hashicorp/aws v3.42.0\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+ provider registry.terraform.io/hashicorp/random v3.1.0\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+ provider registry.terraform.io/hashicorp/template v2.2.0\

- Make sure to login to your AWS account with priviledged user where your credentials are stored in $HOME/.aws/credentials

- Create the S3 bucket with versioning & Object Lock allowed & DynamoDB table as described in backends.tf file.

- Pass your confidential data to terraform.tfvars file, required data as below:  \
access_ip         = ["<your_own_ip_address>"]  \
tfstate_s3_bucket = "<s3_bucket_name>"  \
db_name           = "<database_name>"  \
db_identifier     = "<database_identifier>"  \
db_port           = 5432    # Depends on DB engine used or custom port.  \
db_username       = "<database_username>"  \
db_password       = "<database_password>"  \
aws_region        = "<aws_region>"  \
vpc_cidr          = "<vpc_cidr>"  

- Double check values in main.tf file to make sure it fits your needs.

- Run terraform commands, terraform init, terraform validate, terraform plan & terraform apply --auto-approve and **within less than 10 minutes you'll have up and running kubernetes cluster.**

- Accessing the Cluster from Outside with kubectl. SSH to master machine, copy /etc/rancher/k3s/k3s.yaml on your machine located outside the cluster as ~/.kube/config. Then replace "127.0.0.1" with the "k3s-masters-lb_dns_name" you get as an output. Your local kubectl can now manage your K3s cluster on AWS.

- Once you're in, you'll find your CI **[Jenkins](https://github.com/jenkinsci/jenkins)** and CD **[ArgoCD](https://github.com/argoproj/argo-cd)** already installed and ready for use. Jenkins cloud could be configured to run you pipeline in pods inside your cluster and ArgoCD automates the deployment of the desired application states in the specified target environments.

- Enjoy deploying your application!
