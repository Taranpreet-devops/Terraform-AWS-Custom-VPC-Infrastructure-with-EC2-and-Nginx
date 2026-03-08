output "aws_private_ip"{
value= aws_instance.TerraInstance.private_ip
}

output "aws_public_ip" {
  value= aws_instance.TerraInstance.public_ip
}

output "aws_public_dns"{
value= aws_instance.TerraInstance.public_dns
}