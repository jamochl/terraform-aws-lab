resource "aws_s3_bucket" "bucket" {
  bucket_prefix = "jamochl-s3-bucket"
  tags = {
    Name = "S3_Role_test"
  }
}

resource "aws_s3_bucket_policy" "allow_role" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "Allow_Specific_Role"
    Statement = [
      {
        Sid = "Explicit Deny"
        Effect = "Deny"
        Action = "s3:*"
        Resource = [
          aws_s3_bucket.bucket.arn,
          "${aws_s3_bucket.bucket.arn}/*",
        ]
        Condition = {
          StringNotLike = {
            "aws:userid" = [
              "${}:*",
              "${data.aws_user.root.user_id}"
            ]
          }
        }
      },
      {
        Sid       = "Allow Role from assumed"
        Effect    = "Allow"
        Principal = {
          AWS = [
            "${}",
          ]
        }
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.bucket.arn,
          "${aws_s3_bucket.bucket.arn}/*",
        ]
      },
    ]
  })
}

data "aws_user" "root" {
    user_name = "cloud_user"
}
