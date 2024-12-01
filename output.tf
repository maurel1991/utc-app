output "public-ip" {
 value = aws_instance.serv1.public_ip 
}

output "ssh-command" {
  value = "ssh -i ${local_file.key1.filename}  ec2-user@${aws_instance.serv1.public_ip}"
}
