resource "aws_instance" "server1" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name      = aws_key_pair.ssh_key.id
    subnet_id     = aws_subnet.public-a.id
    vpc_security_group_ids = [aws_security_group.server.id]
    user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y && sudo apt install nginx -y
    sudo echo "Hello world from $(hostname -f)" > /var/www/html/index.html
    EOF
    
    tags = {
      Name = "${var.prefix}-server1"

    }
    volume_tags = {
      name ="${var.prefix}-server1"
    }
}

resource "aws_instance" "server2" { 
    ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh_key.id
  subnet_id     = aws_subnet.public-b.id
  vpc_security_group_ids = [aws_security_group.server.id]
  user_data = <<-EOF
  #!/bin/bash
  sudo apt-get update -y && sudo apt install nginx -y
  sudo echo "Hello world from $(hostname -f)" > /var/www/html/index.html
  EOF
  tags = {
    Name = "${var.prefix}-server2"

  }
  volume_tags = {
    name ="${var.prefix}-server2"
  }
}

data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*"]
    }
    filter {
      name = "virtualization-type"
      values = ["hvm"]

    }
    owners = ["099720109477"]   

}

resource "aws_key_pair" "ssh_key" {
    key_name = "${var.prefix}-ssh_key" 
    public_key = data.local_file.public_key.content 
}

data "local_file" "public_key" {
    filename = id_rsa.pub
    
  
}
