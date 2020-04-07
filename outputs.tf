output "launch_template_name" {
  value = aws_launch_template.launch_template.name
}
output "launch_template_default_version" {
  value = aws_launch_template.launch_template.default_version
}
output "launch_template_latest_version" {
  value = aws_launch_template.launch_template.latest_version
}
output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}
output "route53_name" {
  value = aws_route53_record.record.name
}

