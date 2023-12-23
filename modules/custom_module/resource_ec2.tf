module "server1_name" {
  source = "./name"

  app_abbrev  = var.prefix
  name        = "server1"
  region      = var.region
  environment = var.environment
  type        = "aws_instance"
}

resource "aws_instance" "server1" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.server_instance_type
    key_name = aws_key_pair.ssh_key.id
    subnet_id = module.vpc.public_subnets[0]
    vpc_security_group_ids = [module.server-sg.vpc_security_group_ids]
    associate_public_ip_address = true
    user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install apache2 -y
    sudo systemctl start apache2
    sudo systemctl enable apache2
    sudo echo "<h1>Hello from server1 $(hostname -f)</h1>" > /var/www/html/index.html
    EOF
    tags = {
        Name = module.server1_name.result
    volume_tags ={
        Name = module.server1_name.result
        }
    }
}

module "server2_name" {
  source = "./name"

  app_abbrev  = var.prefix
  name        = "server2"
  region      = var.region
  environment = var.environment
  type        = "aws_instance"
}

resource "aws_instance" "server2" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.server_instance_type
    key_name = aws_key_pair.ssh_key.id
    subnet_id = module.vpc.public_subnets[1]
    vpc_security_group_ids = [module.server-sg.vpc_security_group_ids]
    associate_public_ip_address = true
    user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install apache2 -y
    sudo systemctl start apache2
    sudo systemctl enable apache2
    sudo echo "<h1>Hello from server2 $(hostname -f)</h1>" > /var/www/html/index.html
    EOF
    tags = {
        Name = module.server2_name.result
    volume_tags ={
        Name = module.server2_name.result
        }
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
  owners = ["099720109477"] # Canonical
}

module "ssh_key_name" {
  source = "./name"

  app_abbrev  = var.prefix
  name        = "sshkey"
  region      = var.region
  environment = var.environment
  type        = "aws_key_pair"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = module.ssh_key_name.result
  public_key = data.local_file.public_key.content
}

data "local_file" "public_key" {
  filename = "${path.module}/ec2_rsa.pub"
}





