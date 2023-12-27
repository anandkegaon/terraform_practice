// vpc creation

resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = {
        name = "${var.name}-vpc"
    }
}

resource "aws_subnet" "public1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_cidr_public1
    availability_zone = var.subnet_zone1
    map_public_ip_on_launch = true
    tags = {
        name = "${var.name}-public-subnet1"
    }

  
}

resource "aws_subnet" "private1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_cidr_private1
    availability_zone = var.subnet_zone1
    tags = {
        name = "${var.name}-private-subnet1"
    }

  
}

resource "aws_subnet" "public2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_cidr_public2
    availability_zone = var.subnet_zone2
    map_public_ip_on_launch = true
    tags = {
        name = "${var.name}-public-subnet2"
    }
  
}

resource "aws_subnet" "private2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_cidr_private2
    availability_zone = var.subnet_zone2
    tags = {
        name = "${var.name}-private-subnet2"
    }
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    depends_on = [aws_vpc.main]
    tags = {
        name = "${var.name}-igw"
    }
  
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public1.id
    depends_on = [aws_internet_gateway.igw]
    tags = {
        name = "${var.name}-nat"
    }

  
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        name = "${var.name}-public-route"
    }
 
}

resource "aws_eip" "nat" {
    vpc = true
    depends_on = [aws_internet_gateway.igw]
    tags = {
        name = "${var.name}-nat-eip"
    
    }
}
 resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
        
    }
    tags = {
        name = "${var.name}-private-route"
    }
   
 }

 

 resource "aws_route_table_association" "public1" {
    subnet_id = aws_subnet.public1.id
    route_table_id = aws_route_table.public.id
    depends_on = [aws_route_table.public]
   
 }

 resource "aws_route_table_association" "public2" {
    subnet_id = aws_subnet.public2.id
    route_table_id = aws_route_table.public.id
    depends_on = [aws_route_table.public]

   
 }

 resource "aws_route_table_association" "private1" {
    subnet_id = aws_subnet.private1.id
    route_table_id = aws_route_table.private.id
    depends_on = [aws_route_table.private]
   
 }

 resource "aws_route_table_association" "private2" {
    subnet_id = aws_subnet.private2.id
    route_table_id = aws_route_table.private.id
    depends_on = [aws_route_table.private]
   
 }
