provider "aws" {
  region = "ap-south-1"
}

resource "tls_private_key" "privatekey" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "keypair" {
  key_name   = "mothilal"
  public_key = tls_private_key.privatekey.public_key_openssh
}

resource "aws_security_group" "securitygroup" {
  name        = "allow_ssh"
  description = "allow ssh inbound traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "intro" {
  count                   = 3 # This will create 3 instances
  ami                     = "ami-0ec0e125bb6c6e8ec"
  instance_type           = "t2.micro"
  key_name                = aws_key_pair.keypair.key_name
  vpc_security_group_ids  = [aws_security_group.securitygroup.id]
  tags = {
    Name = "terraform-mothi-created-${count.index}"
  }
}

output "instance_public_ips" {
  value = aws_instance.intro[*].public_ip
}

output "instance_ids" {
  value = aws_instance.intro[*].id
}

output "private_key_pem" {
  value     = tls_private_key.privatekey.private_key_pem
  sensitive = true
}

