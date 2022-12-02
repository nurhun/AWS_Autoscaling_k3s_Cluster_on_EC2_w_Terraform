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
| [aws_efs_file_system.k3s_pvs_store](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.efs_targets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_efs_encrypted"></a> [efs\_encrypted](#input\_efs\_encrypted) | n/a | `any` | n/a | yes |
| <a name="input_efs_lifecycle_policy"></a> [efs\_lifecycle\_policy](#input\_efs\_lifecycle\_policy) | A value that describes the period of time that a file is not accessed, after which it transitions to the IA storage class. Valid Values: AFTER\_7\_DAYS \| AFTER\_14\_DAYS \| AFTER\_30\_DAYS \| AFTER\_60\_DAYS \| AFTER\_90\_DAYS | `any` | n/a | yes |
| <a name="input_efs_performance_mode"></a> [efs\_performance\_mode](#input\_efs\_performance\_mode) | The file system performance mode. Can be either 'generalPurpose' or 'maxIO' (Default: 'generalPurpose'). | `any` | n/a | yes |
| <a name="input_efs_private_subnets"></a> [efs\_private\_subnets](#input\_efs\_private\_subnets) | n/a | `any` | n/a | yes |
| <a name="input_efs_security_groups"></a> [efs\_security\_groups](#input\_efs\_security\_groups) | n/a | `any` | n/a | yes |
| <a name="input_efs_throughput_mode"></a> [efs\_throughput\_mode](#input\_efs\_throughput\_mode) | Defaults to bursting. Valid values: bursting, provisioned. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_id"></a> [efs\_id](#output\_efs\_id) | n/a |
<!-- END_TF_DOCS -->