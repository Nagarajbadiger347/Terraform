module "server_name" {
  source = "./module/name"
  count   = var.num_web_servers

  name = "server${count.index}"
  app_abbrev = var.prefix
  env = var.environment
  region = var.region
  type = "aws_instance"
}

resource "aws_instance" "server" {
    count = var.num_web_servers
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = aws_key_pair.ssh_key.id
    subnet_id = module.vpc.public_subnets[count.index % 2]
    vpc_security_group_ids = [module.server-sg.vpc_security_group_id]

    user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y && sudo apt install -y nginx
    echo "Hello World from (hostname -f)" > /var/www/html/index.html
    EOF

    tags = {
        name = module.server_name[count.index].result
    }
    volume_tags = {
        name = module.server_name[count.index].result
    }

}

data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    
    }
}
module "ssh_key_name" {
    source = "./module/name"
    name = "ssh_key"
    app_abbrev = var.prefix
    env = var.environment
    region = var.region
    type = "aws_key_pair"
}

resource "aws_key_pair" "ssh_key" {
    key_name = module.ssh_key_name.result
    public_key = data.local_file.public_key.content
  
}
data "local_file" "public_key" {
    filename = "$path.module}/ec2_rsa.pub"
}

