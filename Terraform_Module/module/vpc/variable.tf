
variable "region" {
    default = "us-east-1"
 
}

variable "osid" {
    default = "ami-079db87dc4c10ac91"
 
}

variable "instance_type" {
    default = "t2.micro"
  
}

variable "key_name" {
    default = "anand"

}
variable "tags" {
    default = "anand"

}

variable "subnet_id" {

    default = "10.10.1.0/24"
  
}
variable "vpc_id" {
  
    default = "10.10.0.0/16"
  

}