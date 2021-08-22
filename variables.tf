# --- root/variables.tf ---

variable "aws_region" {
  # default     = "us-east-1"
  description = "N. Virginia for the cheapest cost and most reliable US region."
}

variable "vpc_cidr" {}

# variable "aws_region" {
#   default     = "eu-north-1"
#   description = "Stockholm as it provides t3.micro Free tier with 2vCPU & 1GiB instead of typical t2.micro of 1vCPU & 1GiB."
# }


# variable "azs" {
#   # default = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
#   # default = ""
#   default = null
# }

# variable "preferred_az" {
#   type    = string
#   default = "eu-north-1a"
# }


# variable "web_sg_id" {
#   # default = aws_security_group.sgs["web_sg"].id
# }

variable "access_ip" {
  type = list(any)
  #default     = ["0.0.0.0/0"]
  description = "This list shoud contains your IP addresses allowed for SSH access."
}

variable "tfstate_s3_bucket" {
  sensitive = true
}

variable "db_port" {
  sensitive = true
}

variable "db_name" {
  sensitive = true
}

variable "db_identifier" {
  sensitive = true
}

variable "db_username" {
  sensitive = true
}
variable "db_password" {
  sensitive = true
}