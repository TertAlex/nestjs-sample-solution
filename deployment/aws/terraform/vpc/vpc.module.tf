module "variables" {
  source = "../variables"
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

resource "aws_vpc" "vpc" {
  cidr_block = module.variables.cidr_block

  tags = {
    Name        = "${module.variables.element_prefix}-vpc"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}
