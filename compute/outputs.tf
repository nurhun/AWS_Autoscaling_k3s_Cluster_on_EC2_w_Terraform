# --- compute/outputs.tf ---

# output "ebs_volumes_ids" {
#   value = aws_ebs_volume.ebs_volumes.*
# }

# output "instances_ids" {
#   value = aws_instance.k8s_machines.*.id
# }

# output "instances_ips" {
#   value = aws_instance.k8s_machines.*.public_ip
# }

# output "instances_count" {
#   value = length(aws_instance.k8s_machines.*.id)
# }

# # output "instance_element" {
# #   value = "${element(aws_instance.k8s_machines.*.id, count.index)}"
# # }

# output "instances_private_ips" {
#   value = aws_instance.k8s_machines.*.private_ip
# }

output "ec2_instances_public_ips" {
  value = flatten(data.aws_instances.ec2_instances_public_ips.*.public_ips)
}

output "k3s_controle_plane_public_ip_1" {
  value = element(flatten(data.aws_instances.ec2_instances_public_ips.*.public_ips), 0)
}