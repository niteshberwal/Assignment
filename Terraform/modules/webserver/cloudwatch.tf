resource "aws_cloudwatch_metric_alarm" "cpu_high" {
 alarm_name          = "cpu_high"
 comparison_operator = "GreaterThanOrEqualToThreshold"
 evaluation_periods = "2"
 metric_name         = "CPUUtilization"
 namespace           = "AWS/EC2"
 period              = "60"
 statistic           = "Average"
 threshold           = "80"
 alarm_description   = "This metric checks for high CPU utilization"
 alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
 dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling_group.name
 }
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
 alarm_name          = "cpu_low"
 comparison_operator = "LessThanOrEqualToThreshold"
 evaluation_periods = "2"
 metric_name         = "CPUUtilization"
 namespace           = "AWS/EC2"
 period              = "60"
 statistic           = "Average"
 threshold           = "20"
 alarm_description   = "This metric checks for low CPU utilization"
 alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
 dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling_group.name
 }
}

