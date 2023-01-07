output "public_subnet_ids" {
  value = [for index, item in aws_subnet.public_subnets : item.id]
}

output "private_subnet_ids" {
  value = [for index, item in aws_subnet.private_subnets : item.id]
}

output "data_subnet_ids" {
  value = [for index, item in aws_subnet.data_subnets : item.id]
}

resource "aws_subnet" "public_subnets" {
  for_each          = toset(module.variables.availability_zones)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(module.variables.cidr_block, 8, index(module.variables.availability_zones, each.value))
  availability_zone = each.key

  tags = {
    Name        = "${module.variables.element_prefix}-${each.key}-public-subnet"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "aws_subnet" "private_subnets" {
  for_each          = toset(module.variables.availability_zones)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(module.variables.cidr_block, 8, index(module.variables.availability_zones, each.value) + length(module.variables.availability_zones))
  availability_zone = each.key

  tags = {
    Name        = "${module.variables.element_prefix}-${each.key}-private-subnet"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "aws_subnet" "data_subnets" {
  for_each          = toset(module.variables.availability_zones)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(module.variables.cidr_block, 8, index(module.variables.availability_zones, each.value) + length(module.variables.availability_zones) * 2)
  availability_zone = each.key

  tags = {
    Name        = "${module.variables.element_prefix}-${each.key}-data-subnet"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}
