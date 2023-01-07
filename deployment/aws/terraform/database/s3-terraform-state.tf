output "terraform_state_bucket" {
  value = aws_s3_bucket.terraform_state.bucket
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "${module.variables.app_name}-terraform-state-${module.variables.region}"
  force_destroy = true

  tags = {
    Name        = "${module.variables.app_name}-terraform-state-${module.variables.region}"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "aws_s3_bucket_acl" "terraform_state_acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_access" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
