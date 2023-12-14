module "public-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "public-sg"
  description = "public-sg"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh-service ports"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_rules = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}
module "private-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "private-sg"
  description = "private-sg"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "ssh-service ports"
      cidr_blocks = "10.0.0.0/16"
    }
  ]
  egress_rules = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}