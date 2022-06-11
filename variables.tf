//vpc region
variable "region" {
  description = "AWS Region"
  default = "us-east-1"
  
}

// VPC Cidr block
variable "vpc_cidr" {
  description = "VPC Cidr block"
  default = "10.0.0.0/16"
  
}

// Cidr block for web subnet - puclic subnet 1
variable "Public_Subnet1_cidr" {
  description = "Public Subnet 1 Cidr block"
  default = "10.0.1.0/24"
  
}

// Cidr block for web subnet - public subnet 2
variable "Public_subnet2_cidr" {
  description = "Public Subnet 2 Cidr block"
  default = "10.0.2.0/24"
  
}

// Cidr block for Application subnet - private subnet 3
variable "Private_subnet3_cidr" {
  description = "Private Subnet 3 Cidr block"
  default = "10.0.3.0/24"
  
}

// Cidr block for Application subnet - private subnet 4
variable "Private_subnet4_cidr" {
  description = "Private Subnet 4 Cidr block"
  default = "10.0.4.0/24"
  
}

// Cidr block for Database subnet - private subnet 5
variable "Private_subnet5_cidr" {
  description = "Private Subnet 5 Cidr block"
  default = "10.0.5.0/24"
  
}

// Cidr block for Database subnet - private subnet 6
variable "Private_subnet6_cidr" {
  description = "Private Subnet 6 Cidr block"
  default = "10.0.6.0/24"
  
}

// RDS engine type
variable "rds-engine" {
  default = "mysql"
}

// RDS engine version
variable "rds-engine-verion" {
  default = "5.7"
}

// RDS instance class
variable "instance-class" {
  default = "db.t2.micro"
}

// RDS username
variable "rds-username" {
  default = "Projectdbs"
}

// RDS password
variable "rds-password" {
  default = "Project6dbs"
}

// RDS Skip final snapshot
variable "skip-final-snapshot" {
  default = true
}

// RDS multi az
variable "rds-multi-az" {
  default = true
}

 //EC2 ami
variable "ec2-ami" {
  default = "ami-0022f774911c1d690"
}

 //ec2 instance type
variable "ec2-intance-type" {
  default = "t3.micro"
}

 //availability zone 1
variable "availability-zone1" {
  default = "us-east-1c"
}

 //availability zone 2
variable "availability-zone2" {
  default = "us-east-1d"
}

 //Load balancer type
variable "lb-type" {
  default = "application"
}
