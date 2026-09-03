variable "vpc_name" {
  description = "Name of the main VPC"
  type        = string
}

variable "zone_a" {
  description = "Primary availability zone"
  type        = string
}

variable "zone_b" {
  description = "Secondary availability zone"
  type        = string
}

variable "public_a_cidr" {
  description = "CIDR for public subnet in zone A"
  type        = string
}

variable "private_a_cidr" {
  description = "CIDR for private subnet in zone A"
  type        = string
}

variable "public_b_cidr" {
  description = "CIDR for public subnet in zone B"
  type        = string
}

variable "private_b_cidr" {
  description = "CIDR for private subnet in zone B"
  type        = string
}

variable "admin_cidr" {
  description = "Public IPv4 address allowed to access administrative services"
  type        = string
}
