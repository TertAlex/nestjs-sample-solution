resource "aws_elasticache_cluster" "redis1" {
  cluster_id           = "${module.variables.element_prefix}-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.0"
  port                 = 6379
  security_group_ids   = [var.data_sg_id]
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name

  tags = {
    Name        = "${module.variables.element_prefix}-redis"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "${module.variables.element_prefix}-redis-subnet-group"
  subnet_ids = var.data_subnets

  tags = {
    Name        = "${module.variables.element_prefix}-redis-subnet-group"
    Environment = module.variables.env_prefix
    Terraform   = "true"
  }
}
