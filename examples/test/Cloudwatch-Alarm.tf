resource "aws_cloudwatch_metric_alarm" "foo" {
  alarm_name                = "terraform-test-foo5"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "5"
  metric_name               = "IAMPolicyEventCount"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "70"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
}
