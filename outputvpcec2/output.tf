output "instance-id" {
value = aws_instance.newserver.id
  
}

output "public_ip" {
  value = aws_instance.newserver.public_ip
}

output "private_ip" {
    value = aws_instance.newserver.private_ip

  
}