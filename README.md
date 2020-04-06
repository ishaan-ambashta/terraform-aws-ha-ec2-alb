# HA_ec2_ALB

- This terraform module will create a Highly available setup of an EC2 instance with quick disater recovery.
- This projecct is a part of opstree's ot-aws initiative for terraform modules.

## Usage

```sh
$   cat main.tf
/*-------------------------------------------------------*/
module "ha_ec2_alb" {
  source                         = "../"
  applicaton_name                = "NEXUS"
  applicaton_port                = 80
  applicaton_health_check_target = "/"
  
  vpc_id = "vpc-lmnopq"

  route53_zone_id    = "Z2SMIZHC4PCJX4"
  route53_name       = "nexus.uat.xyz.com"
  alb_dns_name       = ["aws_lb.test.dns_name"]
  ttl                = "60"

  listener_arn                   = aws_lb_listener.test_lb_listner.arn
  priority                       = "98"
  listener_rule_condition        = "host-header"
  listener_rule_condition_values =  ["nexus.uat.xyz.com"]

  ami_id                = "ami-jklmnopqrst"
  instance_type         = "t2.micro"
  instance_key_name     = "devops"
  security_groups       = [aws_security_group.app_sg.id]
  volume_size           = "100"

  instance_availability_zone = ["ap-south-1a","ap-south-1b"]
  instance_subnets           = ["subnet-efghijk","subnet-lmnopqrst"]
  launch_template_version    = "$Latest"
}
/*-------------------------------------------------------*/
```

```sh
$   cat output.tf
/*-------------------------------------------------------*/
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
/*-------------------------------------------------------*/
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| route53_zone_id | The ID of the hosted zone to contain this record. | string | null | yes |
| route53_name | The name of the record. | string | null | yes |
| rout53_record_type | The record type. Valid values are `A`, `AAAA`, `CAA`, `CNAME`, `MX`, `NAPTR`, `NS`, `PTR`, `SOA`, `SPF`, `SRV` and `TXT`. | string | `CNAME` | yes |
| alb_dns_name | A string list of records.  | list(string) | null | yes |
| ttl | The TTL of the record. | string | `false` | no |
| applicaton_name | With this name launch template and Autoscaling group will be created  | string | null | yes |
| applicaton_port | Port on which your application runs  | string | null | yes |
| applicaton_health_check_target | Health check path of the Application  | string | null | yes |
| tg_target_type | The type of target that you must specify when registering targets with this target group. | string | `instance` | no |
| tg_protocol | The protocol to use for routing traffic to the targets.  | string | `HTTP` | no |
| vpc_id | The identifier of the VPC in which to create the target group. | string | null | no |
| listener_arn | The ARN of the listener to which to attach the rule. | string | null | yes |
| priority | The priority for the rule between 1 and 50000. | string | null | yes |
| action_type | The type of routing action.  | string | `forward` | yes |
| listener_rule_condition | The type of condition. Valid values are host-header or path-pattern. Must also set values. | string | null | no(Deprecated) |
| listener_rule_condition_values | List of exactly one pattern to match. Required when field is set. | string | null | no(Deprecated) |
| disable_api_termination |  | string | `false` | no |
| ami_id |  | string | `false` | no |
| instance_type |  | string | `false` | no |
| instance_key_name |  | string | `false` | no |
| security_groups |  | string | `false` | no |
| device_name |  | string | `false` | no |
| volume_size |  | string | `false` | no |
| monitoring_enabled |  | string | `false` | no |
| instance_availability_zone |  | string | `false` | no |
| instance_availability_zone |  | string | `false` | no |
| asg_min_size |  | string | `false` | no |
| asg_max_size |  | string | `false` | no |
| asg_desired_size |  | string | `false` | no |
| asg_wait_for_elb_capacity |  | string | `false` | no |
| asg_health_check_grace_period |  | string | `false` | no |
| asg_health_check_type |  | string | `false` | no |
| asg_force_delete |  | string | `false` | no |
| asg_default_cooldown |  | string | `false` | no |
| asg_load_balancers |  | string | `false` | no |
| instance_subnets |  | string | `false` | no |
| asg_termination_policies |  | string | `false` | no |
| asg_suspended_processes |  | string | `false` | no |
| launch_template_version |  | string | `false` | no |
## Outputs

| Name | Description |
|------|-------------|
| autoscaling_group_arn | ARN of the AutoScaling Group |

## Related Projects

Check out these related projects.

- [network_skeleton](https://gitlab.com/ot-aws/terrafrom_v0.12.21/network_skeleton) - Terraform module for providing a general purpose Networking solution

### Contributors

[![Sudipt Sharma][sudipt_avatar]][sudipt_homepage]<br/>[Sudipt Sharma][sudipt_homepage] 

  [sudipt_homepage]: https://github.com/iamsudipt
  [sudipt_avatar]: https://img.cloudposse.com/150x150/https://github.com/iamsudipt.png