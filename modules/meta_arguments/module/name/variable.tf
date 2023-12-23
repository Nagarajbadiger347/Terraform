variable "app_abbrev" {
  description = "Abbreviation to identify"
  type        = string
}

variable "environment" {
  description = "Single character description"
  type        = string

  validation {
    condition     = contains(["d", "qa", "s", "p"], var.environment)
    error_message = "Value must be be: d, q, s, or p"
  }
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "type" {
  description = "The type of resource"
  type        = string

}

variable "name" {
  description = "Descriptive name of the resource"
  type        = string

}