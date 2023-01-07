module "variables" {
  source = "./variables"
}

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source          = "./ec2"
  bastion_sg_id   = module.vpc.bastion_sg_id
  public_subnets  = module.vpc.public_subnet_ids
  private_subnets = module.vpc.private_subnet_ids
  public_sg_id    = module.vpc.public_sg_id
  private_sg_id   = module.vpc.private_sg_id
  logs_bucket     = module.database.logs_bucket
}

module "database" {
  source       = "./database"
  data_subnets = module.vpc.data_subnet_ids
  data_sg_id   = module.vpc.data_sg_id
}

provider "aws" {
  region  = module.variables.region
  profile = module.variables.profile
}

terraform {
  required_version = ">= v0.14.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.46.0"
    }
  }

  #  backend "s3" {
  #    region  = module.variables.region
  #    profile = module.variables.profile
  #    bucket  = module.database.terraform_state_bucket
  #    key     = module.variables.env_prefix
  #  }
}

resource "aws_eip_association" "bastion_eip_assoc" {
  instance_id   = module.ec2.bastion_instance_id
  allocation_id = module.vpc.bastion_eip_id
}