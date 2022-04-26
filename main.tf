provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = "= 1.0.5"

  required_providers {
    aws = "= 3.63.0"
  }

}
