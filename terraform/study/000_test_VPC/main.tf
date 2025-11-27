module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_tags = {
    Name    = "test-vpc"
    project = "aws-certification"
  }
  subnets = {
    private-test = {
      cidr_block        = "10.0.0.0/24"
      availability_zone = "us-east-1a"
    }
  }
}
