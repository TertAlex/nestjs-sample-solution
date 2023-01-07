module "variables" {
  source = "../variables"
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_sg_id" {
  type = string
}

variable "private_sg_id" {
  type = string
}

variable "logs_bucket" {
  type = string
}
