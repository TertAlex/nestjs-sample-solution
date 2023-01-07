module "variables" {
  source = "../variables"
}

variable "data_subnets" {
  type = list(string)
}

variable "data_sg_id" {
  type = string
}
