variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "The name of the project, used as a prefix for resource naming"
  default     = "chrono-vcs"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "my_ip" {
  type        = string
  description = "Your local public IP"
}

variable "ssh_key_name" {
  type        = string
  description = "The name of the SSH key pair created in the AWS console"
}