provider "aws" {
  region = "eu-central-1"  // specify the range
  # version = "~> 5.0"  # Specify a valid version range
}



resource "aws_s3_bucket" "buck" {
  bucket = "anandkegaon"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
