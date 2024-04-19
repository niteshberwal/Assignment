#Data source to fetch latest AMI 
data "aws_ami" "amazon_linux" {
 most_recent = true
 owners      = ["amazon"]

 filter {
    name   = "name"
    values = ["al2023-ami-20*-kernel-6.1-x86_64"]
 }
}


# Auto Scaling Group
resource "aws_launch_configuration" "launch_config" {
 name          = "assignment-lc"
 image_id      = data.aws_ami.amazon_linux.id
#"ami-09298640a92b2d12c"
 instance_type = "t2.micro"
 iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name

 # User data for Ansible configuration
 user_data = <<-EOF
              #!/bin/bash
              sudo yum install ansible -y
              aws s3 cp s3://${aws_s3_bucket.s3-bucket.bucket}/webserver.yml /home/ec2-user/
              ansible-playbook /home/ec2-user/webserver.yml
              EOF

 # Security groups
 security_groups = [aws_security_group.private_instances.id]

 # Root volume
 root_block_device {
    volume_type = "gp2"
    volume_size = 10
    encrypted   = true
#    kms_key_id  = aws_kms_key.ebs_key.id
 }

 # Secondary volume for logs
 ebs_block_device {
    device_name = "/dev/xvdb"
    encrypted   = true
    volume_type = "gp2"
    volume_size = 10
#    kms_key_id  = aws_kms_key.ebs_key.id
 }
}


resource "aws_autoscaling_group" "autoscaling_group" {
 desired_capacity   = 1
 max_size           = 5
 min_size           = 1
 launch_configuration = aws_launch_configuration.launch_config.id
 vpc_zone_identifier = [aws_subnet.private.id]

 target_group_arns = [aws_lb_target_group.front_end.arn]
}

resource "aws_autoscaling_policy" "scale_up" {
 name                   = "scale_up"
 autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
 adjustment_type        = "ChangeInCapacity"
 scaling_adjustment     = 1
 cooldown               = 300
}

resource "aws_autoscaling_policy" "scale_down" {
 name                   = "scale_down"
 autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
 adjustment_type        = "ChangeInCapacity"
 scaling_adjustment     = -1
 cooldown               = 300
}

