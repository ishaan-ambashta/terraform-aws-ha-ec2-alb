# HA_ec2_ALB

<img align="middle" title="Opstree logo" src="https://www.opstree.com/assets/images/logo.png"/>



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
  route53_name       = "nexus.uat.ezmall.com"
  alb_dns_name       = ["aws_lb.test.dns_name"]
  ttl                = "60"

  listener_arn                   = aws_lb_listener.test_lb_listner.arn
  priority                       = "98"
  listener_rule_condition        = "host-header"
  listener_rule_condition_values =  ["nexus.uat.ezmall.com"]

  ami_id                = "ami-03aa0a2fcd9d2f94e"
  instance_type         = "t2.micro"
  instance_key_name     = "devops"
  security_groups       = [aws_security_group.app_sg.id]
  volume_size           = "100"

  instance_availability_zone = ["ap-south-1a","ap-south-1b"]
  instance_subnets           = ["subnet-2e0bd463","subnet-97851efe"]
  launch_template_version    = "$Latest"
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
output "route53_name" {
  value = module.ha_ec2_alb.route53_name
}

```