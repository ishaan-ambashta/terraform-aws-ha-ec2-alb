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
