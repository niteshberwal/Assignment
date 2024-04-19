variable "region" {
  default = "ap-south-1"
}

variable "route53_zone_name" {
  default = "test.example.com"
}

variable "bucket_name" {
  default = "bucket-for-uploading-ansible-playbook"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  default = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  default = "10.0.2.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.3.0/24"
}

variable "route_table_cidr" {
  default = "0.0.0.0/0"
}


