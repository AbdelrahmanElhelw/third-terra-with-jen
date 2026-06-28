resource "aws_subnet" "private_subnet_az1" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.private_subnet_cidr_1
  availability_zone       = var.subnet_availability_zone_1
 

  tags = {
    Name = "Public-Subnet-AZ-1"
  }
}


resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.public_subnet_cidr_1
  availability_zone       = var.subnet_availability_zone_1
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-AZ-1"
  }
}   


resource "aws_subnet" "private_subnet_az2" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.private_subnet_cidr_2
  availability_zone       = var.subnet_availability_zone_2
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-AZ-2"
  }
  
}


resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.public_subnet_cidr_2
  availability_zone       = var.subnet_availability_zone_2
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-AZ-2"
  }
}