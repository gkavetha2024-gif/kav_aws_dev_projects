variable "ami" {
  default = "ami-0b6d9d3d33ba97d99"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "key_name" {
  default = "vpcawsvpc"
}

variable "vpc_security_group_ids" {
  default = "sg-03e454c2f6f9ef264"
}

variable "subnet_id" {
  default = "subnet-09c5a622121a76040"
}

variable "iam_instance_profile" {
  default = "AWSIAM"
}

// In Aws Role give AmazonS3FullAccess and AmazonEC2FullAccess permissions to the IAM Role kav_devops_pro

// Security Group for Jenkins Server

//  SSH   TCP   22  Anywhere-IPv4   0.0.0.0/0

//  RDP  TCP  3389  Anywhere-IPv4   0.0.0.0/0


//  HTTP  TCP 80 Anywhere-IPv4 0.0.0.0/0


//  HTTPS  TCP  443  Anywhere-IPv4 0.0.0.0/0

// Custom TCP TCP 8080 Anywhere-IPv4 0.0.0.0/0

// Custom TCP TCP 8081 Anywhere-IPv4 0.0.0.0/0

// Custom TCP TCP 8082 Anywhere-IPv4 0.0.0.0/0

// Custom TCP TCP 9000 Anywhere-IPv4 0.0.0.0/0

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "instance_tenancy" {
  default = "default"
} 

variable "enable_dns_support" {
  default = true
}

variable "enable_dns_hostnames" {
  default = true
}

