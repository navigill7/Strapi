resource "aws_vpc" "strapi_vpc" {
  cidr_block = var.cidr_block
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = "strapi_vpc" 
  }
  
}

resource "aws_internet_gateway" "strapi_igw" {
  vpc_id = aws_vpc.strapi_vpc.id
  tags = {
    Name = "strapi_igw"
  }
  
}

resource "aws_subnet" "strapi_public_subnet" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.strapi_vpc.id
  cidr_block = var.public_subnets[count.index]
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "strapi_public_subnet_${count.index + 1}"
  }
  
}


resource "aws_subnet" "strapi_private_subnet" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.strapi_vpc.id
  cidr_block = var.private_subnets[count.index]
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "strapi_private_subnet_${count.index + 1}"
  }
  
}

resource "aws_route_table" "strapi_route_table" {
  vpc_id = aws_vpc.strapi_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.strapi_igw.id
    }
  tags = {
    Name = "strapi_route_table"
  }
  
}


resource "aws_route_table_association" "strapi_public_subnet_association" {
  count = length(var.public_subnets)
  subnet_id = aws_subnet.strapi_public_subnet[count.index].id
  route_table_id = aws_route_table.strapi_route_table.id
  
  
}


resource "aws_eip" "strapi_nat_eip" {
  domain = "vpc"
  tags = {
    Name = "strapi_nat_eip"
  }
  
}


resource "aws_nat_gateway" "strapi_nat_gateway" {
  allocation_id = aws_eip.strapi_nat_eip.id
  subnet_id = aws_subnet.strapi_public_subnet[0].id
  tags = {
    Name = "strapi_nat_gateway"
  }
  
}


resource "aws_route_table" "strapi_private_route_table" {


   vpc_id = aws_vpc.strapi_vpc.id

   route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.strapi_nat_gateway.id
   }

    tags = {
      Name = "strapi_private_route_table"
    }

}


resource "aws_route_table_association" "strapi_private_subnet_association" {
  count = length(var.private_subnets)
  subnet_id = aws_subnet.strapi_private_subnet[count.index].id
  route_table_id = aws_route_table.strapi_private_route_table.id
  
}
