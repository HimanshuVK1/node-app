variable "host_zone_id" {
  type = string
  description = "Route 53 host zone id"
}

variable "elb_dns_name" {
  type = string
  description = "Application loadbalancer DNS"
}

variable "records_name" {
  type = string
  description = "Dns name for Route 53"
}