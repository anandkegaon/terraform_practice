locals {
  staging_env = "stage"     // give the local name which u want to mention. ex . stage , temp , test //
}                           //  "${local.staging_env}"  add this in the tags section //

## Multi locals also we can assign in Terraform using below command //

# Here my_second_local is referencing to my_first_local     

locals {
  my_second_local = "anand-${local.my_first_local}"
} 

# here my_third_local is referencing to my_second_local

locals {
  
  my_third_local = "kegaon-${local.my_second_local}"
}

resource "aws_instance" "server" {

    ami = var.osid
  
   // key_name = "1213"  // (give the downloded key name from aws ) //
    instance_type = var.instance_type
    associate_public_ip_address = true
    
   
    tags = {
        "Name"="${local.my_second_local}-sevrer"    // add this value "${local.staging_env}" in the tags section , 
                                                              so that whaterver we will mention in the locals it will reflect here //
    }

  
}
