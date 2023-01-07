output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "private_sg_id" {
  value = aws_security_group.private_sg.id
}

output "public_sg_id" {
  value = aws_security_group.public_sg.id
}

output "data_sg_id" {
  value = aws_security_group.data_sg.id
}

resource "aws_security_group" "bastion_sg" {
  name        = "${module.variables.element_prefix}-bastion-sg"
  description = "Access to bastion"
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = toset(module.variables.bastion_access)
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${module.variables.element_prefix}-bastion-sg"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "aws_security_group" "public_sg" {
  name        = "${module.variables.element_prefix}-public-sg"
  description = "Public security group for ELB in ${module.variables.env_prefix}"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #  ingress {
  #    from_port   = 443
  #    to_port     = 443
  #    protocol    = "tcp"
  #    cidr_blocks = ["0.0.0.0/0"]
  #  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${module.variables.element_prefix}-public-sg"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "aws_security_group" "private_sg" {
  name        = "${module.variables.element_prefix}-private-sg"
  description = "Private security group in ${module.variables.env_prefix}"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.bastion_sg.id, aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${module.variables.element_prefix}-private-sg"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "aws_security_group" "data_sg" {
  name        = "${module.variables.element_prefix}-data-sg"
  description = "Data security group in ${module.variables.env_prefix}"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.bastion_sg.id, aws_security_group.public_sg.id]
  }

  tags = {
    Name        = "${module.variables.element_prefix}-data-sg"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}