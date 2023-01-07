resource "aws_db_instance" "main_mysql" {
  identifier                      = "${module.variables.element_prefix}-mysql"
  allocated_storage               = 10
  storage_type                    = "gp2"
  db_subnet_group_name            = aws_db_subnet_group.subnet_group.name
  engine                          = "mysql"
  engine_version                  = "5.7.40"
  instance_class                  = "db.t3.micro"
  username                        = "root"
  password                        = data.aws_secretsmanager_secret_version.mysql_password_main_last.secret_string
  parameter_group_name            = "mysql5"
  skip_final_snapshot             = true
  apply_immediately               = true
  vpc_security_group_ids          = [var.data_sg_id]
  backup_retention_period         = 7
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  deletion_protection = false

  tags = {
    Name        = "${module.variables.element_prefix}-mysql"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "${module.variables.element_prefix}-mysql-subnet-gruop"
  subnet_ids = var.data_subnets

  tags = {
    Name        = "${module.variables.element_prefix}-mysql-subnet-gruop"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "aws_db_parameter_group" "mysql_param_group" {
  name = "mysql5"
  family      = "mysql5.7"

  lifecycle {
    create_before_destroy = true
  }

  parameter {
    apply_method = "immediate"
    name         = "innodb_flush_neighbors"
    value        = "0"
  }

  parameter {
    apply_method = "immediate"
    name         = "innodb_io_capacity"
    value        = "1000"
  }

  parameter {
    apply_method = "immediate"
    name         = "long_query_time"
    value        = "1"
  }

  tags = {
    Name        = "${module.variables.element_prefix}-mysql-param-gruop"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "random_password" "mysql_main_random_password" {
  length  = 20
  special = false
  numeric = true
  upper   = true
  lower   = true
}

resource "aws_secretsmanager_secret" "mysql_password_main_secret" {
  name = "MYSQL_PASSWORD_MAIN"
}

resource "aws_secretsmanager_secret_version" "mysql_password_main_last" {
  secret_id     = aws_secretsmanager_secret.mysql_password_main_secret.id
  secret_string = random_password.mysql_main_random_password.result
}

data "aws_secretsmanager_secret" "mysql_password_main_secret" {
  arn = aws_secretsmanager_secret.mysql_password_main_secret.arn
}

data "aws_secretsmanager_secret_version" "mysql_password_main_last" {
  secret_id = data.aws_secretsmanager_secret.mysql_password_main_secret.arn
}
