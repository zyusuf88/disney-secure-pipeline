terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

terraform {
  required_version = ">= 1.6, < 2.0"
}


resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name        = "${var.project_name}-vpc"
    environment = var.environment
  }
}


resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_1
  availability_zone       = var.az_1
  map_public_ip_on_launch = var.map_public_ip_on_launch


  tags = {
    Name        = "${var.project_name}-public-subnet-1"
    environment = var.environment
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_2
  availability_zone       = var.az_2
  map_public_ip_on_launch = var.map_public_ip_on_launch


  tags = {
    Name        = "${var.project_name}-public-subnet-2"
    environment = var.environment
  }
}


resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_subnet_1
  availability_zone       = var.az_1
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.project_name}-private-subnet-1"
    environment = var.environment
  }
}

resource "aws_subnet" "private_2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_subnet_2
  availability_zone       = var.az_2
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.project_name}-private-subnet-2"
    environment = var.environment
  }
}


resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name        = "${var.project_name}-igw"
      environment = var.environment
    }
  )
}



resource "aws_eip" "nat_1" { domain = "vpc" }
resource "aws_nat_gateway" "nat_1" {
  subnet_id     = aws_subnet.public_1.id
  allocation_id = aws_eip.nat_1.id
  tags = { Name = "${var.project_name}-nat-1", environment = var.environment }
}

resource "aws_eip" "nat_2" { domain = "vpc" }
resource "aws_nat_gateway" "nat_2" {
  subnet_id     = aws_subnet.public_2.id
  allocation_id = aws_eip.nat_2.id
  tags = { Name = "${var.project_name}-nat-2", environment = var.environment }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = var.default_route
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name        = "${var.project_name}-public-rt"
    environment = var.environment
  }
}

resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = var.default_route
    nat_gateway_id = aws_nat_gateway.nat_1.id
  }
  tags = { Name = "${var.project_name}-private-rt-1", environment = var.environment }
}

resource "aws_route_table" "private_2" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = var.default_route
    nat_gateway_id = aws_nat_gateway.nat_2.id
  }
  tags = { Name = "${var.project_name}-private-rt-2", environment = var.environment }
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_1.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_2.id
}


resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}
