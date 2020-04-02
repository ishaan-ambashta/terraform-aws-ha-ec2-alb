/*-------------------------------------------------------*/
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
  type = string
  default = "instance"
}
variable "tg_protocol" {
  type = string
  default = "HTTP"
}
variable "vpc_id" {
  type = string
}
/*-------------------------------------------------------*/
variable "lr_listener_arn" {
  type = string
}
variable "lr_priority" {
  type = number
}
variable "lr_action_type" {
  type = string
  default = "forward"
}
variable "lr_listener_rule_condition" {
  type = string
}
variable "lr_listener_rule_condition_values" {
  type    = list(string)
}
/*-------------------------------------------------------*/
variable "lt_disable_api_termination" {
  type = string
  default = true
}
variable "lt_ami_id" {
  type = string
}
variable "lt_instance_type" {
  type =  string
}
variable "lt_instance_key_name" {
  type = string
}
variable "lt_security_groups" {
  type = list
}
variable "lt_device_name" {
  type = string
}
variable "lt_volume_size" {
  type = number
}
variable "lt_monitring_enabled" {
  type = string
  default = true
}
/*-------------------------------------------------------*/
variable "asg_availability_zones" {
  type = list
}
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
  type = string
  default = false
}
variable "asg_default_cooldown" {
  type    = number
  default = 300
}
variable "asg_load_balancers" {
  type    = list
  default = []
}
variable "asg_vpc_zone_identifier" {
  type = list
}
variable "asg_termination_policies" {
  type    = list(string)
  default = ["Default"]
}
variable "asg_suspended_processes" {
  type    = list(string)
  default = []
}
variable "asg_launch_template_version" {
  type    = string
  default = "$Latest"
}
