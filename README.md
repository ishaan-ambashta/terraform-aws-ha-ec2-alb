# HA_ec2_ALB

This repository consist of Terraform module for Highly Available EC2 setup with ALB.

```sh
$   cat main.tf
/*-------------------------------------------------------*/
module "ha_ec2_alb" {
  source                         = "../"
  applicaton_name                = "NEXUS"
  applicaton_port                = 80
  applicaton_health_check_target = "/"
  
  vpc_id = "vpc-fc5cc595"

  route53_zone_id    = "Z2SMIZHC4PCJX4"
  route53_name       = "nexus.uat.xyz.com"
  rout53_record_type = "A"
  alb_dns_name       = aws_lb.test.dns_name
  alb_zone_id        = aws_lb.test.zone_id

  listener_arn                   = aws_lb_listener.test_lb_listner.arn
  priority                       = "98"
  listener_rule_condition        = "path-pattern"
  listener_rule_condition_values =  ["/artifactory", "/artifactory/*"]

  ami_id                = "ami-03aa0a2fcd9d2f94e"
  instance_type         = "t2.micro"
  instance_key_name     = "keys"
  security_groups       = [aws_security_group.app_sg.id]
  device_name           = "/dev/sda1"
  volume_size           = "100"

  asg_availability_zones        = ["ap-south-1a","ap-south-1b"]
  asg_vpc_zone_identifier       = ["subnet-2e0bd463","subnet-97851efe"]
  asg_launch_template_version   = "$Latest"
}
/*-------------------------------------------------------*/
```

```sh
$   cat output.tf
output "launch_template_name" {
  value = module.ha_ec2_alb.launch_template_name
}
output "launch_template_default_version" {
  value = module.ha_ec2_alb.launch_template_default_version
}
output "launch_template_latest_version" {
  value = module.ha_ec2_alb.launch_template_latest_version
}
output "target_group_arn" {
  value = module.ha_ec2_alb.target_group_arn
}
```