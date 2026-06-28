resource "aws_vpc" "vpc_1" {
  cidr_block = var.vpc_cidr
  region=var.region
}



