module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "~>3.19.0"
    name = local.vpc.name
    cidr = local.vpc.cidr
    azs = local.vpc.azs
    public_subnets = local.vpc.public_subnets
    tags = local.vpc.tags
    vpc_tags = local.vpc.tags
}
