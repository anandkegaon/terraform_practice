locals {
  staging_env = "staging"
}


resource "aws_instance" "server" {

    ami = var.osid
  
   // key_name = "1213"  // (give the downloded key name from aws ) //
    instance_type = var.instance_type
    associate_public_ip_address = true
    
   
    tags = {
        "Name"="${local.staging_env}-sevrer"
    }

  
}
