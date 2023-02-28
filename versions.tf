terraform {
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = "~> 1.10.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.37.0"
    }
  }
}