 // ec2 instance creation along with the VPC creation.
     
provider "aws" {
  
region = "us-east-1"
}

resource "aws_instance" "newserver" {

 
 ami = "ami-079db87dc4c10ac91"

   instance_type = "t2.micro"
   key_name = "anand"
   subnet_id = aws_subnet.demo-sub.id
   vpc_security_group_ids = [ aws_security_group.demo-sg.id]
  tags = {
    name = "newserver"
    env = "dev"
  }
}

  // vpc creation 
resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.10.0.0/16"
 tags = {
    Name = "demo-vpc"
  }

}
  // subnet creation
resource "aws_subnet" "demo-sub" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.10.1.0/24"

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
  
