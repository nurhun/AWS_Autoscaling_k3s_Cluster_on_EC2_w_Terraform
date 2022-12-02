# --- load_balancing/outputs.tf ---

output "k3s-lb_dns_name" {
  value = aws_lb.k3s-masters-lb.dns_name
}

# output "k3s-lb_private_ip" {
#   value = aws_lb.k3s-masters-lb.subnet_mapping.*.outpost_id
# }

# output "lb_eip" {
#   value = aws_eip.lb_eip.public_ip
# }

output "k3s-masters-int-lb-tg-arn" {
  value = aws_lb_target_group.k3s-masters-int-lb-tg.arn
}

output "k3s-nodes-int-lb-tg-arn" {
  value = aws_lb_target_group.k3s-nodes-int-lb-tg.arn
}