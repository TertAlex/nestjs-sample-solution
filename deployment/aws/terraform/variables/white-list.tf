output "bastion_access" {
  value = [
    {
      cidr_blocks = ["0.0.0.0/0"],
      port        = 22,
      protocol    = "tcp",
      description = "all"
    }
  ]
}
