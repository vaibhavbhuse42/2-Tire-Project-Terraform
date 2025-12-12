terraform {
  backend "s3" {
    bucket = "aclewala"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}

# -----------------------------
#  VPC
# -----------------------------
resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# -----------------------------
#  SUBNETS
# -----------------------------
resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.private_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-private-subnet"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.public_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet"
  }
}

# -----------------------------
#  INTERNET GATEWAY
# -----------------------------
resource "aws_internet_gateway" "my-IGW" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "${var.project_name}-IGW"
  }
}

# -----------------------------
#  DEFAULT ROUTE TABLE
# -----------------------------
resource "aws_default_route_table" "main-RT" {
  default_route_table_id = aws_vpc.my-vpc.default_route_table_id

  tags = {
    Name = "${var.project_name}-main-RT"
  }
}

# -----------------------------
#  ROUTE: INTERNET → PUBLIC SUBNET
# -----------------------------
resource "aws_route" "aws-route" {
  route_table_id         = aws_default_route_table.main-RT.id
  destination_cidr_block = var.igw_cidr
  gateway_id             = aws_internet_gateway.my-IGW.id
}

# -----------------------------
#  SECURITY GROUP
# -----------------------------
resource "aws_security_group" "my-sg" {
  vpc_id      = aws_vpc.my-vpc.id
  name        = "${var.project_name}-sg"
  description = "allow ssh,http,mysql traffic"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------
#  PUBLIC EC2 INSTANCE
# -----------------------------
resource "aws_instance" "public-server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
  key_name                    = var.key

  tags = {
    Name = "${var.project_name}-public-server"
  }
}

# -----------------------------
#  PRIVATE EC2 INSTANCE
# -----------------------------
resource "aws_instance" "private-server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private-subnet.id
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
  key_name                    = var.key

  tags = {
    Name = "${var.project_name}-private-server"
  }
}
