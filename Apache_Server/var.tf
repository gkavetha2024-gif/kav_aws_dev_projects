variable "ami" {
  default = "ami-0b6d9d3d33ba97d99"
}

variable "instance_type" {
  default = "t3.micro"
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