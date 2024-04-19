resource "aws_vpc" "vpc" {
 cidr_block = var.vpc_cidr
 enable_dns_hostnames = true
 tags = {
    Name = "Test VPC"
 }
}

resource "aws_subnet" "public-1" {
 vpc_id     = aws_vpc.vpc.id
 cidr_block = var.public_subnet_1_cidr
 availability_zone = "ap-south-1a"
 tags = {
    Name = "public-subnet-1"
 }
}

resource "aws_subnet" "public-2" {
 vpc_id     = aws_vpc.vpc.id
 cidr_block = var.public_subnet_2_cidr
 availability_zone = "ap-south-1b"
 tags = {
    Name = "public-subnet-2"
 }
}


resource "aws_subnet" "private" {
 vpc_id     = aws_vpc.vpc.id
 cidr_block = var.private_subnet_cidr
 availability_zone = "ap-south-1a"
 tags = {
    Name = "private-subnet"
 }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "public_rt" {
 vpc_id = aws_vpc.vpc.id

 route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_internet_gateway.igw.id
 }

 tags = {
    Name = "Public Route Table"
 }
}

resource "aws_route_table_association" "public_subnet_asso" {
 subnet_id      = aws_subnet.private.id
 route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_asso_1" {
 subnet_id      = aws_subnet.public-1.id
 route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_asso_2" {
 subnet_id      = aws_subnet.public-2.id
 route_table_id = aws_route_table.public_rt.id
}


