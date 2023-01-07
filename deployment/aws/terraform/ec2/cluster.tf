resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${module.variables.element_prefix}-cluster"

  tags = {
    Name        = "${module.variables.element_prefix}-cluster"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

data "aws_ami" "amazon_linux_ecs" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm*x86_64*"]
  }
}
