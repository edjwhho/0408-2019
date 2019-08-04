# vpc.tf 
# Create VPC/Subnet/Security Group/ACL


# create the VPC
resource "aws_vpc" "DEV_TEST" { # end resource
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy
  enable_dns_support   = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames

  tags = {
    Name = var.tagnames
  }
}

# create the Subnet
resource "aws_subnet" "DEV_TEST_Subnet" { # end resource
  vpc_id                  = aws_vpc.DEV_TEST.id
  cidr_block              = var.subnetCIDRblock
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZone
  tags = {
    Name = "ITS-USWest1-Dev-Public-1a"
  }
}

###  
# Create the Security Group
resource "aws_security_group" "DEV_TEST_Security_Group" { # end resource
  vpc_id      = aws_vpc.DEV_TEST.id
  name        = "DEV TEST Security Group"
  description = "DEV TEST Security Group"

  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # HTTP access from the VPC
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  tags = {
    Name = "US-WEST-1-DEV TEST Security Group"
  }
}

###
# create VPC Network access control list
resource "aws_network_acl" "DEV_TEST_Security_ACL" { # end resource
  vpc_id     = aws_vpc.DEV_TEST.id
  subnet_ids = [aws_subnet.DEV_TEST_Subnet.id]

  # allow port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 22
    to_port    = 22
  }

  # allow ingress ephemeral ports 
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 80
    to_port    = 80
    #from_port  = 1024
    #to_port    = 65535
  }

  # allow egress ephemeral ports
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 1024
    to_port    = 65535
  }
  tags = {
    Name = "US-WEST-1-DEV TEST ACL"
  }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "DEV_TEST_GW" { # end resource
  vpc_id = aws_vpc.DEV_TEST.id
  tags = {
    Name = "US-WEST-1-DEV TEST Internet Gateway"
  }
}

# Create the Route Table
resource "aws_route_table" "DEV_TEST_route_table" { # end resource
  vpc_id = aws_vpc.DEV_TEST.id
  tags = {
    Name = "US-WEST-1-DEV TEST Route Table"
  }
}

# Create the Internet Access
resource "aws_route" "DEV_TEST_internet_access" { # end resource
  route_table_id         = aws_route_table.DEV_TEST_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.DEV_TEST_GW.id
}

# Associate the Route Table with the Subnet

resource "aws_route_table_association" "DEV_TEST_association" { # end resource
  subnet_id      = aws_subnet.DEV_TEST_Subnet.id
  route_table_id = aws_route_table.DEV_TEST_route_table.id
}

# end vpc.tf
