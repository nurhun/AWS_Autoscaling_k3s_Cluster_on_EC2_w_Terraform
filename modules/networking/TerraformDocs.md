<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.db_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_default_route_table.default_private_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route_table.public_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.public_subnets_rt_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.sgs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.db_private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.k3s_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [random_shuffle.azs](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle) | resource |
| [aws_availability_zones.azs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_vpc.vpc_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_ip"></a> [access\_ip](#input\_access\_ip) | This list shoud contains your IP addresses allowed for SSH access. | `list(any)` | n/a | yes |
| <a name="input_db_private_subnets_cidr"></a> [db\_private\_subnets\_cidr](#input\_db\_private\_subnets\_cidr) | CIDR blocks of db private subnets, it's a list of strings. | `list(any)` | n/a | yes |
| <a name="input_private_subnets_cidr"></a> [private\_subnets\_cidr](#input\_private\_subnets\_cidr) | CIDR blocks of private subnets, it's a list of strings. | `list(any)` | n/a | yes |
| <a name="input_public_subnets_cidr"></a> [public\_subnets\_cidr](#input\_public\_subnets\_cidr) | CIDR blocks of public subnets, it's a list of strings. | `list(any)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azs"></a> [azs](#output\_azs) | n/a |
| <a name="output_azs_no"></a> [azs\_no](#output\_azs\_no) | n/a |
| <a name="output_db_sg_id"></a> [db\_sg\_id](#output\_db\_sg\_id) | n/a |
| <a name="output_db_subnet_group_id"></a> [db\_subnet\_group\_id](#output\_db\_subnet\_group\_id) | n/a |
| <a name="output_db_subnet_group_name"></a> [db\_subnet\_group\_name](#output\_db\_subnet\_group\_name) | n/a |
| <a name="output_efs_sg_id"></a> [efs\_sg\_id](#output\_efs\_sg\_id) | n/a |
| <a name="output_preferred_public_subnet_az"></a> [preferred\_public\_subnet\_az](#output\_preferred\_public\_subnet\_az) | n/a |
| <a name="output_preferred_public_subnet_id"></a> [preferred\_public\_subnet\_id](#output\_preferred\_public\_subnet\_id) | n/a |
| <a name="output_private_subnets_ids"></a> [private\_subnets\_ids](#output\_private\_subnets\_ids) | n/a |
| <a name="output_public_subnets_cidrs"></a> [public\_subnets\_cidrs](#output\_public\_subnets\_cidrs) | n/a |
| <a name="output_public_subnets_ids"></a> [public\_subnets\_ids](#output\_public\_subnets\_ids) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
| <a name="output_web_sg_id"></a> [web\_sg\_id](#output\_web\_sg\_id) | n/a |
<!-- END_TF_DOCS -->