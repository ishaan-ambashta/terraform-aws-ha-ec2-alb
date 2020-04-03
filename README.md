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

  lr_listener_arn                   = aws_lb_listener.test_lb_listner.arn
  lr_priority                       = "98"
  lr_listener_rule_condition        = "path-pattern"
  lr_listener_rule_condition_values =  ["/artifactory", "/artifactory/*"]

  lt_ami_id                = "ami-03aa0a2fcd9d2f94e"
  lt_instance_type         = "t2.micro"
  lt_instance_key_name     = "devops"
  lt_security_groups       = [aws_security_group.app_sg.id]
  lt_device_name           = "/dev/sda1"
  lt_volume_size           = "100"

  asg_availability_zones        = ["ap-south-1a","ap-south-1b"]
  asg_vpc_zone_identifier       = ["subnet-2e0bd463","subnet-97851efe"]
  asg_launch_template_version   = "$Latest"
}
/*-------------------------------------------------------*/
resource "aws_route53_record" "record" {
  zone_id                   = "Z2SMIZHC4PCJX4"
  name                      = "nexus.uat.ezmall.com"
  type                      = "A"

  alias {
    name                    = aws_lb.test.dns_name
    zone_id                 = aws_lb.test.zone_id
    evaluate_target_health  = true
  }
}
/*-------------------------------------------------------*/
resource "aws_lb" "test" {
  name               = "nexus-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = ["subnet-97851efe","subnet-2e0bd463"]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}
resource "aws_lb_listener" "test_lb_listner" {
  load_balancer_arn                     = aws_lb.test.arn
  port                                  = "80"
  protocol                              = "HTTP"
  default_action {
    type                                = "forward"
    target_group_arn                    = aws_lb_target_group.default_tg.arn
  }
}
resource "aws_lb_target_group" "default_tg" {
  name                                  = "weye-default-alb-tg"
  port                                  = 80
  target_type                           = "instance"
  protocol                              = "HTTP"
  vpc_id                                = "vpc-fc5cc595"
  health_check {
      path                              = "/"
  }
}
/*-------------------------------------------------------*/
resource "aws_security_group" "alb_sg" {
  name = "ALB Security Group"
  vpc_id      = "vpc-fc5cc595"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Terraform = "true"
  }
}
/*-------------------------------------------------------*/
resource "aws_security_group" "app_sg" {
  name = "My App Security Group"
  vpc_id      = "vpc-fc5cc595"

  ingress {
      from_port = 0
      to_port = 65535
      protocol = "tcp"
      security_groups = [aws_security_group.alb_sg.id]
  }
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["10.147.0.0/16"]
  }
  egress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Terraform = "true"
  }
}
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