# --- networking/main.tf ---


resource "aws_vpc" "k3s_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name                            = "k3s_vpc"
    "kubernetes.io/cluster/default" = "owned"
  }

  lifecycle {
    create_before_destroy = true
  }
}


data "aws_vpc" "vpc_id" {
  id = aws_vpc.k3s_vpc.id
}


data "aws_availability_zones" "azs" {
  state = "available"
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.k3s_vpc.id

  tags = {
    Name                            = "igw"
    "kubernetes.io/cluster/default" = "owned"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.k3s_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name                            = "public_rt"
    "kubernetes.io/cluster/default" = "owned"
  }
}


# This utilizes the default route table created automatically by aws when the VPC was created.
resource "aws_default_route_table" "default_private_rt" {
  default_route_table_id = aws_vpc.k3s_vpc.default_route_table_id

  tags = {
    Name                            = "default_private_rt"
    "kubernetes.io/cluster/default" = "owned"
  }

}


resource "random_shuffle" "azs" {
  input = local.azs
}


resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.k3s_vpc.id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = local.azs[count.index]

  tags = {
    Name                            = "private_subnet_${count.index + 1}"
    "kubernetes.io/cluster/default" = "owned"
  }

}


resource "aws_subnet" "db_private_subnets" {
  count             = length(var.db_private_subnets_cidr)
  vpc_id            = aws_vpc.k3s_vpc.id
  cidr_block        = var.db_private_subnets_cidr[count.index]
  availability_zone = local.azs[count.index]

  tags = {
    Name                            = "db_private_subnet_${count.index + 1}"
    "kubernetes.io/cluster/default" = "owned"
  }

}


resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnets_cidr)
  vpc_id                  = aws_vpc.k3s_vpc.id
  cidr_block              = var.public_subnets_cidr[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name                            = "public_subnet_${count.index + 1}"
    "kubernetes.io/cluster/default" = "owned"
    "kubernetes.io/role/elb"        = 1
  }

}


resource "aws_route_table_association" "public_subnets_rt_assoc" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = aws_subnet.public_subnets.*.id[count.index]
  route_table_id = aws_route_table.public_rt.id
}


# Advanced level of complexity is having all security groups defined in the local variable and iterate over all of them.
resource "aws_security_group" "sgs" {
  for_each    = local.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.k3s_vpc.id
  # tags        = each.value.tags.*.value

  # Using dynamic block to iterate over list of maps, each map contains all attributes of one ingress rule.
  dynamic "ingress" {
    for_each = each.value.ingress

    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      cidr_blocks = ingress.value.cidr_blocks
      protocol    = ingress.value.protocol
    }
  }

  # Using dynamic block to iterate over list of maps, each map contains all attributes of one egress rule.
  dynamic "egress" {
    for_each = each.value.egress

    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      cidr_blocks = egress.value.cidr_blocks
      protocol    = egress.value.protocol
    }
  }

  tags = {
    "kubernetes.io/cluster/default" = "owned"
  }
}


resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "db_subnet_group"
  subnet_ids  = aws_subnet.db_private_subnets.*.id
  description = "DB subnet group"

  tags = {
    Name                            = "db_subnet_group"
    "kubernetes.io/cluster/default" = "owned"
  }
}



# Define NACL
# NAT Gateway .. whenever needed.