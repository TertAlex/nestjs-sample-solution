output "profile" {
  value = "alex-terraform"
}

output "key_pair_name" {
  value = "tert-alex-key1"
}

output "region" {
  value = "eu-central-1"
}

output "elb_account_id" {
  value = "054676820928"
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "availability_zones" {
  value = ["eu-central-1a", "eu-central-1c"]
}

output "cidr_block" {
  value = "10.10.0.0/16"
}

output "app_name" {
  value = local.app_name
}

output "element_prefix" {
  value = "${local.env_prefix}-${local.app_name}"
}

locals {
  app_name = "sample-app"
}

data "aws_caller_identity" "current" {}
