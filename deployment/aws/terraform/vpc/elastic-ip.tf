output "bastion_eip_id" {
  value = aws_eip.bastion_eip.id
}

resource "aws_eip" "nat_gateway_eip" {
  vpc = true

  tags = {
    Name        = "${module.variables.element_prefix}-nat-gateway-eip"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "aws_eip" "bastion_eip" {
  vpc = true

  tags = {
    Name        = "${module.variables.element_prefix}-bastion-eip"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}