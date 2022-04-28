provider "aws" {
  region = "ap-south-1"
}

variable "cidr-blocks" {
  description = "these are the cidr blocks for vpc and subnets 1 and 2"
  type = list(object({
     cidr_block = string
     name = string
  }))
}

variable "az-subnet1" {
  description = "this is the availability zone of subnet 1"
}

variable "az-subnet2" {
  description = "this is the availability zone of subnet 2"
}

variable "targetEnvironment" {
  description = "this is the target environment"
}

resource "aws_vpc" "development_vpc" {
  cidr_block = var.cidr-blocks[0].cidr_block
  tags = {
    Name : var.cidr-blocks[0].name
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id            = aws_vpc.development_vpc.id
  cidr_block        = var.cidr-blocks[1].cidr_block
  availability_zone = var.az-subnet1
  tags = {
    Name : var.cidr-blocks[1].name
  }
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id            = aws_vpc.development_vpc.id
  cidr_block        = var.cidr-blocks[2].cidr_block
  availability_zone = var.az-subnet2
  tags = {
    Name : var.cidr-blocks[2].name
  }
}

output "dev-vpc-id" {
  value = aws_vpc.development_vpc.id
}

output "dev-subnet-1-id" {
  value = aws_subnet.dev-subnet-1.id
}

output "dev-subnet-2-id" {
  value = aws_subnet.dev-subnet-2.id
}
