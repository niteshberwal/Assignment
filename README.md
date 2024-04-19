# Assignment

I have created two directories, one for Ansible playbook and other for Terraform files.

Ansible playbook is pretty straight forward, I have just added the task to deploy webserver.

I have created the module structure for tf files, I have not directly added the variables in the module as according to the task most parameters will remain same. However, the variables are properly defined with default values in the webserver module and if needed all the vars can be passed directly in the main.tf like below :
region = "ap-south-1"
route53_zone_name = "test.example.com"
bucket_name = "bucket-for-uploading-ansible-playbook"
vpc_cidr = "10.0.0.0/16"
public_subnet_1_cidr = "10.0.1.0/24"
public_subnet_2_cidr = "10.0.2.0/24"
private_subnet_cidr = "10.0.3.0/24"
route_table_cidr = "0.0.0.0/0"


Terraform code will work in every region and account as it is not tightly coupled.
The code will first create a VPC
Then it will create 2 public subnets (for Applocation load balancer)
Then it will create 1 private subnet for private instance (for webserver deployment)
IGW and route table to route the traffic
VPC endpoints so that the private instance can connect with SSM and S3
Since all access was restricted for the instance, I have enabled SSM to connect to the instance.
2 disks are attached to the instance and both are encrypted as well.
Ansible playbook is initially uploaded in the S3 bucket which was later downloaded on the private instance.
I have used user_data to install ansible on the server, download the playbook and deploying the webserver.
Instance is only having access to yum repo's and S3 bucket via endpoints only.
Load balancer is configured on the private instance to route the traffic.
Self signed certs are generated for test.example.com and pushed into AWS ACM, Route53 private hosted zone is used and the DNS is successfully getting resolved in the VPC.
All the data is encrypted at rest.
Servers can be managed without root key (SSM enabled).
Cloud watch alarm has been set for high utilization.
Autoscalling group is also configured to add/remove nodes based on the load.

  
