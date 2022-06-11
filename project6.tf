//vpc
resource "aws_vpc" "Proj6-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "Proj6-vpc"
  }
}
//Web subnet - public subnet 1
resource "aws_subnet" "Proj6-subnet-pub1" {
  vpc_id     = aws_vpc.Proj6-vpc.id
  cidr_block = var.Public_Subnet1_cidr
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "Proj6-subnet-pub1"
  }
}

//Web subnet - public subnet 2
resource "aws_subnet" "Proj6-subnet-pub2" {
  vpc_id     = aws_vpc.Proj6-vpc.id
  cidr_block = var.Public_subnet2_cidr
  availability_zone = "us-east-1d"
  map_public_ip_on_launch = true

  tags = {
    Name = "Proj6-subnet-pub2"
  }
}

//Application Subnet - private subnet 3
resource "aws_subnet" "Proj6-subnet-prv3" {
  vpc_id     = aws_vpc.Proj6-vpc.id
  cidr_block = var.Private_subnet3_cidr
  availability_zone = "us-east-1c"

  tags = {
    Name = "Proj6-subnet-prv3"
  }
}

//Application Subnet - private subnet 4
resource "aws_subnet" "Proj6-subnet-prv4" {
  vpc_id     = aws_vpc.Proj6-vpc.id
  cidr_block = var.Private_subnet4_cidr
  availability_zone = "us-east-1d"

  tags = {
    Name = "Proj6-subnet-prv4"
  }
}

//Database Subnet - private subnet 5
resource "aws_subnet" "Proj6-subnet-prv5" {
  vpc_id     = aws_vpc.Proj6-vpc.id
  cidr_block = var.Private_subnet5_cidr
  availability_zone = "us-east-1c"

  tags = {
    Name = "Proj6-subnet-prv5"
  }
}

//Database Subnet - private subnet 6
resource "aws_subnet" "Proj6-subnet-prv6" {
  vpc_id     = aws_vpc.Proj6-vpc.id
  cidr_block = var.Private_subnet6_cidr
  availability_zone = "us-east-1d"

  tags = {
    Name = "Proj6-subnet-prv6"
  }
}

//public route table
resource "aws_route_table" "Proj6-rt-pub" {
  vpc_id = aws_vpc.Proj6-vpc.id

  tags = {
    Name = "Proj6-rt-pub"
  }
}

//private route table
resource "aws_route_table" "Proj6-rt-prv" {
  vpc_id = aws_vpc.Proj6-vpc.id

  tags = {
    Name = "Proj6-rt-prv"
  }
}

//Public route table association with web subnet - public subnet 1
resource "aws_route_table_association" "Proj6-PubRT-association1" {
  subnet_id      = aws_subnet.Proj6-subnet-pub1.id
  route_table_id = aws_route_table.Proj6-rt-pub.id
}

//Public route table association with web subnet - public subnet 2
resource "aws_route_table_association" "Proj6-PubRT-association2" {
  subnet_id      = aws_subnet.Proj6-subnet-pub2.id
  route_table_id = aws_route_table.Proj6-rt-pub.id
}

//Private route table association with subnet 3
resource "aws_route_table_association" "Proj6-prvRT-association3" {
  subnet_id      = aws_subnet.Proj6-subnet-prv3.id
  route_table_id = aws_route_table.Proj6-rt-prv.id
}

//Private route table association with subnet 4
resource "aws_route_table_association" "Proj6-prvRT-association4" {
  subnet_id      = aws_subnet.Proj6-subnet-prv4.id
  route_table_id = aws_route_table.Proj6-rt-prv.id
}

//Private route table association with db subnet 5
resource "aws_route_table_association" "Proj6-prvRT-association5" {
  subnet_id      = aws_subnet.Proj6-subnet-prv5.id
  route_table_id = aws_route_table.Proj6-rt-prv.id
}

//Private route table association with db subnet 6
resource "aws_route_table_association" "Proj6-prvRT-association6" {
  subnet_id      = aws_subnet.Proj6-subnet-prv6.id
  route_table_id = aws_route_table.Proj6-rt-prv.id
}

// internet gateway
resource "aws_internet_gateway" "Proj6-igw" {
  vpc_id = aws_vpc.Proj6-vpc.id

  tags = {
    Name = "Proj6-igw"
  }
}


//internet gateway route
resource "aws_route" "Proj6-internet-route" {
  route_table_id            = aws_route_table.Proj6-rt-pub.id
  gateway_id                = aws_internet_gateway.Proj6-igw.id
  destination_cidr_block    = "0.0.0.0/0"
}

// Security group
resource "aws_security_group" "proj6-sg-webserver" {
  name        = "Proj6-sg-webserver"
  description = "Security Group for webservers"
  vpc_id      = aws_vpc.Proj6-vpc.id

  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Proj6-sg-Webserver"
  }
}

resource "aws_security_group" "Proj6-SG-db" {
  name        = "Proj6-SG-Db"
  description = "Security Group for database"
  vpc_id      = aws_vpc.Proj6-vpc.id

  ingress {
    description      = "MySql/Aurora"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Proj6-SG-db"
  }
}

// Database Subnet group 
resource "aws_db_subnet_group" "Proj6-db-Subnets" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.Proj6-subnet-prv5.id, aws_subnet.Proj6-subnet-prv6.id]

  tags = {
    Name = "Proj 6 DB Subnet Group"
  }
}

// RDS provisioning
resource "aws_db_instance" "Project6-RDS" {
  identifier           = "project6-db"
  allocated_storage    = 12
  engine               = var.rds-engine
  engine_version       = var.rds-engine-verion
  instance_class       = var.instance-class
  db_subnet_group_name = aws_db_subnet_group.Proj6-db-Subnets.name
  username             = var.rds-username
  password             = var.rds-password
  //parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = var.skip-final-snapshot
  multi_az = var.rds-multi-az
  vpc_security_group_ids = [aws_security_group.Proj6-SG-db.id]
}


// EC2 instance - web server 1
resource "aws_instance" "proj6-webserver1" {
  ami           = var.ec2-ami
  instance_type = var.ec2-intance-type
  availability_zone = var.availability-zone1
  vpc_security_group_ids = [aws_security_group.proj6-sg-webserver.id]
  subnet_id = aws_subnet.Proj6-subnet-pub1.id


  tags = {
    Name = "Web Server 1"
  }
}


// EC2 instance - web server 2
resource "aws_instance" "proj6-webserver2" {
  ami           = var.ec2-ami
  instance_type = var.ec2-intance-type
 availability_zone = var.availability-zone2
  vpc_security_group_ids = [aws_security_group.proj6-sg-webserver.id]
  subnet_id = aws_subnet.Proj6-subnet-pub2.id


  tags = {
    Name = "Web Server 2"
  }
}

// Application load balancer
resource "aws_lb" "Project6-lb" {
  name               = "Project6-Load-Balancer"
  internal           = false
  load_balancer_type = var.lb-type
  security_groups    = [aws_security_group.proj6-sg-webserver.id]
  subnets            = [aws_subnet.Proj6-subnet-pub1.id, aws_subnet.Proj6-subnet-pub2.id]

  }
