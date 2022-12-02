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
| [aws_autoscaling_group.k3s_control_plane_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_group.k3s_nodes_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.k3s_masters_auto_scaling_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_policy.k3s_nodes_auto_scaling_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_iam_instance_profile.k3s_control_plane_iam_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.k3s_minion_worker_node_iam_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.k3s_control_plane_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.k3s_minion_worker_node_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_key_pair.ec2s_auth_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_launch_template.k3s_control_plane_launch_temp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_launch_template.k3s_nodes_launch_temp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [random_integer.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [random_password.token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_ami.ubuntu_20_04](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_instances.ec2_instances_public_ips](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_k3s_auth_key_path"></a> [asg\_k3s\_auth\_key\_path](#input\_asg\_k3s\_auth\_key\_path) | The path to the public key generated on our local machine. | `string` | n/a | yes |
| <a name="input_asg_k3s_control_plane_associate_public_ip_address"></a> [asg\_k3s\_control\_plane\_associate\_public\_ip\_address](#input\_asg\_k3s\_control\_plane\_associate\_public\_ip\_address) | Whether to associate a public IP address with an instance in a VPC. | `string` | n/a | yes |
| <a name="input_asg_k3s_control_plane_default_cooldown"></a> [asg\_k3s\_control\_plane\_default\_cooldown](#input\_asg\_k3s\_control\_plane\_default\_cooldown) | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start. | `any` | n/a | yes |
| <a name="input_asg_k3s_control_plane_desired_count"></a> [asg\_k3s\_control\_plane\_desired\_count](#input\_asg\_k3s\_control\_plane\_desired\_count) | The number of Amazon EC2 instances that should be running in the group. | `any` | n/a | yes |
| <a name="input_asg_k3s_control_plane_force_delete"></a> [asg\_k3s\_control\_plane\_force\_delete](#input\_asg\_k3s\_control\_plane\_force\_delete) | Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate. Normally, Terraform drains all the instances before deleting the group. | `any` | n/a | yes |
| <a name="input_asg_k3s_control_plane_health_check_grace_period"></a> [asg\_k3s\_control\_plane\_health\_check\_grace\_period](#input\_asg\_k3s\_control\_plane\_health\_check\_grace\_period) | Time (in seconds) after instance comes into service before checking health. Default: 300 | `any` | n/a | yes |
| <a name="input_asg_k3s_control_plane_health_check_type"></a> [asg\_k3s\_control\_plane\_health\_check\_type](#input\_asg\_k3s\_control\_plane\_health\_check\_type) | EC2 or ELB. Controls how health checking is done. | `any` | n/a | yes |
| <a name="input_asg_k3s_control_plane_instance_type"></a> [asg\_k3s\_control\_plane\_instance\_type](#input\_asg\_k3s\_control\_plane\_instance\_type) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_control_plane_lb_target_group_arns"></a> [asg\_k3s\_control\_plane\_lb\_target\_group\_arns](#input\_asg\_k3s\_control\_plane\_lb\_target\_group\_arns) | A set of aws\_alb\_target\_group ARNs, for use with Application or Network Load Balancing. | `any` | n/a | yes |
| <a name="input_asg_k3s_control_plane_max_count"></a> [asg\_k3s\_control\_plane\_max\_count](#input\_asg\_k3s\_control\_plane\_max\_count) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_control_plane_min_count"></a> [asg\_k3s\_control\_plane\_min\_count](#input\_asg\_k3s\_control\_plane\_min\_count) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_control_plane_protect_from_scale_in"></a> [asg\_k3s\_control\_plane\_protect\_from\_scale\_in](#input\_asg\_k3s\_control\_plane\_protect\_from\_scale\_in) | If enabled, newly launched instances will be protected from scale in by default. It won't remove instances added by scale out. | `any` | n/a | yes |
| <a name="input_asg_k3s_control_plane_security_group_ids"></a> [asg\_k3s\_control\_plane\_security\_group\_ids](#input\_asg\_k3s\_control\_plane\_security\_group\_ids) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_control_plane_subnet_ids"></a> [asg\_k3s\_control\_plane\_subnet\_ids](#input\_asg\_k3s\_control\_plane\_subnet\_ids) | A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with availability\_zones. | `any` | n/a | yes |
| <a name="input_asg_k3s_control_plane_termination_policies"></a> [asg\_k3s\_control\_plane\_termination\_policies](#input\_asg\_k3s\_control\_plane\_termination\_policies) | termination\_policies (Optional) A list of policies to decide how the instances in the Auto Scaling Group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, OldestLaunchTemplate, AllocationStrategy, Default. | `any` | n/a | yes |
| <a name="input_asg_k3s_control_plane_userdata_tpl_path"></a> [asg\_k3s\_control\_plane\_userdata\_tpl\_path](#input\_asg\_k3s\_control\_plane\_userdata\_tpl\_path) | path of userdata.tpl file in our main root directory | `string` | n/a | yes |
| <a name="input_asg_k3s_key_name"></a> [asg\_k3s\_key\_name](#input\_asg\_k3s\_key\_name) | The name for the key pair. | `string` | n/a | yes |
| <a name="input_asg_k3s_nodes_associate_public_ip_address"></a> [asg\_k3s\_nodes\_associate\_public\_ip\_address](#input\_asg\_k3s\_nodes\_associate\_public\_ip\_address) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_default_cooldown"></a> [asg\_k3s\_nodes\_default\_cooldown](#input\_asg\_k3s\_nodes\_default\_cooldown) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_desired_count"></a> [asg\_k3s\_nodes\_desired\_count](#input\_asg\_k3s\_nodes\_desired\_count) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_ebs_optimized"></a> [asg\_k3s\_nodes\_ebs\_optimized](#input\_asg\_k3s\_nodes\_ebs\_optimized) | variable "asg\_k3s\_key\_name" {} | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_force_delete"></a> [asg\_k3s\_nodes\_force\_delete](#input\_asg\_k3s\_nodes\_force\_delete) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_health_check_grace_period"></a> [asg\_k3s\_nodes\_health\_check\_grace\_period](#input\_asg\_k3s\_nodes\_health\_check\_grace\_period) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_health_check_type"></a> [asg\_k3s\_nodes\_health\_check\_type](#input\_asg\_k3s\_nodes\_health\_check\_type) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_instance_type"></a> [asg\_k3s\_nodes\_instance\_type](#input\_asg\_k3s\_nodes\_instance\_type) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_lb_target_group_arns"></a> [asg\_k3s\_nodes\_lb\_target\_group\_arns](#input\_asg\_k3s\_nodes\_lb\_target\_group\_arns) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_max_count"></a> [asg\_k3s\_nodes\_max\_count](#input\_asg\_k3s\_nodes\_max\_count) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_min_count"></a> [asg\_k3s\_nodes\_min\_count](#input\_asg\_k3s\_nodes\_min\_count) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_monitoring"></a> [asg\_k3s\_nodes\_monitoring](#input\_asg\_k3s\_nodes\_monitoring) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_protect_from_scale_in"></a> [asg\_k3s\_nodes\_protect\_from\_scale\_in](#input\_asg\_k3s\_nodes\_protect\_from\_scale\_in) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_security_group_ids"></a> [asg\_k3s\_nodes\_security\_group\_ids](#input\_asg\_k3s\_nodes\_security\_group\_ids) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_subnet_ids"></a> [asg\_k3s\_nodes\_subnet\_ids](#input\_asg\_k3s\_nodes\_subnet\_ids) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_termination_policies"></a> [asg\_k3s\_nodes\_termination\_policies](#input\_asg\_k3s\_nodes\_termination\_policies) | n/a | `any` | n/a | yes |
| <a name="input_asg_k3s_nodes_userdata_tpl_path"></a> [asg\_k3s\_nodes\_userdata\_tpl\_path](#input\_asg\_k3s\_nodes\_userdata\_tpl\_path) | n/a | `any` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `any` | n/a | yes |
| <a name="input_db_endpoint"></a> [db\_endpoint](#input\_db\_endpoint) | n/a | `any` | n/a | yes |
| <a name="input_dbname"></a> [dbname](#input\_dbname) | n/a | `any` | n/a | yes |
| <a name="input_dbpass"></a> [dbpass](#input\_dbpass) | n/a | `any` | n/a | yes |
| <a name="input_dbuser"></a> [dbuser](#input\_dbuser) | n/a | `any` | n/a | yes |
| <a name="input_efs_id"></a> [efs\_id](#input\_efs\_id) | n/a | `any` | n/a | yes |
| <a name="input_k3s_control_plane_ebs_optimized"></a> [k3s\_control\_plane\_ebs\_optimized](#input\_k3s\_control\_plane\_ebs\_optimized) | EBS–optimized instance provides additional, dedicated capacity for Amazon EBS I/O | `any` | n/a | yes |
| <a name="input_k3s_control_plane_monitoring"></a> [k3s\_control\_plane\_monitoring](#input\_k3s\_control\_plane\_monitoring) | If true, the launched EC2 instance will have detailed monitoring enabled. | `string` | n/a | yes |
| <a name="input_lb_dns_name"></a> [lb\_dns\_name](#input\_lb\_dns\_name) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_instances_public_ips"></a> [ec2\_instances\_public\_ips](#output\_ec2\_instances\_public\_ips) | n/a |
| <a name="output_k3s_controle_plane_public_ip_1"></a> [k3s\_controle\_plane\_public\_ip\_1](#output\_k3s\_controle\_plane\_public\_ip\_1) | n/a |
<!-- END_TF_DOCS -->