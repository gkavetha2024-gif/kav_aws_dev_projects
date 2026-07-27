
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

# Create VPC
resource "aws_vpc" "kavdev_vpc" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  
  tags = {
    Name        = "kavdev_vpc"
    Environment = "Dev"
    ProjectName = "AWS DevOps 2026"
    ProjectID   = "2026"
    CreatedBy   = "IAC_Terraform"
  }
}

# Subnet  -  2Public & 6 Private Subnets
resource "aws_subnet" "kavdev_public_subnet1" {
  vpc_id                  = aws_vpc.kavdev_vpc.id
  cidr_block              = "10.0.1.0/28"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name       = "kavdev_public_subnet1"
    created_by = "IAC_Terraform"
  }
}
resource "aws_subnet" "kavdev_public_subnet2" {
  vpc_id                  = aws_vpc.kavdev_vpc.id
  cidr_block              = "10.0.2.0/28"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name       = "kavdev_public_subnet2"
    created_by = "IAC_Terraform"
  }
}

# Private 
resource "aws_subnet" "kavdev_private_subnet1" {
  vpc_id            = aws_vpc.kavdev_vpc.id
  cidr_block        = "10.0.4.0/28"
  availability_zone = "us-east-1a"

  tags = {
    Name       = "kavdev_private_subnet1"
    created_by = "IAC_Terraform"
  }
}
resource "aws_subnet" "kavdev_private_subnet2" {
  vpc_id            = aws_vpc.kavdev_vpc.id
  cidr_block        = "10.0.5.0/28"
  availability_zone = "us-east-1b"

  tags = {
    Name       = "kavdev_private_subnet2"
    created_by = "IAC_Terraform"
  }
}
resource "aws_subnet" "kavdev_private_subnet3" {
  vpc_id            = aws_vpc.kavdev_vpc.id
  cidr_block        = "10.0.6.0/28"
  availability_zone = "us-east-1a"

  tags = {
    Name       = "kavdev_private_subnet3"
    created_by = "IAC_Terraform"
  }
}
resource "aws_subnet" "kavdev_private_subnet4" {
  vpc_id            = aws_vpc.kavdev_vpc.id
  cidr_block        = "10.0.7.0/28"
  availability_zone = "us-east-1b"

  tags = {
    Name       = "kavdev_private_subnet4"
    created_by = "IAC_Terraform"
  }
}
resource "aws_subnet" "kavdev_private_subnet5" {
  vpc_id            = aws_vpc.kavdev_vpc.id
  cidr_block        = "10.0.8.0/28"
  availability_zone = "us-east-1a"

  tags = {
    Name       = "kavdev_private_subnet5"
    created_by = "IAC_Terraform"
  }
}
resource "aws_subnet" "kavdev_private_subnet6" {
  vpc_id            = aws_vpc.kavdev_vpc.id
  cidr_block        = "10.0.9.0/28"
  availability_zone = "us-east-1b"

  tags = {
    Name       = "kavdev_private_subnet6"
    created_by = "IAC_Terraform"
  }
}