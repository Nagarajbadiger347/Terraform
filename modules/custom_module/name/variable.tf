variable "app_abbrev" {
    description = "abbrivation to application identity or system to which infra is related"
    type = string
}
variable "environment" {
    description = "environment name"
    type = string
    validation {
      condition = contains(["dev","qa","test","prod"], var.environment)
      error_message = "environment must be one of dev, qa, test, prod."

    }
  
}

variable "region" {
    description = "aws region u wanted resource be their"
    type = string 
}
variable "name" {
  description = "name of the resource"
  type = string
}
