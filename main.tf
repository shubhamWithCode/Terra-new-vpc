
//vpc
resource "aws_vpc" "nike_vpc_main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Nike main vpc"
  }
}

//subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.nike_vpc_main.id
  availability_zone = element(var.azs, 0)
  cidr_block = element(var.public_subnet_cidr , 0)
  tags = {
    Name = "public subnet 1"
  }
}

//2 private subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.nike_vpc_main.id
  count = length(var.private_subnet_cidr)
  cidr_block = element(var.private_subnet_cidr , count.index)
  tags = {
    Name = "private subnet ${count.index + 1}"
  }
}

//internet gateway
resource "aws_internet_gateway" "nike_igw" {
  vpc_id = aws_vpc.nike_vpc_main.id

  tags = {
    Name = "Nike IGW"
  }
}

//default route table (main) is created once the vpc is created
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.nike_vpc_main.id
  tags = {
    Name = "public route table"
  }
}
//igw entry in public route table
resource "aws_route" "public_igw_route" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.nike_igw.id
}

//association of public subnets with public route table
resource "aws_route_table_association" "public_subnet_asso" {
  subnet_id = aws_route_table.public_route_table.id
  route_table_id = aws_route_table.public_route_table.id
}
