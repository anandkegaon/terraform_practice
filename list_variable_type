provider "aws"  {

    region = "us-east-1"
  
}

resource "aws_instance" "server" {

    ami   = "ami-079db87dc4c10ac91"
    key_name = "anand"
    instance_type = "t2.micro"
  tags = {
    Name = "Server"
  } 
}
// list_variable_type // 
// this varible will create IAM users with name " user1,user2,user3 " //
resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

variable "user_names" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["user1", "user2", "user3s"]
}
