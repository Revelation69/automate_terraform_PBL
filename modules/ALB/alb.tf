# ----------------------------
#External Load balancer for reverse proxy nginx
#---------------------------------

resource "aws_lb" "ext-alb" {
  name            = var.ext-alb-name
  internal        = false
  security_groups = [var.public-sg]
  subnets         = [var.public-sbn-1, var.public-sbn-2]

  tags = {
    Name = var.ext-alb-name
  }

  ip_address_type    = var.ip-address-type
  load_balancer_type = var.load-balancer-type
}

#--- create a target group for the external load balancer
resource "aws_lb_target_group" "nginx-tgt" {
  health_check {
    interval            = var.interval
    path                = var.path
    protocol            = var.protocol
    timeout             = var.timeout
    healthy_threshold   = var.healthy-threshold 
    unhealthy_threshold = var.unhealthy-threshold 
  }
  name        = "nginx-tgt"
  port        = var.port
  protocol    = var.protocol
  target_type = var.target-type
  vpc_id      = var.vpc-id
}

#--- create a listener for the load balancer
resource "aws_lb_listener" "nginx-listner" {
  load_balancer_arn = aws_lb.ext-alb.arn
  port              = var.port
  protocol          = var.protocol
  certificate_arn   = aws_acm_certificate_validation.project_terraform_validation.certificate_arn

  default_action {
    type             = var.lb-listener-action-type
    target_group_arn = aws_lb_target_group.nginx-tgt.arn
  }
}

# ----------------------------
#Internal Load Balancers for webservers
#---------------------------------

resource "aws_lb" "int-alb" {
  name     = var.int-alb-name
  internal = true
  security_groups = [var.private-sg]
  subnets = [var.private-sbn-1, var.private-sbn-2]

  tags = {
    Name = var.int-alb-name
  }

  ip_address_type    = var.ip-address-type
  load_balancer_type = var.load-balancer-type
}

# --- target group  for wordpress -------
resource "aws_lb_target_group" "wordpress-tgt" {
  health_check {
    interval            = var.interval
    path                = var.path
    protocol            = var.protocol
    timeout             = var.timeout
    healthy_threshold   = var.healthy-threshold 
    unhealthy_threshold = var.unhealthy-threshold
  }

  name        = "wordpress-tgt"
  port        = var.port
  protocol    = var.protocol
  target_type = var.target-type
  vpc_id      = var.vpc-id
}

# --- target group for tooling -------
resource "aws_lb_target_group" "tooling-tgt" {
  health_check {
    interval            = var.interval
    path                = var.path
    protocol            = var.protocol
    timeout             = var.timeout
    healthy_threshold   = var.healthy-threshold 
    unhealthy_threshold = var.unhealthy-threshold
  }

  name        = "tooling-tgt"
  port        = var.port
  protocol    = var.protocol
  target_type = var.target-type
  vpc_id      = var.vpc-id
}

# For this aspect a single listener was created for the wordpress which is default,
# A rule was created to route traffic to tooling when the host header changes

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.int-alb.arn
  port              = var.port
  protocol          = var.protocol
  certificate_arn   = aws_acm_certificate_validation.project_terraform_validation.certificate_arn


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-tgt.arn
  }
}

# # listener rule for tooling target

resource "aws_lb_listener_rule" "tooling-listener" {
  listener_arn = aws_lb_listener.web-listener.arn
  priority     = var.lb-listener-priority

  action {
    type             = var.lb-listener-action-type
    target_group_arn = aws_lb_target_group.tooling-tgt.arn
  }

  condition {
    host_header {
      values = ["tooling.projectaws.xyz"]
    }
  }
}
