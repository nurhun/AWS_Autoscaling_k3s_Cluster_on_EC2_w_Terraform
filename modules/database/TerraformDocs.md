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
| [aws_db_instance.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_allocated_storage"></a> [db\_allocated\_storage](#input\_db\_allocated\_storage) | n/a | `number` | n/a | yes |
| <a name="input_db_allow_major_version_upgrade"></a> [db\_allow\_major\_version\_upgrade](#input\_db\_allow\_major\_version\_upgrade) | n/a | `any` | n/a | yes |
| <a name="input_db_apply_immediately"></a> [db\_apply\_immediately](#input\_db\_apply\_immediately) | n/a | `any` | n/a | yes |
| <a name="input_db_auto_minor_version_upgrade"></a> [db\_auto\_minor\_version\_upgrade](#input\_db\_auto\_minor\_version\_upgrade) | n/a | `any` | n/a | yes |
| <a name="input_db_az"></a> [db\_az](#input\_db\_az) | n/a | `string` | n/a | yes |
| <a name="input_db_backup_retention_period"></a> [db\_backup\_retention\_period](#input\_db\_backup\_retention\_period) | The days to retain backups for. Must be between 0 and 35. Must be greater than 0 if the database is used as a source for a Read Replica. | `number` | n/a | yes |
| <a name="input_db_backup_window"></a> [db\_backup\_window](#input\_db\_backup\_window) | The daily time range (in UTC) during which automated backups are created if they are enabled. Must not overlap with maintenance\_window. | `string` | n/a | yes |
| <a name="input_db_copy_tags_to_snapshot"></a> [db\_copy\_tags\_to\_snapshot](#input\_db\_copy\_tags\_to\_snapshot) | n/a | `any` | n/a | yes |
| <a name="input_db_delete_automated_backups"></a> [db\_delete\_automated\_backups](#input\_db\_delete\_automated\_backups) | Specifies whether to remove automated backups immediately after the DB instance is deleted. Default is true. | `string` | n/a | yes |
| <a name="input_db_deletion_protection"></a> [db\_deletion\_protection](#input\_db\_deletion\_protection) | n/a | `bool` | `false` | no |
| <a name="input_db_engine"></a> [db\_engine](#input\_db\_engine) | n/a | `string` | n/a | yes |
| <a name="input_db_engine_version"></a> [db\_engine\_version](#input\_db\_engine\_version) | "k3s MySQL (certified against version 5.7)<br>   reference: https://rancher.com/docs/k3s/latest/en/installation/datastore/#datastore-endpoint-format-and-functionality" | `string` | n/a | yes |
| <a name="input_db_identifier"></a> [db\_identifier](#input\_db\_identifier) | n/a | `string` | `"db"` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | n/a | `string` | n/a | yes |
| <a name="input_db_maintenance_window"></a> [db\_maintenance\_window](#input\_db\_maintenance\_window) | n/a | `string` | n/a | yes |
| <a name="input_db_max_allocated_storage"></a> [db\_max\_allocated\_storage](#input\_db\_max\_allocated\_storage) | n/a | `number` | n/a | yes |
| <a name="input_db_multi_az"></a> [db\_multi\_az](#input\_db\_multi\_az) | n/a | `any` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | n/a | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | n/a | `string` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | n/a | `number` | n/a | yes |
| <a name="input_db_public_accessibility"></a> [db\_public\_accessibility](#input\_db\_public\_accessibility) | n/a | `any` | n/a | yes |
| <a name="input_db_skip_final_snapshot"></a> [db\_skip\_final\_snapshot](#input\_db\_skip\_final\_snapshot) | n/a | `any` | n/a | yes |
| <a name="input_db_storage_encrypted"></a> [db\_storage\_encrypted](#input\_db\_storage\_encrypted) | n/a | `string` | n/a | yes |
| <a name="input_db_storage_type"></a> [db\_storage\_type](#input\_db\_storage\_type) | One of "standard" (magnetic), "gp2" (general purpose SSD), or "io1" (provisioned IOPS SSD).<br>    The default is "io1" if iops is specified, "gp2" if not. | `string` | n/a | yes |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | aws\_db\_subnet\_group.db\_subnet[db\_sg] | `string` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | n/a | `string` | n/a | yes |
| <a name="input_db_vpc_security_group_ids"></a> [db\_vpc\_security\_group\_ids](#input\_db\_vpc\_security\_group\_ids) | n/a | `list(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_endpoint"></a> [db\_endpoint](#output\_db\_endpoint) | n/a |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | n/a |
<!-- END_TF_DOCS -->