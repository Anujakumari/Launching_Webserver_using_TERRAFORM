
#  *****  Step-1. Create a VPC/Network  *****

resource "aws_vpc" "vpc_task-5" {
    cidr_block = var.vpc_cidr

    tags = {
      Name = "lwterra"
    }
}   


#  *****  Step-2. Create Internet Gateway  *****

resource "aws_internet_gateway" "gw_task-5" {
    vpc_id = aws_vpc.vpc_task-5.id

    tags = {
      Name = "myigw task-5"
    }
}


#   *****  Step-3. Create Subnet/Lab   *****

resource "aws_subnet" "subnet_task-5" {
  vpc_id     = aws_vpc.vpc_task-5.id
  cidr_block = var.subnet_cidr
  availability_zone= "us-east-1a"
  // map_public_ip_on_launch = true

  tags = {
    Name = "mySubnet_task-5"
  }
}


#  *****   Step-4. Create Routing Table   *****

resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.vpc_task-5.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_task-5.id
  }

  tags = {
    Name = "Routing_Table_task-5"
  }

}


#  *****   Step-5. Associate Routing Table with subnet   *****

resource "aws_route_table_association" "associate_rt" {
  subnet_id      = aws_subnet.subnet_task-5.id
  route_table_id = aws_route_table.myrt.id
}
