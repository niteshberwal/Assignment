resource "aws_vpc_endpoint" "ssm" {
 vpc_id            = aws_vpc.vpc.id
 service_name      = "com.amazonaws.${var.region}.ssm"
 vpc_endpoint_type = "Interface"
 subnet_ids        = [aws_subnet.private.id]
 security_group_ids = [aws_security_group.ssm_endpoint_sg.id]
 private_dns_enabled = true
 tags = {
   Name = "SSM-Endpoint"
 }
}

resource "aws_vpc_endpoint" "ec2messages" {
 vpc_id            = aws_vpc.vpc.id
 service_name      = "com.amazonaws.${var.region}.ec2messages"
 vpc_endpoint_type = "Interface"
 subnet_ids        = [aws_subnet.private.id]
 security_group_ids = [aws_security_group.ssm_endpoint_sg.id]
 private_dns_enabled = true
 tags = {
   Name = "SSM-EC2-Endpoint"
 }
}

resource "aws_vpc_endpoint" "ssmmessages" {
 vpc_id            = aws_vpc.vpc.id
 service_name      = "com.amazonaws.${var.region}.ssmmessages"
 vpc_endpoint_type = "Interface"
 subnet_ids        = [aws_subnet.private.id]
 security_group_ids = [aws_security_group.ssm_endpoint_sg.id]
 private_dns_enabled = true
 tags = {
   Name = "SSM-Msgs-Endpoint"
 }
}

resource "aws_vpc_endpoint" "s3" {
 vpc_id            = aws_vpc.vpc.id
 service_name      = "com.amazonaws.${var.region}.s3"
 vpc_endpoint_type = "Gateway"
 route_table_ids   = [aws_route_table.public_rt.id]
 tags = {
   Name = "S3-Bucket-Endpoint"
 }
}

