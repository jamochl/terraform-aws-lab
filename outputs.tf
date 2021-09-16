output "ec2_public_ip" {
  value = "ssh ec2-user@${aws_instance.bastion.public_ip}"
}

output "role_arns" {
  value = {
    ec2_to_assume_arn = aws_iam_role.ec2_to_assume.arn
    assume_to_s3_arn  = aws_iam_role.assume_to_s3.arn
  }
}

output "s3_bucket" {
  value = aws_s3_bucket.bucket.id
}
