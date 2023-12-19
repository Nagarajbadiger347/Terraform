resource "aws_vpc" "main" {
    cidr_block           = "10.0.0.0/16"
    instance_tenancy     = "default"
    enable_dns_support   = "true"
    enable_dns_hostnames = "true"

    tags = {
      name = "main"
    }
}


resource "aws_subnet" "public_a" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "us-east-1a"

    tags = {
      name = "public_a"
    }
}
resource "aws_subnet" "public_b" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.2.0/24"
    map_public_ip_on_launch = "false"
    availability_zone       = "us-east-1a"

    tags = {
      name = "public_b"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
      name = "igw"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id    
  
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        name = "public"
    
    }    
}

resource "aws_route_table_association" "public_a" {
    subnet_id      = aws_subnet.public_a.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}