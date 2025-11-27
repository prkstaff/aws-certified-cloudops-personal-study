data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "aws-cloudops-study-terraform-state"
    key    = "study/000_test_VPC/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}
