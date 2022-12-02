# # --- compute/locals.tf ---


locals {
  # lb_dns_name = var.lb_dns_name
  token       = random_password.token.result
}