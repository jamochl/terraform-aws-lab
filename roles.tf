resource "aws_iam_role" "ec2_to_assume" {
  name = "ec2_to_s3"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Allow EC2 to assume this role"
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principle = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}
