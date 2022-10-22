variable "ami_id" {
  description = "AMI id to lauch instance"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}
variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = null
}
variable "vpc_id" {
  description = "The VPC ID to launch in"
  type        = string
  default     = null
}
variable "instance_count" {
  default = 1
}