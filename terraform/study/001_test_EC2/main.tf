resource "aws_security_group" "ec2_sg" {
  name        = "ec2_aws_cert_test"
  description = "Security group for EC2 AWS Certification test instance"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  #ingress {}
  #egress {}
}

module "ec2_instance" {
  source = "../../modules/ec2"
  instance_type = "t2.micro"
  ami = data.aws_ami.amzn-linux-2023-ami.id
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_ids["private-test"]
  project = "aws cert study"
  name = "test-ec2-instance"
  security_group_ids = [aws_security_group.ec2_sg.id]
  tags = {
    Environment = "Test"
  }
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y amazon-cloudwatch-agent
  EOF
}
