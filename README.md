# HA_ec2_ALB

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://github.com/iamsudipt
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

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
| disable_api_termination | If true, enables EC2 Instance Termination Protection | string | `false` | no |
| ami_id | The AMI from which to launch the instance. | string | null | yes |
| instance_type | The type of the instance | string | null | no |
| instance_key_name | The key name to use for the instance. | string | null | no |
| security_groups | A list of security group names to associate with. | string | null | yes |
| device_name | The name of the device to mount. | string | null | yes |
| volume_size | The size of the volume in gigabytes. | string | null | yes |
| monitoring_enabled | If true, the launched EC2 instance will have detailed monitoring enabled. | boolean | `true` | no |
| instance_availability_zone | The Availability Zone for the instance. | string | null | yes |
| asg_min_size | The minimum size of the auto scale group | number | `1` | yes |
| asg_max_size | The maximum size of the auto scale group. | number | `1` | yes |
| asg_desired_size | The number of Amazon EC2 instances that should be running in the group. | number | `1` | yes |
| asg_wait_for_elb_capacity | If wait_for_elb_capacity is set, Terraform will wait for exactly that number of Instances to be "InService" in all attached ELBs on both creation and updates. | number | `1` | yes |
| asg_health_check_grace_period | Time (in seconds) after instance comes into service before checking health. | number | `300` | no |
| asg_health_check_type | "EC2" or "ELB". Controls how health checking is done. | string | `instance` | no |
| asg_force_delete | Allows deleting the autoscaling group without waiting for all instances in the pool to terminate.  | string | `false` | no |
| asg_default_cooldown | Time between a scaling activity and the succeeding scaling activity. | number | `300` | yes |
| instance_subnets | A list of subnet IDs to launch resources in. | list(string) | null | yes |
| asg_termination_policies | A list of policies to decide how the instances in the auto scale group should be terminated.  | list(string) | `default` | no |
| asg_suspended_processes | A list of processes to suspend for the AutoScaling Group. | list(string) | `default` | no |
| launch_template_version | Template version. Can be version number, $Latest, or $Default. | string | `$LATEST` | no |
## Outputs

| Name | Description |
|------|-------------|
| launch_template_name | Name of the launch template |
| launch_template_default_version | Default of the launch template |
| launch_template_latest_version | Latest of the launch template |
| target_group_arn | ARN of the target group |
| route53_name | Name of the record created |

## Related Projects

Check out these related projects.

- [network_skeleton](https://gitlab.com/ot-aws/terrafrom_v0.12.21/network_skeleton) - Terraform module for providing a general purpose Networking solution
- [security_group](https://gitlab.com/ot-aws/terrafrom_v0.12.21/security_group) - Terraform module for creating dynamic Security groups
- [eks](https://gitlab.com/ot-aws/terrafrom_v0.12.21/eks) - Terraform module for creating elastic kubernetes cluster.
- [rds](https://gitlab.com/ot-aws/terrafrom_v0.12.21/rds) - Terraform module for creating Relation Datbase service.
- [HA_ec2](https://gitlab.com/ot-aws/terrafrom_v0.12.21/ha_ec2.git) - Terraform module for creating a Highly available setup of an EC2 instance with quick disater recovery.
- [rolling_deployment](https://gitlab.com/ot-aws/terrafrom_v0.12.21/rolling_deployment.git) - This terraform module will orchestrate rolling deployment.

### Contributors

[![Sudipt Sharma][sudipt_avatar]][sudipt_homepage]<br/>[Sudipt Sharma][sudipt_homepage] 

  [sudipt_homepage]: https://github.com/iamsudipt
  [sudipt_avatar]: https://img.cloudposse.com/150x150/https://github.com/iamsudipt.png