variable "subnets" {

}

variable "alb_sg" {

}

variable "vpc" {

}


variable "instances" {

}



resource "aws_lb" "application-lb" {
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = ["${var.alb_sg.id}"]
}

resource "aws_lb_listener" "http-lb-listener" {
  load_balancer_arn = aws_lb.application-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_lb_target_group" "lb-target-group" {
  port        = 8080
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = var.vpc.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 2
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "lb_tg_attachment" {
  for_each         = var.instances
  target_group_arn = aws_lb_target_group.lb-target-group.arn
  target_id        = each.value.id
  port             = 8080
}

resource "aws_lb_listener_rule" "lb_rule" {
  listener_arn = aws_lb_listener.http-lb-listener.arn
  priority     = 1

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-target-group.arn
  }
}

resource "aws_security_group_rule" "allow_alb_http_inbound" {
  type              = "ingress"
  security_group_id = var.alb_sg.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_alb_http_outbound" {
  type              = "egress"
  security_group_id = var.alb_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
