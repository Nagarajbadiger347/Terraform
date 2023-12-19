resource "aws_instance" "server1" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.ssh_key.id
    subnet_id = aws_subnet.public_a.id
    vpc_security_group_ids = [aws_security_group.server.id]

    user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y && sudo apt install nginx -y
    echo "Hello world from $(hostname -f)" > /var/www/html/index.html
    EOF

    tags = {
        Name = "Server1"
    }
    volume_tags = {
        Name = "Server1"

    }
}
resource "aws_instance" "server2" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.ssh_key.id
    subnet_id = aws_subnet.public_b.id
    vpc_security_group_ids = [aws_security_group.server.id]
    
    user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y && sudo apt install nginx -y
    echo "Hello world from $(hostname -f)" > /var/www/html/index.html
    EOF

    tags = {
        Name = "Server2"
    }
    volume_tags = {
        Name = "Server2"
    }

}


data "aws_ami" "ubuntu" {
     most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] 

}

resource "aws_key_pair" "ssh_key" {
    key_name   = "ssh_key"
    public_key   = data.local_file.public_key.content
}


data "local_file" "public_key" {
    filename = "${path.module}/ec2_rsa.pub"

}