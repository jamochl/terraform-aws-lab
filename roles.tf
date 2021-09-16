resource "aws_iam_role" "ec2_to_assume" {
  name = "ec2_to_assume_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "ec2_to_assume_role"
  }
}

resource "aws_iam_role_policy" "ec2_to_assume" {
  name = "ec2_to_assume_policy"

  role = aws_iam_role.ec2_to_assume.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "sts:AssumeRole"
        Resource = aws_iam_role.assume_to_s3.arn
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_to_assume" {
  name = "ec2_to_assume_iprofile"
  role = aws_iam_role.ec2_to_assume.name
}

resource "aws_iam_role" "assume_to_s3" {
  name = "assume_to_s3_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          AWS = aws_iam_role.ec2_to_assume.arn
        }
      },
    ]
  })

  tags = {
    Name = "assume_to_s3_role"
  }
}

resource "aws_iam_role_policy" "assume_to_s3" {
  name = "assume_to_s3_policy"

  role = aws_iam_role.assume_to_s3.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      }
    ]
  })
}
