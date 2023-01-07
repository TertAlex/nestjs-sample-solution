output "logs_bucket" {
  value = aws_s3_bucket.logs.bucket
}

resource "aws_s3_bucket" "logs" {
  bucket        = "${module.variables.app_name}-logs-${module.variables.region}"
  force_destroy = true

  tags = {
    Name        = "${module.variables.app_name}-logs-${module.variables.region}"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "aws_s3_bucket_acl" "logs_acl" {
  bucket = aws_s3_bucket.logs.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "logs_access" {
  bucket = aws_s3_bucket.logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "logs_access" {
  bucket = aws_s3_bucket.logs.id

  rule {
    id = "30 days"

    expiration {
      days = 30
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_elb" {
  bucket = aws_s3_bucket.logs.id
  policy = data.aws_iam_policy_document.allow_access_from_elb.json
}

data "aws_iam_policy_document" "allow_access_from_elb" {
  version = "2012-10-17"
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [module.variables.elb_account_id]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.logs.arn}/${module.variables.env_prefix}-main-lb/AWSLogs/${module.variables.account_id}/*"
    ]
  }
}
