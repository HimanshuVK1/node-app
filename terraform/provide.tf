terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0"
    }
  }
  required_version = ">= 1.10"
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}


terraform {
  backend "s3" {
    bucket       = "terraform-state-file-backend-remote-00"
    key          = "terraform/state/state.tfstate"
    region       = "ap-south-1"
    use_lockfile = true  # Local locking as a fallback
    encrypt      = true
  }
}
