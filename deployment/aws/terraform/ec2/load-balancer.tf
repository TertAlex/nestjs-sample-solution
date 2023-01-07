resource "aws_lb" "main" {
  name               = "${module.variables.element_prefix}-main-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_sg_id]
  subnets            = var.public_subnets

  enable_deletion_protection = false

  access_logs {
    bucket  = var.logs_bucket
    prefix  = "${module.variables.env_prefix}-main-lb"
    enabled = true
  }

  tags = {
    Name        = "${module.variables.element_prefix}-main-lb"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}
