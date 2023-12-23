variable "prefix" {
    description = "prefix which u wanted to use"
    type = string
    default = "example"
      
}

variable "instance_type" {
    description = "instance type which u wanted to use"
    type = string
    default = "t2.micro"
  
}
variable "region" { 
    description = "region which u wanted to use"
    type = string
    default = "us-east-1"
  
}
variable "subnet1_zone" {
    description = "subnet1 zone which u wanted to use"
    type = string
    default = "a"
  
}

variable "subnet2_zone" {
    description = "subnet2 zone which u wanted to use"
    type = string
    default = "b"
}

variable "environment" {
    description = "environment which u wanted to use"
    type = string
    default = "d"
  

}

variable "num_web_servers" {
    description = "number of web servers which u wanted to use"
    type = number
    default = 2

    validation {
      condition = var.num_web_servers >= 2 && var.num_web_servers <= 10
      error_message = "The number of web servers must be between 2 and 10."
    
    }
}

