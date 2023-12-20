variable "region" {
    type = string
    default = "us-east-1"
    description = "AWS region need to mention"

}

variable "prefix" {
    type = string
    default = "iaas"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
  
}

variable "environment" {
    type = string
    default = "dev"
  
}
variable "subnet1_zone" {
  description = "Zone within the AWS region that first public subnet should be placed in"
  type        = string
  default     = "a"
}

variable "subnet2_zone" {
  description = "Zone within the AWS region that second public subnet should be placed in"
  type        = string
  default     = "c"
}