provider "aws" {
  
    region = var.region
}

resource "aws_instance" "newserver" {

 
    ami = var.os-name

   instance_type = var.instance-type
   key_name = var.key-name
   subnet_id = aws_subnet.demo-sub.id
   vpc_security_group_ids = [ aws_security_group.demo-sg.id]
   associate_public_ip_address = true

  tags = {
    name = "newserver"
    env = "dev"
  }
}

  // vpc creation 
resource "aws_vpc" "demo-vpc" {
  cidr_block = var.vpc-cidr
 tags = {
    Name = "demo-vpc"
  }

}
  // subnet creation
resource "aws_subnet" "demo-sub" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = var.subnets-cidr

  tags = {
    Name = "Main"
  }
}

  // create IGW internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "demo_igw"
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
    Name = "demo-igw"
  }
}

  // associate subnet with route table

resource "aws_route_table_association" "demo-subnet-rt" {
  subnet_id      = aws_subnet.demo-sub.id
  route_table_id = aws_route_table.demo-rt.id
}
  // create security group

  resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
 
  vpc_id      = aws_vpc.demo-vpc.id

  ingress {
    
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg"
  }
}
  