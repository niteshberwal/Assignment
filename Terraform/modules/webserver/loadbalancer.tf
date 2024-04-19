# Load Balancer
resource "aws_lb" "public" {
 name               = "public-lb"
 internal           = false
 load_balancer_type = "application"
 security_groups    = [aws_security_group.public_lb.id]
 subnets            = [aws_subnet.public-1.id,aws_subnet.public-2.id]
}

resource "aws_lb_listener" "front_end" {
 load_balancer_arn = aws_lb.public.arn
 port              = "80"
 protocol          = "HTTP"

 default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
 }
}

resource "aws_lb_target_group" "front_end" {
 name     = "front-end"
 port     = 80
 protocol = "HTTP"
 vpc_id   = aws_vpc.vpc.id
}


