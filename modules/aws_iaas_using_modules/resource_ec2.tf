resource "aws_instance" "server1" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = aws_key_pair.ssh_key.id
    vpc_security_group_ids = [module.server-sg.security_group_id]
    subnet_id = module.vpc.public_subnets[0]
    user_data = <<-EOF
        #!/bin/bash
        sudo apt-get update -y
        sudo apt-get install -y nginx 
        sudo echo "Hello from $(hostname -f)" > /var/www/html/index.html
        EOF
    
    
    tags = {
        Name = "${var.prefix}-server1"

    }
    volume_tags = {
        Name = "${var.prefix}-server1"
  
    }
}

resource "aws_instance" "server2" { 
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = aws_key_pair.ssh_key.id  
    subnet_id = module.vpc.public_subnets[1]
    vpc_security_group_ids = [module.server-sg.security_group_id]
    
       user_data = <<-EOF
        #!/bin/bash
        sudo apt-get update -y
        sudo apt-get install -y nginx 
        sudo echo "Hello from $(hostname -f)" > /var/www/html/index.html
        EOF
    tags = {
        Name = "${var.prefix}-server2"
    }
   volume_tags = {
        Name = "${var.prefix}-server2"
  
    }
}   

data "aws_ami" "ubuntu" {   
    most_recent = true
    owners = ["099720109477"] # Canonical

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    
    }
}
resource "aws_key_pair" "ssh_key" {
    key_name = "${var.prefix}-ssh_key"
    public_key = data.local_file.public_key.content
}


data "local_file" "public_key" {
    filename = "${path.module}/ec2_rsa.pub"
}
