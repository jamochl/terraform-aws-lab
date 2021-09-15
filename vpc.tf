# .arn to grab vpc id
data "aws_vpc" "selected" {
  default = true
}

data "aws_subnet_ids" "selected" {
    vpc_id = data.aws_vpc.selected.id
}
