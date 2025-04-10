resource "aws_lb" "wordpress_alb" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "${var.project_name}-alb"
  }
}

resource "aws_lb_target_group" "blue" {
  name     = "${var.project_name}-tg-blue"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.project_name}-tg-blue"
  }
}

resource "aws_lb_target_group" "green" {
  name     = "${var.project_name}-tg-green"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.project_name}-tg-green"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.wordpress_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }

  depends_on = [
    aws_lb_target_group.blue,
    aws_lb_target_group.green
  ]
}

resource "aws_lb_target_group_attachment" "blue_attachment" {
  target_group_arn = aws_lb_target_group.blue.arn
  target_id        = var.blue_instance_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "green_attachment" {
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = var.green_instance_id
  port             = 80
}

