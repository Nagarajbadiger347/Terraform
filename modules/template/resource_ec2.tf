module "server_name" {
  source = "./module/name"
  count  = var.num_web_servers

  app_abbrev  = var.prefix
  name        = "server${count.index}"
  region      = var.region
  environment = var.environment
  type        = "aws_instance"
}


resource "aws_instance" "server" {
  count = var.num_web_servers

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh_key.id
  subnet_id              = module.vpc.public_subnets[count.index % 2]
  vpc_security_group_ids = [module.server-sg.security_group_id]

  user_data = templatefile("./init.tftpl.sh", {
    name  = module.server_name[count.index].result
    index = count.index
  })

  tags = {
    Name = module.server_name[count.index].result
  }

  volume_tags = {
    Name = module.server_name[count.index].result
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
  source = "./module/name"

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