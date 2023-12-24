
provider "aws" {

    region = "us-east-1"
  
}

resource "aws_instance" "server" {

    ami = "ami-079db87dc4c10ac91"
  
   key_name = "1213"  // (give the downloded key name from aws ) //
    instance_type = "t2.micro"
    tags = {
        "Name"="sevrer"
    }

  
}
