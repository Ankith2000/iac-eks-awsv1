resource "aws_vpc" "main" {
  cidr_block = var.aws_vpc
  enable_dns_support = true
  enable_dns_hostnames = true

tags = {
  Name = "${var.cluster_name}-vpc"
  "kubernetes.io/cluster/${var.cluster_name}" = "shared"
}

}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  availability_zone = var.az_for_private_subnet[count.index]
  cidr_block = var.private_subnet_cidrs[count.index]

  tags = {
    Name = "${var.cluster_name}-private-subnet-${count.index + 1}"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  availability_zone = var.az_for_public_subnet[count.index]
  cidr_block = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.cluster_name}-public-subnet-${count.index + 1}"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.cluster_name}-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id

  route = {
    igw=aws_internet_gateway.igw.id
    cidr_block="0.0.0.0/0"
  }

  tags = {
    Name = "${var.cluster_name}-public-route-table"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  count = length(var.public_subnet_cidrs)
  subnet_id = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table[count.index].id
}


resource "aws_eip" "nat_eip" {
  count = length(var.public_subnet_cidrs)
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  count = length(var.private_subnet_cidrs)
  subnet_id = aws_subnet.private_subnet[count.index].id
  allocation_id = aws_eip.nat_eip[count.index].id
tags = {
  Name = "${var.cluster_name}-nat-gw-${count.index+1}"
}

depends_on = [ aws_internet_gateway.igw ]
}

resource "aws_route_table" "private_route_table" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }
  tags = {
    Name = "${var.cluster_name}-private-route-table"
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = length(var.private_subnet_cidrs)
  route_table_id = aws_route_table.private_route_table[count.index].id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}