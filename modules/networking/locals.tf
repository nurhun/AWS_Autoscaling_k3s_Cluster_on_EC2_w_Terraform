# --- networking/locals.tf ---

locals {
  azs = data.aws_availability_zones.azs.names
  security_groups = {
    web_sg = {
      name        = "web_sg"
      description = "Allow web traffic"
      vpc_id      = aws_vpc.k3s_vpc.id
      ingress = [
        {
          description = "TLS from world"
          from_port   = 443
          to_port     = 443
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "HTTP from world"
          from_port   = 80
          to_port     = 80
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "SSH from world :D"
          from_port   = 22
          to_port     = 22
          protocol    = "TCP"
          cidr_blocks = var.access_ip
        },
        {
          description = "Kubernetes API server from world"
          from_port   = 6443
          to_port     = 6443
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Node driver Docker daemon TLS port"
          from_port   = 2376
          to_port     = 2376
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Canal/Flannel VXLAN overlay networking"
          from_port   = 8472
          to_port     = 8472
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Rancher webhook"
          from_port   = 8443
          to_port     = 8443
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Rancher webhook"
          from_port   = 9443
          to_port     = 9443
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Canal/Flannel livenessProbe/readinessProbe"
          from_port   = 9099
          to_port     = 9099
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Default port required by Monitoring to scrape metrics from Linux node-exporters"
          from_port   = 9100
          to_port     = 9100
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "kubelet API"
          from_port   = 10250
          to_port     = 10250
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "kube-scheduler"
          from_port   = 10251
          to_port     = 10251
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "kube-controller-manager"
          from_port   = 10252
          to_port     = 10252
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Ingress controller livenessProbe/readinessProbe"
          from_port   = 10254
          to_port     = 10254
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Kubelet health check"
          from_port   = 10256
          to_port     = 10256
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Kubernetes NodePort range"
          from_port   = 30000
          to_port     = 32767
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Kubernetes NodePort range"
          from_port   = 30000
          to_port     = 32767
          protocol    = "UDP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "odoo instance"
          from_port   = 8069
          to_port     = 8069
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Prometheus"
          from_port   = 9090
          to_port     = 9090
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Grafana"
          from_port   = 3000
          to_port     = 3000
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "ArgoCD custom port"
          from_port   = 7080
          to_port     = 7080
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "Ingress self"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          self        = true
          cidr_blocks = [var.vpc_cidr]
        }
      ]
      egress = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
      tags = [
        {
          "kubernetes.io/cluster/default" = "owned"
        }
      ]
    }

    db_sg = {
      name        = "db_sg"
      description = "Allow DB traffic"
      vpc_id      = aws_vpc.k3s_vpc.id
      ingress = [
        {
          description = "SQL allowed"
          from_port   = 3306
          to_port     = 3306
          protocol    = "TCP"
          cidr_blocks = aws_subnet.public_subnets.*.cidr_block
        },
        {
          description = "PSQL allowed"
          from_port   = 5432
          to_port     = 5432
          protocol    = "TCP"
          cidr_blocks = aws_subnet.public_subnets.*.cidr_block
        },
        {
          description = "Ingress self"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          self        = true
          cidr_blocks = [var.vpc_cidr]
        }
      ]
      egress = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }

    efs_sg = {
      name            = "efs_sg"
      description     = "Allow NFS traffic"
      vpc_id          = aws_vpc.k3s_vpc.id
      ingress = [
        {
          description = "NFS from web_sg_subnets"
          from_port   = 2049
          to_port     = 2049
          protocol    = "TCP"
          cidr_blocks = aws_subnet.public_subnets.*.cidr_block
        },
      ]
      egress = [
        {
          description = "NFS to web_sg_subnets"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = aws_subnet.public_subnets.*.cidr_block
        }
      ]
    }
  }
}