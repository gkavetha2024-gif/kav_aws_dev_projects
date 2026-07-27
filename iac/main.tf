
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
    key = "kav_terra_Pro/infra_dev/terraform.tfstate"
    // kav_terra_Pro is a folder name in the bucket of amzn-s3-kav-bucket
    region = "us-east-1"
  }
}

# Continuous Integration - Jenkins
resource "aws_instance" "kavdevops_jenkins" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = ["sg-03e454c2f6f9ef264"]
  subnet_id              = var.subnet_id
  iam_instance_profile   = var.iam_instance_profile
  user_data              = file("jenkins.sh")

  tags = {
    Name        = "kav_webserver"
    Environment = "Dev"
    ProjectName = "AWS DevOps 2026"
    ProjectID   = "2026"
    CreatedBy   = "IAC_Terraform"
  }
}


# Continuous Static Code Analysis Tool - SonarQube
resource "aws_instance" "kavdevops_sonarqube" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = ["sg-03e454c2f6f9ef264"]
  iam_instance_profile   = var.iam_instance_profile
  user_data              = file("sonarqube.sh")

  tags = {
    Name        = "kav_sonarqube"
    Environment = "Dev"
    ProjectName = "AWS DevOps 2026"
    ProjectID   = "2026"
    CreatedBy   = "IAC_Terraform"
  }
}

# Continuous Binary Code Repository - JFROG
resource "aws_instance" "kavdevops_jfrog_artifactory" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = ["sg-03e454c2f6f9ef264"]
  iam_instance_profile   = var.iam_instance_profile
  user_data              = file("jfrog_artifactory.sh")
  tags = {
    Name        = "kavdev_jfrog"
    Environment = "Dev"
    ProjectName = "AWS DevOps 2026"
    ProjectID   = "2026"
    CreatedBy   = "IAC_Terraform"
  }
}


# Application Server - Apache Tomcat 
resource "aws_instance" "kavdevops_tomcat" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = ["sg-03e454c2f6f9ef264"]
  iam_instance_profile   = var.iam_instance_profile
  user_data              = file("tomcat.sh")
  tags = {
    Name        = "kav_tomcat"
    Environment = "Dev"
    ProjectName = "AWS DevOps 2026"
    ProjectID   = "2026"
    CreatedBy   = "IAC_Terraform"
  }
}
