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
