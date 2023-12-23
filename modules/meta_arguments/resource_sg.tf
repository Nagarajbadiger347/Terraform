module "server_sg_name" {
    source = "./module/name"
    app_abbrev = var.prefix
    name = "server"
    region =var.region
    environment = var.environment
    type = "aws_security_group"
    
}

module "server-sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "~> 4.17.1"

  name = module.server_sg_name.result
  description = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = [ssh-tcp]
}

module "alb_sg_name" {
    source = "./module/name"
    app_abbrev = var.prefix
    name = "alb"
    region =var.region
    environment = var.environment
    type = "aws_security_group"
  
}

module "alb-sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "~> 4.17.1"

  name = module.alb_sg_name.result
  description = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}