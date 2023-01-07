locals {
  instance_type_env = {
    default = "t2.micro"
    dev     = "t2.micro"
    stage   = "t2.micro"
    prod    = "t2.micro"
  }

  instance_type = lookup(local.instance_type_env, module.variables.env_prefix )

  asg_desired_capacity_env = {
    default = 1
    dev     = 1
    stage   = 1
    prod    = 2
  }

  asg_desired_capacity = lookup(local.asg_desired_capacity_env, module.variables.env_prefix )

  asg_max_size_env = {
    default = 1
    dev     = 1
    stage   = 1
    prod    = 2
  }

  asg_max_size = lookup(local.asg_max_size_env, module.variables.env_prefix )

  asg_min_size_env = {
    default = 1
    dev     = 1
    stage   = 1
    prod    = 2
  }

  asg_min_size = lookup(local.asg_min_size_env, module.variables.env_prefix )
}

resource "aws_launch_configuration" "ecs_launch_config" {
  image_id        = data.aws_ami.amazon_linux_ecs.id
  security_groups = [var.private_sg_id]
  instance_type   = local.instance_type
  name_prefix     = "${aws_ecs_cluster.ecs_cluster.name}-"
  key_name        = module.variables.key_pair_name

  root_block_device {
    volume_size = 30
  }
}

resource "aws_autoscaling_group" "ecs_asg" {
  name                      = "${aws_ecs_cluster.ecs_cluster.name}-asg"
  vpc_zone_identifier       = var.private_subnets
  launch_configuration      = aws_launch_configuration.ecs_launch_config.name
  desired_capacity          = local.asg_desired_capacity
  min_size                  = local.asg_min_size
  max_size                  = local.asg_max_size
  health_check_grace_period = 300
  health_check_type         = "EC2"
  termination_policies      = ["NewestInstance", "Default"]

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = aws_ecs_cluster.ecs_cluster.name
  }

  tag {
    key                 = "Environment"
    propagate_at_launch = true
    value               = module.variables.env_prefix
  }
}
