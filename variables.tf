variable "wp_ami" {
  description = "Amazon Linux 2023 AMI for WordPress (us-west-2)"
  type        = string
  default     = "ami-04f9aa2b7c7091927"
}

variable "db_ami" {
  description = "Amazon Linux 2023 AMI for MySQL (us-west-2)"
  type        = string
  default     = "ami-04f9aa2b7c7091927"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "noor-key"
}
