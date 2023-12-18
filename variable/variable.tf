variable "name" {
  type        = any
  default     = "null"
  description = "optional"
}

variable "string_list" {
  type        = list(string)
  default     = ["string1","string2"]
  description = "optional"
}
variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "description"
}

variable "qty" {
  type        = number
  default     = "0"
  description = "description"
}

variable "vpc_config {
  type        = object({
    name = string
    cidr = optional(string, "10.0.0.0/16")
    subnets = optional(object({
        public = optional(string, "10.0.0.0/24")
        private = optional(string, "10.0.1.0/24")
    }), {})
})
  default     = {
    name ='myvpc'
  }
  description = "description"
  validation {
      condition = can()
  }
}



