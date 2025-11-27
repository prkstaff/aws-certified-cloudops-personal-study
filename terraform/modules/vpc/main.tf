resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags             = var.vpc_tags
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  for_each          = var.subnets
  cidr_block        = var.subnets[each.key].cidr_block
  availability_zone = var.subnets[each.key].availability_zone
  tags              = var.vpc_tags
}
