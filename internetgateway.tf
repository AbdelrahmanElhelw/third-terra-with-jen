resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_1.id

  tags = {
    Name = "main-igw"
  }
}


# 2. Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "nat-gateway-eip"
  }
}

# 3. NAT Gateway (وضعناه في الـ Public Subnet الخاصة بـ AZ-A)
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_az1.id

  tags = {
    Name = "main-nat-gateway"
  }

}

# 4. Route Table for Public Subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# 5. Route Table for Private Subnets  (Routes to NAT Gateway)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc_1.id

    route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "private-route-table"
  }
}