variable "app_abbrev" {
  description = "Abbreviation to identify the application or system to which the infrastructure is related"
  type        = string
}

variable "environment" {
  description = "description of the environment"
  type        = string

  validation {
    condition     = contains(["dev", "qa", "stag", "prod"], var.environment)
    error_message = "Value must be be: dev, qa, stag, or prod"
  }
}

variable "region" {
  description = "AWS region that resource resides in"
  type        = string
}

variable "type" {
  description = "The type of resource the name is being generated for"
  type        = string

}

variable "name" {
  description = "Descriptive name of the resource"
  type        = string

}