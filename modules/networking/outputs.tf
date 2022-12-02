# --- networking/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.k3s_vpc.id
}

output "azs_no" {
  value = length(data.aws_availability_zones.azs.id)
}

output "azs" {
  value = data.aws_availability_zones.azs.names
}

# output "routes" {
#   value = "aws_route_table.public_rt.route"
# }


output "preferred_public_subnet_id" {
  value = aws_subnet.public_subnets[0].id
}



output "preferred_public_subnet_az" {
  value = aws_subnet.public_subnets[0].availability_zone
}


output "public_subnets_ids" {
  value = aws_subnet.public_subnets.*.id
}


output "private_subnets_ids" {
  value = aws_subnet.private_subnets.*.id
}


output "public_subnets_cidrs" {
  value = aws_subnet.public_subnets.*.cidr_block
}



output "db_subnet_group_name" {
  value = aws_db_subnet_group.db_subnet_group.name
}


output "db_subnet_group_id" {
  value = aws_db_subnet_group.db_subnet_group.id
}


output "db_sg_id" {
  value = aws_security_group.sgs["db_sg"].id
}


output "web_sg_id" {
  value = aws_security_group.sgs["web_sg"].id
}


output "efs_sg_id" {
  value = aws_security_group.sgs["efs_sg"].id
}

