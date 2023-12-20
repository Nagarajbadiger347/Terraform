module "server-sg" {
    source = "terraform-aws-modules/security-group/aws//modules/http-80"
    version = "~> 4.17.1"
    name = "$var.prefix}-server"
    description = "Security group with HTTP open for entire Internet (IPv4 CIDR), egress ports are all world open"
    vpc_id = module.vpc.vpc_id
    ingress_cidr_blocks = ["0.0.0.0/0"]
    ingress_rules = ["ssh-tcp"]
    


}

module "alb-sg" {
    source = "terraform-aws-modules/security-group/aws//modules/http-80"
    version = "~> 4.17.1"

    name = "$var.prefix}-alb"
    description = "Security group with HTTP open for entire Internet (IPv4 CIDR), egress ports are all world open"
    vpc_id = module.vpc.vpc_id
    
    ingress_cidr_blocks = ["0.0.0.0/0"]
    


} 
  
