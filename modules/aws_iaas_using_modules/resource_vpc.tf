module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = local.vpc.azs
  public_subnets  = local.vpc.public_subnets

  public_subnet_tags_per_az = local.vpc.public_subnet_tags_per_az

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = local.tags

  vpc_tags = local.vpc.tags
}
