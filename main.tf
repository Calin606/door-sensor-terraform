provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = "= 1.0.5"

  required_providers {
    aws = "= 3.63.0"
  }

  backend "s3" {
    bucket = "door-sensor-terraform"
    key    = "tfstate"
    region = "us-east-1"
  }

}
