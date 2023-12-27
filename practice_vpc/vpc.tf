// create VPC

resource "aws_vpc" "test" {
    cidr_block = "10.0.0.0/16"    
  tags = {
    Name = "test"
  }
}

// subnet creation public 1 & 2

resource "aws_subnet" "public-sub1" {
    vpc_id     = aws_vpc.test.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public-sub1"
  }
}
resource "aws_subnet" "public-sub2" {
    vpc_id     = aws_vpc.test.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public-sub2"
  }
}

// subnet creation private 1 & 2

resource "aws_subnet" "private-sub1" {
    vpc_id     = aws_vpc.test.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "private-sub1"
  }
  
}

resource "aws_subnet" "private-sub2" {
    vpc_id     = aws_vpc.test.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "private-sub2"
  }
  
}
  // internet gateway creation 

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.test.id

  tags = {                                  // only vpc id has to mention
    Name = "gw"
  } 
}

// nat gateway creation public  (create in public subnet ex."aws_subnet.public-sub1.id"/ add gateway also)
resource "aws_nat_gateway" "nat" {             
    allocation_id = aws_eip.nat.id
    subnet_id     = aws_subnet.public-sub1.id   //piublic subnet id 
    depends_on    = [aws_internet_gateway.gw]   // gateway id 
  tags = {
    Name = "gw"
  }  
}

// route table creation public  (assign internet gateway id)

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id    // internet gateway id 
  }

  tags = {
    Name = "public"
  }
}


// route table with private  subnet add nat gw

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.test.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id    // nat gateway id 
  }

  tags = {
    Name = "private"
  } 
}
  // elastic ip creation (add gateway id )
resource "aws_eip" "nat" {
    vpc      = true
    depends_on = [aws_internet_gateway.gw] 
}

// create public route table association add public  subnet and public route table 

resource "aws_route_table_association" "public-sub1" {
    subnet_id      = aws_subnet.public-sub1.id    // add public subnet1
    route_table_id = aws_route_table.public.id    // add public route table
    depends_on = [ aws_route_table.public ]
}
 resource "aws_route_table_association" "public-sub2" {
    subnet_id      = aws_subnet.public-sub2.id    // add public subnet2
    route_table_id = aws_route_table.public.id    // add public route table
    depends_on = [ aws_route_table.public ]
  
 }

// create private route table association add private subnet and private route table 



 resource "aws_route_table_association" "private-sub1" {
    subnet_id      = aws_subnet.private-sub1.id    // add private subnet1
    route_table_id = aws_route_table.private.id    // add private route table
    depends_on = [ aws_route_table.private ]
   
 }

 resource "aws_route_table_association" "private-sub2" {
    subnet_id      = aws_subnet.private-sub2.id    // add private subnet2
    route_table_id = aws_route_table.private.id    // add private route table
    depends_on = [ aws_route_table.private ]
   
 }



