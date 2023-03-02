variable "route53_zone_id" {
  type = string
}
variable "route53_name" {
  type = string
}
variable "rout53_record_type" {
  type    = string
  default = "CNAME"
}
variable "alb_dns_cname" {
  type = list(string)
}
variable "ttl" {
  type = number
}
/*-------------------------------------------------------*/

variable "env_name" {
  type = string
}

variable "applicaton_name" {
  type = string
}
variable "applicaton_port" {
  type = number
}
variable "applicaton_health_check_target" {
  type = string
}
/*-------------------------------------------------------*/
variable "tg_target_type" {
  type    = string
  default = "instance"
}
variable "tg_protocol" {
  type    = string
  default = "HTTP"
}
variable "vpc_id" {
  type = string
}
/*-------------------------------------------------------*/
variable "listener_arn" {
  type = string
}
variable "priority" {
  type = number
}
variable "action_type" {
  type    = string
  default = "forward"
}
variable "listener_rule_condition" {
  type = string
}
variable "listener_rule_condition_values" {
  type = list(string)
}
/*-------------------------------------------------------*/
variable "disable_api_termination" {
  type    = string
  default = true
}
variable "ami_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "instance_key_name" {
  type = string
}
variable "device_name" {
  type    = string
  default = "/dev/sda1"
}
variable "volume_size" {
  type = number
}
variable "volume_type" {
  type = string
}
variable "monitoring_enabled" {
  type    = bool
  default = true
}
variable "lt_iam_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the instance profile for launch template"
  type = list(object({
      arn = string
  }))
  default = []
}
/*-------------------------------------------------------*/
variable "asg_min_size" {
  type    = number
  default = "1"
}
variable "asg_max_size" {
  type    = number
  default = "1"
}
variable "asg_desired_size" {
  type    = number
  default = "1"
}
variable "asg_wait_for_elb_capacity" {
  type    = number
  default = "1"
}
variable "asg_health_check_grace_period" {
  type    = number
  default = "300"
}
variable "asg_health_check_type" {
  type    = string
  default = "ELB"
}
variable "asg_force_delete" {
  type    = string
  default = false
}
variable "asg_default_cooldown" {
  type    = number
  default = 300
}
variable "instance_subnets" {
  type = list(any)
}
variable "asg_termination_policies" {
  type    = list(string)
}
variable "asg_suspended_processes" {
  type    = list(string)
  default = []
}
variable "launch_template_version" {
  type    = string
  default = "$Latest"
}

variable "security_groups" {
  type = list(any)
}

variable "ipv6_address_count" {
  type = number
}

variable "associate_public_ip_address" {
  type = bool
}

# variable "network_interfaces" {
#   type = list(object({
#       associate_public_ip_address = bool
#       ipv6_address_count = number
#       ipv4_address_count = number
#       security_groups = list(any)
#   }))
#   default = []
# }

variable "asg_tags" {
  type        = list(map(string))
  description = "The tag associated with the auto scaling group"
}
