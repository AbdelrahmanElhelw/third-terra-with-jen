variable "region" {
    description = "AWS region"
    type = string
    default = "us-east-1"
}

variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
  
}

variable "private_subnet_cidr_1" {
    type=string
    
}
variable "private_subnet_cidr_2" {
    type=string
    
}

variable "public_subnet_cidr_1" {
    type=string
    
}
variable "public_subnet_cidr_2" {
    type=string
    
}

variable "subnet_availability_zone_1"{
    description = "AZ for subnett"
    type = string

}

variable "subnet_availability_zone_2"{
    description = "AZ for subnett"
    type = string

}