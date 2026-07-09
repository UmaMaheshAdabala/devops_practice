terraform {
  required_version = ">=1.12.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.69.0"
    }
  }
  backend "s3" {
    bucket = "my-terraform-s3-backend-diff-env"
    key    = "terraform.tfstate-stage"
    region = "us-east-1"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "admin-role"

  assume_role {
    role_arn = "arn:aws:iam::368287211388:role/TerraformExecutionRole"
  }

}
