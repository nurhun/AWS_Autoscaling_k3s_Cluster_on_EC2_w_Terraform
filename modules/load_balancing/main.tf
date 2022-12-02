# --- Load_Balancing/main.tf ---

# Masters LB, TG & Listeners
resource "aws_lb" "k3s-masters-lb" {
  name                             = "k3s-masters-lb"
  load_balancer_type               = var.k3s_masters_lb_type
  internal                         = var.k3s_masters_lb_internal
  subnets                          = var.k3s_masters_lb_subnets
  enable_cross_zone_load_balancing = var.k3s_masters_lb_enable_cross_zone_load_balancing
  enable_deletion_protection       = var.k3s_masters_lb_enable_deletion_protection

  tags = {
    Name = "k3s-masters-lb"
    Env  = "DevTest"
    Tier = "LoadBalancer"
    "kubernetes.io/cluster/default" = "owned"
  }

  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }
}


resource "aws_lb_target_group" "k3s-masters-int-lb-tg" {
  name     = "k3s-masters-int-lb-tg"
  port     = var.k3s_masters_int_lb_tg_port
  protocol = var.k3s_masters_int_lb_tg_protocol
  vpc_id   = var.vpc_id

  health_check {
    enabled             = var.k3s_masters_int_lb_tg_hlth_ck_enabled
    port                = var.k3s_masters_int_lb_tg_port
    protocol            = var.k3s_masters_int_lb_tg_protocol
    healthy_threshold   = var.k3s_masters_int_lb_tg_hlth_ck_healthy_threshold
    unhealthy_threshold = var.k3s_masters_int_lb_tg_hlth_ck_unhealthy_threshold
    interval            = var.k3s_masters_int_lb_tg_hlth_ck_interval
  }

  tags = {
    Name = "k3s-int-lb-tg"
    Env  = "DevTest"
    Tier = "LoadBalancer"
  }

}


resource "aws_lb_listener" "k3s-masters-lb-backend-listener" {
  load_balancer_arn = aws_lb.k3s-masters-lb.arn
  port              = var.k3s_masters_int_lb_listener_port
  protocol          = var.k3s_masters_int_lb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.k3s-masters-int-lb-tg.arn
  }
}



# Nodes LB, TG & Listeners

resource "aws_lb" "k3s-nodes-lb" {
  name                             = "k3s-nodes-lb"
  load_balancer_type               = var.k3s_nodes_lb_type
  internal                         = var.k3s_nodes_lb_internal
  subnets                          = var.k3s_nodes_lb_subnets
  enable_cross_zone_load_balancing = var.k3s_nodes_lb_enable_cross_zone_load_balancing
  enable_deletion_protection       = var.k3s_nodes_lb_enable_deletion_protection

  tags = {
    Name = "k3s-nodes-lb"
    Env  = "DevTest"
    Tier = "LoadBalancer"
    "kubernetes.io/cluster/default" = "owned"
  }

  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }
}


resource "aws_lb_target_group" "k3s-nodes-int-lb-tg" {
  name     = "k3s-nodes-int-lb-tg"
  port     = var.k3s_nodes_int_lb_tg_port
  protocol = var.k3s_nodes_int_lb_tg_protocol
  vpc_id   = var.vpc_id

  health_check {
    enabled             = var.k3s_nodes_int_lb_tg_hlth_ck_enabled
    port                = var.k3s_nodes_int_lb_tg_port
    protocol            = var.k3s_nodes_int_lb_tg_protocol
    healthy_threshold   = var.k3s_nodes_int_lb_tg_hlth_ck_healthy_threshold
    unhealthy_threshold = var.k3s_nodes_int_lb_tg_hlth_ck_unhealthy_threshold
    interval            = var.k3s_nodes_int_lb_tg_hlth_ck_interval
  }

  tags = {
    Name = "k3s-nodes-int-lb-tg"
    Env  = "DevTest"
    Tier = "LoadBalancer"
  }
}


resource "aws_lb_listener" "k3s_nodes_lb_backend" {
  load_balancer_arn = aws_lb.k3s-nodes-lb.arn
  port              = var.k3s_nodes_int_lb_listener_port
  protocol          = var.k3s_nodes_int_lb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.k3s-nodes-int-lb-tg.arn
  }
}