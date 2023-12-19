resource "aws_lb" "front_end" {
    name = "${var.prefix}-front-end"
    internal = false    
    load_balancer_type = "application"  
    security_groups = [aws_security_group.alb.id]
    subnets = [aws_subnet.public-a.id, aws_subnet.public-b.id]
  
    enable_deletion_protection = false

}

resource "aws_lb_target_group" "front_end" {
    name = "${var.prefix}-front-end"    
    port = 80     
    protocol = "HTTP"
    vpc_id = aws_vpc.main.id
    target_type = "instance"
    health_check {
        enabled = true
        path = "/health"
        matcher = "200"
        interval = 30
        timeout = 10
        healthy_threshold = 2
        unhealthy_threshold = 2
    }
}

resource "aws_alb_listener" "front_end" {
    load_balancer_arn = aws_lb.front_end.arn
    port = 80
    protocol = "HTTP"
    default_action {

        type = "forward"
        target_group_arn = aws_lb_target_group.front_end.arn
    }
}

resource "aws_alb_target_group_attachment" "server1" {
    target_group_arn = aws_lb_target_group.front_end.arn
    target_id = aws_instance.server1.id
    port = 80
}

resource "aws_alb_target_group_attachment" "server2" {
    target_group_arn = aws_lb_target_group.front_end.arn
    target_id = aws_instance.server2.id
    port = 80

}