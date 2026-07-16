
# Versions 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.40.0"
    }
  }
}

# Authentication to AWS from Terraform code
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

terraform {
  backend "s3" {
    bucket = "amzn-s3-kav-bucket"
    // own s3 bucket name
    key = "kav_terra_Pro/terraform.tfstate"
    // kav_terra_Pro is a folder name in the bucket of amzn-s3-kav-bucket
    region = "us-east-1"
  }
}

# Continuous Integration - Jenkins
resource "aws_instance" "kavdevops_apache" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = ["sg-03e454c2f6f9ef264"]
  subnet_id              = var.subnet_id
  iam_instance_profile   = var.iam_instance_profile
  user_data              = file("apache_web.sh")

  tags = {
    Name        = "kav_apache2_webserver"
    Environment = "Dev"
    ProjectName = "AWS DevOps 2026"
    ProjectID   = "2026"
    CreatedBy   = "IAC_Terraform"
  }
}