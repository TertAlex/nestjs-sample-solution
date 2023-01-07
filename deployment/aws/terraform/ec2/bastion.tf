variable "bastion_sg_id" {
  type = string
}

variable "bastion_ami" {
  type    = string
  default = "ami-0a261c0e5f51090b1"
}

variable "bastion_instance_type" {
  type    = string
  default = "t2.micro"
}

output "bastion_instance_id" {
  value = aws_instance.bastion.id
}

resource "aws_instance" "bastion" {
  ami                         = var.bastion_ami
  instance_type               = var.bastion_instance_type
  key_name                    = module.variables.key_pair_name
  vpc_security_group_ids      = [var.bastion_sg_id]
  associate_public_ip_address = true
  subnet_id                   = var.public_subnets[1]

  tags = {
    Name        = "${module.variables.element_prefix}-bastion"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}
