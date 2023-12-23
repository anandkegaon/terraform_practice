
/// loxcal string value is used for changing the value at one place which will reflect in all the code , whererever we mentioned the local staging value. ///



provider "aws" {
   region     = "us-east-1"
   
}

locals {
  staging_env = "anand"    // staging_env = "anand"  whereever the tags we given there it will display as " anand "
 }

resource "aws_vpc" "staging-vpc" {
  cidr_block = "10.5.0.0/16"

  tags = {
    Name = "${local.staging_env}-vpc-tag"     /// anand-vpc-tag ///
  }
}

resource "aws_subnet" "staging-subnet" {
  vpc_id = aws_vpc.staging-vpc.id
  cidr_block = "10.5.0.0/16"

  tags = {
    Name = "${local.staging_env}-subnet-tag"   /// anand-subnet-tag ///
  }
}

resource "aws_instance" "ec2_example" {
   
   ami           = "ami-079db87dc4c10ac91"
   instance_type = "t2.micro"
   subnet_id = aws_subnet.staging-subnet.id
   
   tags = {
           Name = "${local.staging_env} - Terraform EC2"   /// anand-terraform ec2 ///
   }
}
