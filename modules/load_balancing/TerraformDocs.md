<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb.k3s-masters-lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb.k3s-nodes-lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.k3s-masters-lb-backend-listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.k3s_nodes_lb_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.k3s-masters-int-lb-tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.k3s-nodes-int-lb-tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k3s_masters_int_lb_listener_port"></a> [k3s\_masters\_int\_lb\_listener\_port](#input\_k3s\_masters\_int\_lb\_listener\_port) | n/a | `any` | n/a | yes |
| <a name="input_k3s_masters_int_lb_listener_protocol"></a> [k3s\_masters\_int\_lb\_listener\_protocol](#input\_k3s\_masters\_int\_lb\_listener\_protocol) | n/a | `any` | n/a | yes |
| <a name="input_k3s_masters_int_lb_tg_hlth_ck_enabled"></a> [k3s\_masters\_int\_lb\_tg\_hlth\_ck\_enabled](#input\_k3s\_masters\_int\_lb\_tg\_hlth\_ck\_enabled) | n/a | `any` | n/a | yes |
| <a name="input_k3s_masters_int_lb_tg_hlth_ck_healthy_threshold"></a> [k3s\_masters\_int\_lb\_tg\_hlth\_ck\_healthy\_threshold](#input\_k3s\_masters\_int\_lb\_tg\_hlth\_ck\_healthy\_threshold) | n/a | `any` | n/a | yes |
| <a name="input_k3s_masters_int_lb_tg_hlth_ck_interval"></a> [k3s\_masters\_int\_lb\_tg\_hlth\_ck\_interval](#input\_k3s\_masters\_int\_lb\_tg\_hlth\_ck\_interval) | n/a | `any` | n/a | yes |
| <a name="input_k3s_masters_int_lb_tg_hlth_ck_unhealthy_threshold"></a> [k3s\_masters\_int\_lb\_tg\_hlth\_ck\_unhealthy\_threshold](#input\_k3s\_masters\_int\_lb\_tg\_hlth\_ck\_unhealthy\_threshold) | n/a | `any` | n/a | yes |
| <a name="input_k3s_masters_int_lb_tg_port"></a> [k3s\_masters\_int\_lb\_tg\_port](#input\_k3s\_masters\_int\_lb\_tg\_port) | n/a | `any` | n/a | yes |
| <a name="input_k3s_masters_int_lb_tg_protocol"></a> [k3s\_masters\_int\_lb\_tg\_protocol](#input\_k3s\_masters\_int\_lb\_tg\_protocol) | n/a | `any` | n/a | yes |
| <a name="input_k3s_masters_lb_enable_cross_zone_load_balancing"></a> [k3s\_masters\_lb\_enable\_cross\_zone\_load\_balancing](#input\_k3s\_masters\_lb\_enable\_cross\_zone\_load\_balancing) | "If true, cross-zone load balancing of the load balancer will be enabled.<br>   This is a network load balancer feature.<br>   Defaults to false." | `string` | n/a | yes |
| <a name="input_k3s_masters_lb_enable_deletion_protection"></a> [k3s\_masters\_lb\_enable\_deletion\_protection](#input\_k3s\_masters\_lb\_enable\_deletion\_protection) | If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false | `any` | n/a | yes |
| <a name="input_k3s_masters_lb_internal"></a> [k3s\_masters\_lb\_internal](#input\_k3s\_masters\_lb\_internal) | n/a | `any` | n/a | yes |
| <a name="input_k3s_masters_lb_subnets"></a> [k3s\_masters\_lb\_subnets](#input\_k3s\_masters\_lb\_subnets) | n/a | `any` | n/a | yes |
| <a name="input_k3s_masters_lb_type"></a> [k3s\_masters\_lb\_type](#input\_k3s\_masters\_lb\_type) | n/a | `any` | n/a | yes |
| <a name="input_k3s_nodes_int_lb_listener_port"></a> [k3s\_nodes\_int\_lb\_listener\_port](#input\_k3s\_nodes\_int\_lb\_listener\_port) | n/a | `any` | n/a | yes |
| <a name="input_k3s_nodes_int_lb_listener_protocol"></a> [k3s\_nodes\_int\_lb\_listener\_protocol](#input\_k3s\_nodes\_int\_lb\_listener\_protocol) | n/a | `any` | n/a | yes |
| <a name="input_k3s_nodes_int_lb_tg_hlth_ck_enabled"></a> [k3s\_nodes\_int\_lb\_tg\_hlth\_ck\_enabled](#input\_k3s\_nodes\_int\_lb\_tg\_hlth\_ck\_enabled) | n/a | `any` | n/a | yes |
| <a name="input_k3s_nodes_int_lb_tg_hlth_ck_healthy_threshold"></a> [k3s\_nodes\_int\_lb\_tg\_hlth\_ck\_healthy\_threshold](#input\_k3s\_nodes\_int\_lb\_tg\_hlth\_ck\_healthy\_threshold) | n/a | `any` | n/a | yes |
| <a name="input_k3s_nodes_int_lb_tg_hlth_ck_interval"></a> [k3s\_nodes\_int\_lb\_tg\_hlth\_ck\_interval](#input\_k3s\_nodes\_int\_lb\_tg\_hlth\_ck\_interval) | n/a | `any` | n/a | yes |
| <a name="input_k3s_nodes_int_lb_tg_hlth_ck_unhealthy_threshold"></a> [k3s\_nodes\_int\_lb\_tg\_hlth\_ck\_unhealthy\_threshold](#input\_k3s\_nodes\_int\_lb\_tg\_hlth\_ck\_unhealthy\_threshold) | n/a | `any` | n/a | yes |
| <a name="input_k3s_nodes_int_lb_tg_port"></a> [k3s\_nodes\_int\_lb\_tg\_port](#input\_k3s\_nodes\_int\_lb\_tg\_port) | n/a | `any` | n/a | yes |
| <a name="input_k3s_nodes_int_lb_tg_protocol"></a> [k3s\_nodes\_int\_lb\_tg\_protocol](#input\_k3s\_nodes\_int\_lb\_tg\_protocol) | n/a | `any` | n/a | yes |
| <a name="input_k3s_nodes_lb_enable_cross_zone_load_balancing"></a> [k3s\_nodes\_lb\_enable\_cross\_zone\_load\_balancing](#input\_k3s\_nodes\_lb\_enable\_cross\_zone\_load\_balancing) | "If true, cross-zone load balancing of the load balancer will be enabled.<br>   This is a network load balancer feature.<br>   Defaults to false." | `string` | n/a | yes |
| <a name="input_k3s_nodes_lb_enable_deletion_protection"></a> [k3s\_nodes\_lb\_enable\_deletion\_protection](#input\_k3s\_nodes\_lb\_enable\_deletion\_protection) | n/a | `any` | n/a | yes |
| <a name="input_k3s_nodes_lb_internal"></a> [k3s\_nodes\_lb\_internal](#input\_k3s\_nodes\_lb\_internal) | n/a | `any` | n/a | yes |
| <a name="input_k3s_nodes_lb_subnets"></a> [k3s\_nodes\_lb\_subnets](#input\_k3s\_nodes\_lb\_subnets) | n/a | `any` | n/a | yes |
| <a name="input_k3s_nodes_lb_type"></a> [k3s\_nodes\_lb\_type](#input\_k3s\_nodes\_lb\_type) | n/a | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k3s-lb_dns_name"></a> [k3s-lb\_dns\_name](#output\_k3s-lb\_dns\_name) | n/a |
| <a name="output_k3s-masters-int-lb-tg-arn"></a> [k3s-masters-int-lb-tg-arn](#output\_k3s-masters-int-lb-tg-arn) | n/a |
| <a name="output_k3s-nodes-int-lb-tg-arn"></a> [k3s-nodes-int-lb-tg-arn](#output\_k3s-nodes-int-lb-tg-arn) | n/a |
<!-- END_TF_DOCS -->