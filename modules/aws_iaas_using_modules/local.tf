locals {
  vpc = {
    name = "${var.prefix}-main"
    cidr = "10.0.0.0/16"
    azs  = ["${var.region}${var.subnet1_zone}", "${var.region}${var.subnet2_zone}"]
    public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnet_tags_per_az = {
        "${var.region}${var.subnet1_zone}" = {
            Name = "${var.prefix}-public_${var.subnet1_zone}"
        }
        "${var.region}${var.subnet2_zone}" = {
            Name = "${var.prefix}-public_${var.subnet2_zone}"
        }           
    }
    tags = {
        Name = "${var.prefix}-main"
        Environment = var.environment
    } 
  }
}