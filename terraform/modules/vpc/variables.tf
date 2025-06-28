variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type = string
  default = "vpc"
}

variable "vpc_igw_name" {
  type = string
  default = "internt_gateway"
}

variable "public_subnet_config" {
  description = "Configuration for multiple public subnets"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    name              = string
  }))
  default = {
    public-1 = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "ap-south-1a"
      name              = "public-subnet-1"
    }
    public-2 = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "ap-south-1b"
      name              = "public-subnet-2"
    }
  }
}


variable "public_subnet_name" {
  type = string
  default = "public_subnet"
}

variable "private_subnet_config" {
  description = "Configuration for multiple public subnets"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    name              = string
  }))
  default = {
    private-1 = {
      cidr_block        = "10.0.10.0/24"
      availability_zone = "ap-south-1a"
      name              = "private-subnet-1"
    }
    private-2 = {
      cidr_block        = "10.0.11.0/24"
      availability_zone = "ap-south-1b"
      name              = "private-subnet-2"
    }
  }
}

# variable "private_subnet_cidr" {
#   type = string
#   default = "10.0.3.0/24"
# }

variable "private_subnet_name" {
  type = string
  default = "private_subnet"
}

variable "public_route_table_name" {
  type = string
  default = "public_route_table"
}

variable "private_route_table_name" {
  type = string
  default = "private_route_table"
}

