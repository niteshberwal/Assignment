resource "aws_security_group" "public_lb" {
 name        = "public_lb_sg"
 vpc_id      = aws_vpc.vpc.id

 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }


 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_security_group" "private_instances" {
 name        = "private_instances_sg"
 description = "Allow inbound traffic for private instances"
 vpc_id      = aws_vpc.vpc.id

 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_security_group" "ssm_endpoint_sg" {
 name_prefix = "vpc-endpoint-sg"
 vpc_id      = aws_vpc.vpc.id
 description = "security group for VPC Endpoints"

 ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
    description = "Allow HTTPS traffic from VPC"
 }

 tags = {
    Name = "VPC Endpoint security group"
 }
}
