output "env_prefix" {
  value = local.env_prefix
}

locals {
  env = terraform.workspace

  env_prefix_env = {
    default = "dev"
    dev     = "dev"
    stage   = "stage"
    prod    = "prod"
  }

  env_prefix = lookup(local.env_prefix_env, local.env )
}
