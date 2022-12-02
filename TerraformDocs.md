<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_compute"></a> [compute](#module\_compute) | ./modules/compute | n/a |
| <a name="module_database"></a> [database](#module\_database) | ./modules/database | n/a |
| <a name="module_load_balancing"></a> [load\_balancing](#module\_load\_balancing) | ./modules/load_balancing | n/a |
| <a name="module_networking"></a> [networking](#module\_networking) | ./modules/networking | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ./modules/storage | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_ip"></a> [access\_ip](#input\_access\_ip) | This list shoud contains your IP addresses allowed for SSH access. | `list(any)` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | N. Virginia for the cheapest cost and most reliable US region. | `any` | n/a | yes |
| <a name="input_db_identifier"></a> [db\_identifier](#input\_db\_identifier) | n/a | `any` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | n/a | `any` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | n/a | `any` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | n/a | `any` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | n/a | `any` | n/a | yes |
| <a name="input_tfstate_s3_bucket"></a> [tfstate\_s3\_bucket](#input\_tfstate\_s3\_bucket) | n/a | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_instances_public_ips"></a> [ec2\_instances\_public\_ips](#output\_ec2\_instances\_public\_ips) | n/a |
| <a name="output_k3s-masters-lb_dns_name"></a> [k3s-masters-lb\_dns\_name](#output\_k3s-masters-lb\_dns\_name) | n/a |
<!-- END_TF_DOCS -->