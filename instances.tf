resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
  tags = {
    Name = "deployer key"
  }
}

data "aws_ssm_parameter" "amazon-linux-2" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "web" {
  ami                         = data.aws_ssm_parameter.amazon-linux-2.value
  instance_type               = "t3a.micro"
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true
  subnet_id                   = data.aws_subnet.selected.id
  iam_instance_profile        = aws_iam_instance_profile.ec2_to_assume.name

  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]

  tags = {
    Name = "bastion host"
  }
}
