# create ec2
resource "aws_instance" "serv1" {
  instance_type = "t2.micro"
  ami = "ami-0195204d5dce06d99"
  key_name = aws_key_pair.key.key_name
  security_groups = [aws_security_group.sg.id]
  user_data = file("userdata.sh")
  associate_public_ip_address = true
  subnet_id = aws_subnet.pub1.id
  tags = {
    Name = "utc-dev-inst"
    Team = "cloud formation"
    Env = "dev"
    create = "OLA"
  }
}

#create ebs volume
resource "aws_ebs_volume" "vol1" {
  availability_zone = aws_instance.serv1.availability_zone
  size = 20
  tags= {
    Name = "devvolume"
    Team = "cloud"
  }
}
#attach volume 
resource "aws_volume_attachment" "name" {
  device_name = "/dev/sdb"
  volume_id = aws_ebs_volume.vol1.id
  instance_id = aws_instance.serv1.id
}
# Key pair 
resource "tls_private_key" "tls" {
  algorithm = "RSA"
  rsa_bits = 2048
}
resource "aws_key_pair" "key" {
  key_name = "utc-key"
  public_key = tls_private_key.tls.public_key_openssh
}
resource "local_file" "key1" {
  filename = "utc-key.pem"
  content = tls_private_key.tls.private_key_pem
}
