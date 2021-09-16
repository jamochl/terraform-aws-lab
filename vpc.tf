# .arn to grab vpc id
data "aws_vpc" "selected" {
  default = true
}

data "aws_subnet" "selected" {
  vpc_id = data.aws_vpc.selected.id
  availability_zone = "us-east-1a"
}
