  locals {
  staging_env = "anand" 
  }
  
  // vpc creation

resource "aws_vpc" "demo-vpc" {
  cidr_block = var.vpc_id
 tags = {
    Name = "${local.staging_env}-demo-vpc"
  }

}
 // subnet creation
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = var.subnet_id

  tags = {
    Name = "${local.staging_env}-Main"
  }
}

// create IGW internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "${local.staging_env}-demo_igw"
  }
}

// create route table

  resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${local.staging_env}-demo-igw"
  }
}

// associate subnet with route table

resource "aws_route_table_association" "demo-subnet-rt" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.demo-rt.id
}

