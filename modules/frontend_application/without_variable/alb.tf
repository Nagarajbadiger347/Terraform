resource "aws_lb" "front_end" {
    name = "front-end"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb.id]
    subnets = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  
    enable_deletion_protection = false
}

resource "aws_lb_target_group" "front_end" {
    name = "front-end"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.main.id
  
    health_check {
      healthy_threshold = 3
      interval = 5
      matcher = "200"
      path = "/"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 2
      unhealthy_threshold = 2
    }
  
}

resource "aws_alb_listener" "frontend" {
    load_balancer_arn = aws_lb.front_end.arn
    port = "80"
    protocol = "HTTP"
  
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.front_end.arn

    } 
}
resource "aws_alb_target_group_attachment" "Server1" {
    target_group_arn = aws_lb_target_group.front_end.arn
    target_id = aws_instance.Server1.id
    port = 80
}
resource "aws_alb_target_group_attachment" "Server2" {
    target_group_arn = aws_lb_target_group.front_end.arn
    target_id = aws_instance.Server2.id
    port = 80
}
