resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${module.variables.element_prefix}-internet-gateway"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}