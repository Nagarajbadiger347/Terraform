resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = default
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      name = "${var.prefix}-main"
    }
}

resource "aws_subnet" "public-a" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "${var.region}a"
    map_public_ip_on_launch = true

    tags = {
      name = "${var.prefix}-public-a"
    }

}
resource "aws_subnet" "public-b" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "${var.region}b"
    map_public_ip_on_launch = true

    tags = {
      name = "${var.prefix}-public-b"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.prefix}-igw"
  }
  
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route { 
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "${var.prefix}-public"
    
    }        
}

resource "aws_route_table_association" "public-a" {
  subnet_id = aws_subnet.public-a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-b" {
    subnet_id = aws_subnet.public-b.id
    route_table_id = aws_route_table.public.id
  
}
