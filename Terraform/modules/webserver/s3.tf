resource "aws_s3_bucket" "s3-bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_policy" "bucket_policy" {
 bucket = aws_s3_bucket.s3-bucket.id

 policy = jsonencode({
    Version = "2012-10-17",
    Id      = "Policy1415115909152",
    Statement = [
      {
        Sid       = "Access-to-specific-VPCE-only",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource = "arn:aws:s3:::${aws_s3_bucket.s3-bucket.bucket}/*",
        Condition = {
          StringEquals = {
            "aws:sourceVpce" = "${aws_vpc_endpoint.s3.id}"
          }
        }
      }
    ]
 })
}

resource "aws_s3_object" "file_upload" {
  bucket      = aws_s3_bucket.s3-bucket.id
  key         = "webserver.yml"
  source      = "./../Ansible/web-server.yml"
}

