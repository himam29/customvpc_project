resource "aws_instance" "web" {
  ami           = "ami-09b90e09742640522"
  instance_type = "t2.micro"
  key_name = "AWS-Keypair"
  subnet_id = aws_subnet.public[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count = 2

  tags = {
    Name = "WebServer"
  }

  provisioner "file" {
    source = "./AWS-Keypair.pem"
    destination = "/home/ec2-user/AWS-Keypair.pem"
  
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = "${filebase64("AWS-Keypair.pem")}"
    }  
  }
}

resource "aws_instance" "db" {
  ami           = "ami-09b90e09742640522"
  instance_type = "t2.micro"
  key_name = "AWS-Keypair"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    Name = "DB Server"
  }
}
