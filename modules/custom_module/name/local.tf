locals {
  app_abbrev = replace(var.app_abbrev, "-", "")
  name  = replace(var.name, "-", "")
  environment = replace(var.environment, "-", "")
  region = replace(var.region, "-", "")

  type_ids = {
    "aws_instance" = "ec2"
    "aws_lb" = "alb"
    "aws_security_group" = "sg"
    "aws_vpc" = "vpc"
  }
    type = try(local.type_ids[var.type], "")
}

