terraform {
  required_version = ">=0.12"
}

provider "aws" {

  region = "us-east-1"
  
}

module "newmodule" {
  source = "./module/vpc"
  
}
