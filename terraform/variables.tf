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

variable "allowed_ips" {
  type        = list(string)
  description = "List of developer IPs"
  default     = []
}