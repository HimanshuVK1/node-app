variable "target_group_name" {
  type = string
  default = "loadbalancer-target-group"
}

variable "vpc_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "security_group_id_alb_sg" {
  type = string
}


variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs in different AZs"
}

variable "iam_instance_profile_name" {
  type = string
}

# variable "alb_sg_id" {
#   type        = string
#   description = "Security group ID for ALB"
# }

variable "acm_certificate_arn" {
  type        = string
  description = "ACM certificate ARN for HTTPS listener"
}