resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name        = "${module.variables.element_prefix}-public-route-table"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name        = "${module.variables.element_prefix}-private-route-table"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "aws_route_table" "data_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name        = "${module.variables.element_prefix}-data-route-table"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "aws_route_table_association" "public_rta" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_rta" {
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "data_rta" {
  for_each       = aws_subnet.data_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.data_route_table.id
}
