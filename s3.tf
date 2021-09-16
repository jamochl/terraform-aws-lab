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
        Sid       = "ExplicitDeny"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.bucket.arn,
          "${aws_s3_bucket.bucket.arn}/*",
        ]
        Condition = {
          StringNotLike = {
            "aws:userid" = [
              "${aws_iam_role.assume_to_s3.unique_id}:*"
            ]
          }
        }
      },
      {
        Sid       = "AllowRolefromAssumed"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.bucket.arn,
          "${aws_s3_bucket.bucket.arn}/*",
        ]
        Condition = {
          StringNotLike = {
            "aws:userid" = [
              "${aws_iam_role.assume_to_s3.unique_id}:*"
            ]
          }
        }
      },
    ]
  })
}
