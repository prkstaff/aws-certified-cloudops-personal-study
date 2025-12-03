locals {
  ec2_tags = merge(
    {
      Name    = var.name
      Project = var.project
    },
    var.tags,
  )

}

resource "aws_instance" "web" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.subnet_id
  iam_instance_profile   = var.iam_instance_profile

  associate_public_ip_address = var.associate_public_ip

  tags = local.ec2_tags

  security_groups = var.security_groups

  user_data = var.user_data
}
