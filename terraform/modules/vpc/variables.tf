variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_tags" {
  description = "A map of tags to assign to the VPC"
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "A list of subnet configurations"
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
}
