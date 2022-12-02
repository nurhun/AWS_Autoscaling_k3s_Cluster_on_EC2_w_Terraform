# --- networking/variables.tf ---

variable "vpc_cidr" {
  type = string
  #   default = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR blocks of public subnets, it's a list of strings."
}

# variable "preferred_az" {}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR blocks of private subnets, it's a list of strings."
}

variable "db_private_subnets_cidr" {
  type        = list(any)
  description = "CIDR blocks of db private subnets, it's a list of strings."
}

variable "access_ip" {
  type        = list(any)
  description = "This list shoud contains your IP addresses allowed for SSH access."
}

# variable "web_sg_id" {
#   # default = aws_security_group.sgs["web_sg"].id
# }

