# --- compute/main.tf ---

data "aws_ami" "ubuntu_20_04" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_key_pair" "ec2s_auth_key" {
  key_name   = var.asg_k3s_key_name
  public_key = file(var.asg_k3s_auth_key_path)

  tags = {
    Env  = "DevTest"
    Tier = "SSH_Key"
    Name = "ec2s_key"
  }
}


resource "random_password" "token" {
  length  = 50
  special = false
  upper   = true
  lower   = true
  number  = true
}


resource "aws_iam_role" "k3s_control_plane_iam_role" {
  name        = "k3s_control_plane_iam_role"
  description = "For the sake of Kubernetes AWS cloud provider, IAM role is needed to delegate EC2 instances to perform some tasks on behalf of the operator-like creating an ELB or an EBS volume"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  inline_policy {
    name = "k3s_control_plane_iam_policy"

    policy = jsonencode(
      {
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Action" : [
              "autoscaling:DescribeAutoScalingGroups",
              "autoscaling:DescribeLaunchConfigurations",
              "autoscaling:DescribeTags",
              "ec2:DescribeInstances",
              "ec2:DescribeRegions",
              "ec2:DescribeRouteTables",
              "ec2:DescribeSecurityGroups",
              "ec2:DescribeSubnets",
              "ec2:DescribeVolumes",
              "ec2:CreateSecurityGroup",
              "ec2:CreateTags",
              "ec2:CreateVolume",
              "ec2:ModifyInstanceAttribute",
              "ec2:ModifyVolume",
              "ec2:AttachVolume",
              "ec2:AuthorizeSecurityGroupIngress",
              "ec2:CreateRoute",
              "ec2:DeleteRoute",
              "ec2:DeleteSecurityGroup",
              "ec2:DeleteVolume",
              "ec2:DetachVolume",
              "ec2:RevokeSecurityGroupIngress",
              "ec2:DescribeVpcs",
              "elasticloadbalancing:AddTags",
              "elasticloadbalancing:AttachLoadBalancerToSubnets",
              "elasticloadbalancing:ApplySecurityGroupsToLoadBalancer",
              "elasticloadbalancing:CreateLoadBalancer",
              "elasticloadbalancing:CreateLoadBalancerPolicy",
              "elasticloadbalancing:CreateLoadBalancerListeners",
              "elasticloadbalancing:ConfigureHealthCheck",
              "elasticloadbalancing:DeleteLoadBalancer",
              "elasticloadbalancing:DeleteLoadBalancerListeners",
              "elasticloadbalancing:DescribeLoadBalancers",
              "elasticloadbalancing:DescribeLoadBalancerAttributes",
              "elasticloadbalancing:DetachLoadBalancerFromSubnets",
              "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
              "elasticloadbalancing:ModifyLoadBalancerAttributes",
              "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
              "elasticloadbalancing:SetLoadBalancerPoliciesForBackendServer",
              "elasticloadbalancing:AddTags",
              "elasticloadbalancing:CreateListener",
              "elasticloadbalancing:CreateTargetGroup",
              "elasticloadbalancing:DeleteListener",
              "elasticloadbalancing:DeleteTargetGroup",
              "elasticloadbalancing:DescribeListeners",
              "elasticloadbalancing:DescribeLoadBalancerPolicies",
              "elasticloadbalancing:DescribeTargetGroups",
              "elasticloadbalancing:DescribeTargetHealth",
              "elasticloadbalancing:ModifyListener",
              "elasticloadbalancing:ModifyTargetGroup",
              "elasticloadbalancing:RegisterTargets",
              "elasticloadbalancing:SetLoadBalancerPoliciesOfListener",
              "iam:CreateServiceLinkedRole",
              "kms:DescribeKey"
            ],
            "Resource" : [
              "*"
            ]
          }
        ]
      }
    )
  }

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "k3s_control_plane_iam_role"
    Tier = "IAM_Role"
    Env  = "DevTest"
  }
}


resource "aws_iam_instance_profile" "k3s_control_plane_iam_profile" {
  name = "k3s_control_plane_iam_profile"
  role = aws_iam_role.k3s_control_plane_iam_role.name

  tags = {
    Name = "k3s_control_plane_iam_profile"
    Tier = "IAM_EC2_Profile"
    Env  = "DevTest"
  }
}


resource "aws_iam_role" "k3s_minion_worker_node_iam_role" {
  name        = "k3s_minion_worker_node_iam_role"
  description = "For the sake of Kubernetes AWS cloud provider, IAM role is needed to delegate EC2 instances to perform some tasks on behalf of the operator-like creating an ELB or an EBS volume"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  inline_policy {
    name = "k3s_minion_worker_node_iam_policy"

    policy = jsonencode(
      {
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Action" : [
              "ec2:DescribeInstances",
              "ec2:DescribeRegions",
              "ecr:GetAuthorizationToken",
              "ecr:BatchCheckLayerAvailability",
              "ecr:GetDownloadUrlForLayer",
              "ecr:GetRepositoryPolicy",
              "ecr:DescribeRepositories",
              "ecr:ListImages",
              "ecr:BatchGetImage"
            ],
            "Resource" : ["*"]
          }
        ]
    })
  }

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "k3s_minion_worker_node_iam_role"
    Tier = "IAM_Role"
    Env  = "DevTest"
  }
}


resource "aws_iam_instance_profile" "k3s_minion_worker_node_iam_profile" {
  name = "k3s_minion_worker_node_iam_profile"
  role = aws_iam_role.k3s_minion_worker_node_iam_role.name

  tags = {
    Name = "k3s_minion_worker_node_iam_profile"
    Tier = "IAM_EC2_Profile"
    Env  = "DevTest"
  }
}


resource "random_integer" "random" {
  min = 1
  max = 100
}


resource "aws_launch_template" "k3s_control_plane_launch_temp" {
  name          = "k3s_control_plane_launch_temp"
  instance_type = var.asg_k3s_control_plane_instance_type
  image_id      = data.aws_ami.ubuntu_20_04.id
  key_name      = var.asg_k3s_key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.k3s_control_plane_iam_profile.name
  }

  user_data = base64encode(
    templatefile(var.asg_k3s_control_plane_userdata_tpl_path,
      {
        nodename    = "k3s_master_${random_integer.random.result}"
        token       = local.token
        db_endpoint = var.db_endpoint
        dbname      = var.dbname
        dbuser      = var.dbuser
        dbpass      = var.dbpass
        lb_dns_name = var.lb_dns_name
        aws_region  = var.aws_region
        efs_id      = var.efs_id
    })
  )

  ebs_optimized = var.k3s_control_plane_ebs_optimized

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 15
    }
  }

  monitoring {
    enabled = var.k3s_control_plane_monitoring
  }

  network_interfaces {
    security_groups             = var.asg_k3s_control_plane_security_group_ids
    associate_public_ip_address = var.asg_k3s_control_plane_associate_public_ip_address
  }

  tag_specifications {
    resource_type = "instance" #instance or volume

    tags = {
      Name                            = "k3s_master_${random_integer.random.result}"
      Tier                            = "Compute"
      Env                             = "DevTest"
      "kubernetes.io/cluster/default" = "owned"
      k8s-control-plane = ""
    }
  }

  tag_specifications {
    resource_type = "volume" #instance or volume

    tags = {
      Name = "vol"
      Tier = "Volume"
      Env  = "DevTest"
    }
  }

}


resource "aws_autoscaling_group" "k3s_control_plane_asg" {
  depends_on          = [var.efs_id]
  name                = "k3s_control_plane_asg"
  max_size            = var.asg_k3s_control_plane_max_count
  min_size            = var.asg_k3s_control_plane_min_count
  desired_capacity    = var.asg_k3s_control_plane_desired_count
  vpc_zone_identifier = var.asg_k3s_control_plane_subnet_ids

  target_group_arns   = var.asg_k3s_control_plane_lb_target_group_arns

  launch_template {
    name    = aws_launch_template.k3s_control_plane_launch_temp.name
    version = "$Latest"
  }


  health_check_type         = var.asg_k3s_control_plane_health_check_type
  health_check_grace_period = var.asg_k3s_control_plane_health_check_grace_period
  force_delete              = var.asg_k3s_control_plane_force_delete
  termination_policies      = var.asg_k3s_control_plane_termination_policies
  default_cooldown          = var.asg_k3s_control_plane_default_cooldown
  protect_from_scale_in     = var.asg_k3s_control_plane_protect_from_scale_in
}


resource "aws_autoscaling_policy" "k3s_masters_auto_scaling_policy" {
  name                   = "k3s_masters_auto_scaling_policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.k3s_control_plane_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 80.0
  }
}


data "aws_instances" "ec2_instances_public_ips" {
  depends_on = [aws_autoscaling_group.k3s_control_plane_asg]
  instance_tags = {
    Tier = "Compute"
  }

  filter {
    name   = "instance.group-name"
    values = ["web_sg"]
  }

}


resource "aws_launch_template" "k3s_nodes_launch_temp" {
  name          = "k3s_nodes_launch_temp"
  instance_type = var.asg_k3s_nodes_instance_type
  image_id      = data.aws_ami.ubuntu_20_04.id
  key_name      = var.asg_k3s_key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.k3s_minion_worker_node_iam_profile.name
  }

  user_data = base64encode(
    templatefile(var.asg_k3s_nodes_userdata_tpl_path,
      {
        lb_dns_name = var.lb_dns_name,
        token       = local.token,
    })
  )

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 15
    }
  }

  ebs_optimized = var.asg_k3s_nodes_ebs_optimized

  monitoring {
    enabled = var.asg_k3s_nodes_monitoring
  }

  network_interfaces {
    security_groups             = var.asg_k3s_nodes_security_group_ids
    associate_public_ip_address = var.asg_k3s_nodes_associate_public_ip_address
  }

  tag_specifications {
    resource_type = "instance" #instance or volume

    tags = {
      Name                            = "k3s_nodes_${random_integer.random.result}"
      Tier                            = "Compute"
      Env                             = "DevTest"
      "kubernetes.io/cluster/default" = "owned"
    }
  }

  tag_specifications {
    resource_type = "volume" #instance or volume

    tags = {
      Name = "vol"
      Tier = "Volume"
      Env  = "DevTest"
    }
  }

}


resource "aws_autoscaling_group" "k3s_nodes_asg" {
  depends_on          = [var.efs_id]
  name                = "k3s_nodes_asg"
  max_size            = var.asg_k3s_nodes_max_count
  min_size            = var.asg_k3s_nodes_min_count
  desired_capacity    = var.asg_k3s_nodes_desired_count
  vpc_zone_identifier = var.asg_k3s_nodes_subnet_ids

  target_group_arns   = var.asg_k3s_nodes_lb_target_group_arns

  launch_template {
    name    = aws_launch_template.k3s_nodes_launch_temp.name
    version = "$Latest"
  }

  health_check_type         = var.asg_k3s_nodes_health_check_type
  health_check_grace_period = var.asg_k3s_nodes_health_check_grace_period
  default_cooldown          = var.asg_k3s_nodes_default_cooldown
  force_delete              = var.asg_k3s_nodes_force_delete
  termination_policies      = var.asg_k3s_nodes_termination_policies
  protect_from_scale_in     = var.asg_k3s_nodes_protect_from_scale_in
}


resource "aws_autoscaling_policy" "k3s_nodes_auto_scaling_policy" {
  name                   = "k3s_nodes_auto_scaling_policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.k3s_nodes_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 80.0
  }
}