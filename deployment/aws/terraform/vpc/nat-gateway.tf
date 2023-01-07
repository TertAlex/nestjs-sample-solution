resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnets[module.variables.availability_zones[0]].id

  tags = {
    Name        = "${module.variables.element_prefix}-nat-gateway"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}
