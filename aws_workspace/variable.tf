variable "region" {
    default = "us-east-1"
    type = string
    description = "region where we want to create server"

}

variable "vpc_cidr" {
  
  default = "10.0.0.0/16"
  type = string
  description = "CIDR block of the vpc"
}

variable "subnet_cidr_public1" {
    default = "10.0.1.0/24"
  type = string
  description = "CIDR block of the public subnet"

  
}

variable "subnet_cidr_private1" {
  
  default = "10.0.2.0/24"
  type = string
  description = "CIDR block of the private subnet"

}

variable "subnet_zone1" {

  default = "us-east-1a"
  type = string
  description = "availability zone of the subnet"
  
}

variable "subnet_cidr_public2" {
    default = "10.0.3.0/24"
  type = string
  description = "CIDR block of the public subnet"

  
}

variable "subnet_cidr_private2" {
  
  default = "10.0.4.0/24"
  type = string
  description = "CIDR block of the private subnet"

}

variable "subnet_zone2" {

  default = "us-east-1b"
  type = string
  description = "availability zone of the subnet"
  
}

variable "name" {

    default = "bangalore"
    type = string
  
}

