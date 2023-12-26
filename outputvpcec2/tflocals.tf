locals {
  staging_env = "stage"     // give the local name which u want to mention. ex . stage , temp , test //
}


resource "aws_instance" "server" {

    ami = var.osid
  
   // key_name = "1213"  // (give the downloded key name from aws ) //
    instance_type = var.instance_type
    associate_public_ip_address = true
    
   
    tags = {
        "Name"="${local.staging_env}-sevrer"    // add this value "${local.staging_env}" in the tags section , 
                                                              so that whaterver we will mention in the locals it will reflect here //
    }

  
}
