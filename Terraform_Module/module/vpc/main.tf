terraform {
  required_version = ">=0.12"
}


provider "aws" {

    region = var.region
  
}

resource "aws_instance" "server1" {

    ami = var.osid
    instance_type = var.instance_type
    key_name = var.key_name
    
    subnet_id = var.subnet_id
    
    tags = {
        name = "${var.tags}-ec2"
          
    }
  
}

resource "aws_security_group" "sga" {
    name = "sg"
    vpc_id = var.vpc_id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        name = "${var.tags}-sg"
          }

  
}