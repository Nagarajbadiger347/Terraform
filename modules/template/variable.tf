variable "prefix" {
    description = "resource prefix"
    type = string
    default = "test"
}

variable "instance_type" {
    description = "instance type for the server"
    type = string
    default = "t2.micro"
}

variable "region" {
    description = "aws region where resource u wanted to be"
    type = string
    default = "us-east-1"  
}

variable "subnet1_zone" {
    description = "1st subnet zone"
    type = string
    default = "a"
}

variable "subnet2_zone" {
    description = "2nd subnet zone"
    type = string
    default = "b"

}

variable "environment" {
    description = "identify environment being created"
    type = string
    default = "dev"
  
}
variable "vpc_cidr" {
    description = "vpc cidr block"
    type = string
    default = "10.0.0.0/16"
}
variable "subnet1_cidr" {
    description = "1st subnet cidr"
    type = string
    default = "10.0.0.0/24"
}
variable "subnet2_cidr" {
    description = "2nd subnet cidr"
    type = string
    default = "10.0.1.0/24"
}

variable "num_web_servers" {
    description = "number of web servers"
    type = number
    default = 2
  
    validation {
      condition = var.num_web_servers >= 2 && var.num_web_servers <= 10
      error_message = "number of web servers should be between 2 and 10."
    
    }
  
}

