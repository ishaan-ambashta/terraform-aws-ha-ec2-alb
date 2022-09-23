/*-------------------------------------------------------*/
resource "aws_route53_record" "record" {
  zone_id = var.route53_zone_id
  name    = var.route53_name
  type    = var.rout53_record_type
  records = var.alb_dns_cname
  ttl     = var.ttl
}
/*-------------------------------------------------------*/
resource "aws_lb_target_group" "target_group" {
  name        = "${var.env_name}-${var.applicaton_name}-alb-tg"
  port        = var.applicaton_port
  target_type = var.tg_target_type
  protocol    = var.tg_protocol
  vpc_id      = var.vpc_id
  health_check {
    path = var.applicaton_health_check_target
  }
}
/*-------------------------------------------------------*/
resource "aws_lb_listener_rule" "listner_rule" {
  listener_arn = var.listener_arn
  priority     = var.priority
  action {
    type             = var.action_type
    target_group_arn = aws_lb_target_group.target_group.arn
  }
  condition {
    host_header {
      values = var.listener_rule_condition_values
    }
  }
}
/*-------------------------------------------------------*/
resource "aws_launch_template" "launch_template" {
  name                    = "${var.env_name}-${var.applicaton_name}-lt"
  disable_api_termination = var.disable_api_termination
  image_id                = var.ami_id
  instance_type           = var.instance_type
  key_name                = var.instance_key_name
  # vpc_security_group_ids  = var.security_groups
  security_groups  = var.security_groups

  ## Note ##

  # The network_interface block allows you to set the security
  # group for the interface (security groups are scoped by the
  # ENI) so if you define the network_interface block then you
  # are overriding the default ENI and so can  not specify the
  # security groups at the instance level in launch temp.

  dynamic network_interfaces {
    for_each = var.network_interfaces
    content {
      associate_public_ip_address    = network_interfaces.value.associate_public_ip_address
      ipv6_address_count = network_interfaces.value.ipv6_address_count
      ipv4_address_count = network_interfaces.value.ipv4_address_count
      security_groups  = network_interfaces.value.security_groups
    }
  }
  
  dynamic "iam_instance_profile" {
    for_each = var.lt_iam_arn
    content {
      arn = iam_instance_profile.value.arn
    }
  }
  block_device_mappings {
    device_name = var.device_name
    ebs {
      volume_size = var.volume_size
    }
  }
  monitoring {
    enabled = var.monitoring_enabled
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.env_name}-${var.applicaton_name}"
    }
  }
}
/*-------------------------------------------------------*/
resource "aws_autoscaling_group" "autoscaling_group" {
  name                      = "${var.env_name}-${var.applicaton_name}-asg"
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_size
  wait_for_elb_capacity     = var.asg_wait_for_elb_capacity
  health_check_grace_period = var.asg_health_check_grace_period
  health_check_type         = var.asg_health_check_type
  force_delete              = var.asg_force_delete
  default_cooldown          = var.asg_default_cooldown
  target_group_arns         = ["${aws_lb_target_group.target_group.arn}"]
  vpc_zone_identifier       = var.instance_subnets
  termination_policies      = var.asg_termination_policies
  suspended_processes       = var.asg_suspended_processes

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = var.launch_template_version
  }
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
  lifecycle {
    create_before_destroy = true
  }
}
