module "vpc_name" {
    source = "./custom_module/name"

    app_abbrev = var.prefix
    name = local.vpc.name
    region = var.region
    environment = var.environment
    resource_type = "vpc"
}
module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "~> 3.19.0"
    name = module.vpc_name.result
    cidr = local.vpc.cidr
    azs = local.vpc.azs
    public_subnets = local.vpc.public_subnets
    tags = local.vpc.tags
    vpc_tags = local.vpc.tags

}