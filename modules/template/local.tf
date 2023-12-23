locals {
  vpc ={
    name = "${var.prefix}-main"
    cidr = var.vpc_cidr
    azs = ["${var.region}${var.subnet1_zone}", "${var.region}${var.subnet2_zone}"]  
    public_subnets = ["var.subnet1_cidr", "var.subnet2_cidr"]
    public_subnet_tags_per_az = {   
        "${var.region}${var.subnet1_zone}" = {
            name = "${var.prefix}-public_${var.subnet1_zone}"
        }
        
      "${var.region}${var.subnet2_zone}" = {
            name = "${var.prefix}-public_${var.subnet2_zone}"
      }
        
    }
    tags = {    
        Name = "${var.prefix}-main"
    } 
  }
  tags = {
    #provide any tag if necessary
  }
}