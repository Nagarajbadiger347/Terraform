module "bastion_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "bastion-instance"
  associate_public_ip_address = true
  instance_type          = "t2.micro"
  key_name               = module.key_pair.key_pair_name
  monitoring             = true
  vpc_security_group_ids = [module.public-sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "Bastion Instance"
  }
}
module "app_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "app-instance"

  instance_type          = "t2.micro"
  key_name               = module.key_pair.key_pair_name
  monitoring             = true
  vpc_security_group_ids = [module.private-sg.security_group_id]
  subnet_id              = module.vpc.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "App Instance"
  }
}
module "jenkins_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins-instance"

  instance_type          = "t2.micro"
  key_name               = module.key_pair.key_pair_name
  monitoring             = true
  vpc_security_group_ids = [module.private-sg.security_group_id]
  subnet_id              = module.vpc.private_subnets[1]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "Jenkins Instance"
  }
}