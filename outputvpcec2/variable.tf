
variable "region" {

    default = "us-east-1"
  
}

variable "os-name" {

    default = "ami-079db87dc4c10ac91"
  
}

variable "instance-type" {

    default = "t2.micro"
  
  
}

variable "key-name" {

    default = "anand"

}
variable "vpc-cidr" {
    default = "10.10.0.0/16"
  
}

variable "subnets-cidr" {
  
  default = "10.10.1.0/24"
}