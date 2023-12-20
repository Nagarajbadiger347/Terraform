resource "aws_lb" "front_end" {
    name               = "${var.prefix}-front-end"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.alb-sg.security_group.id]
  subnets            = [aws_subnet.public_a.id,aws_subnet.public_c.id]

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "test-lb"
    enabled = true
  }
}
resource "aws_lb_target_group" "front_end" {
    name     = "${var.prefix}-front-end"
    port     = 80
    protocol = "HTTP"
    vpc_id   = module.vpc.vpc_id
    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        matcher             = "200-399"
    }  
}

resource "aws_lb_listener" "front_end" {
    load_balancer_arn = aws_lb.front_end.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.front_end.arn
    }
}
resource "aws_alb_target_group_attachment" "server1" {
    target_group_arn = aws_lb_target_group.front_end.arn
    target_id        = aws_instance.server1.id
    port             = 80
}

resource "aws_alb_target_group_attachment" "server2" {
    target_group_arn = aws_lb_target_group.front_end.arn
    target_id        = aws_instance.server2.id
    port             = 80
}
