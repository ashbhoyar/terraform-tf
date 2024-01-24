resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cird
  instance_tenancy = var.vpc_tenancy
  tags = var.vpc_tags
}


resource "aws_subnet" "public_subnets1" {
 vpc_id     = aws_vpc.main.id
 cidr_block = var.public_subnet_cidrs[0]
 availability_zone = var.subnet_az[0]

 tags = var.Subnet_tag1

}


 resource "aws_subnet" "public_subnets2" {
 vpc_id     = aws_vpc.main.id
 cidr_block = var.public_subnet_cidrs[1]
 availability_zone = var.subnet_az[1]

 tags = var.Subnet_tag2

}

resource "aws_subnet" "public_subnets3" {
 vpc_id     = aws_vpc.main.id
 cidr_block = var.public_subnet_cidrs[2]
 availability_zone = var.subnet_az[2]

 tags = var.Subnet_tag3

}


resource "aws_subnet" "private_subnets1" {
 vpc_id            = aws_vpc.main.id
 cidr_block        = var.private_subnet_cidrs[0]
 availability_zone = var.subnet_az[0]

 tags = var.subnet_tag4
}

resource "aws_subnet" "private_subnets2" {
 vpc_id            = aws_vpc.main.id
 cidr_block        = var.private_subnet_cidrs[1]
 availability_zone = var.subnet_az[1]

 tags = var.subnet_tag5
}

resource "aws_subnet" "private_subnets3" {
 vpc_id            = aws_vpc.main.id
 cidr_block        = var.private_subnet_cidrs[2]
 availability_zone = var.subnet_az[2]

 tags = var.subnet_tag6
}
