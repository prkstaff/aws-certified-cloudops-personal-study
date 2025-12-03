resource "aws_security_group" "ec2_sg" {
  name        = "ec2_aws_cert_test"
  description = "Security group for EC2 AWS Certification test instance"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  egress {
    description = "HTTPS to VPC endpoints for SSM"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "ec2_instance" {
  source = "../../modules/ec2"
  instance_type = "t2.micro"
  ami = data.aws_ami.amzn-linux-2023-ami.id
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_ids["private-test"]
  project = "aws cert study"
  name = "test-ec2-instance"
  security_group_ids = [aws_security_group.ec2_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  tags = {
    Environment = "Test"
  }
  user_data = <<-EOF
    #!/bin/bash
    # SSM Agent is pre-installed on Amazon Linux 2023
    # Restart it to ensure it picks up the IAM role
    systemctl restart amazon-ssm-agent
    systemctl enable amazon-ssm-agent

    # Install CloudWatch Agent
    yum install -y amazon-cloudwatch-agent
  EOF
}

resource "aws_iam_role" "monitored_webserver" {
  name = "MonitoredWebServer"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.monitored_webserver.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy" {
  role       = aws_iam_role.monitored_webserver.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "MonitoredWebServerProfile"
  role = aws_iam_role.monitored_webserver.name
}
