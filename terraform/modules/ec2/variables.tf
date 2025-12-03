variable "key_name" {
  description = "The name of the key pair to use for the EC2 instance"
  type        = string
  default     = null
}

variable "ami" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the EC2 instance"
  type        = list(string)
  default     = []
}

variable "subnet_id" {
  description = "The subnet ID to launch the EC2 instance in"
  type        = string
  default     = null
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = false
}

variable "name" {
  description = "The name tag for the EC2 instance"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the EC2 instance"
  type        = map(string)
  default     = {}
}

variable "project" {
  description = "The project name to tag the EC2 instance with"
  type        = string
}

variable "user_data" {
  description = "The user data to provide when launching the EC2 instance"
  type        = string
  default     = null
}

variable "security_groups" {
  description = "List of security group names to associate with the EC2 instance (for non-VPC instances)"
  type = list(string)
  default = []
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to attach to the EC2 instance"
  type        = string
  default     = null
}
