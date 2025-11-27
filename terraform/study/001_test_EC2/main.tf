module "ec2_instance" {
  source = "../../modules/ec2"
  instance_type = "t2.micro"
  ami = data.aws_ami.amzn-linux-2023-ami.id
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_ids["private-test"]
  project = "aws cert study"
  name = "test-ec2-instance"
  tags = {
    Environment = "Test"
  }
}
