resource "aws_s3_bucket" "app_bucket" {
  bucket = var.app_bucket_name
  #acl = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    allowed_headers = ["*"]
  }
  force_destroy = true

}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.app_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "app_bucket_policy" {
  bucket = aws_s3_bucket.app_bucket.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": [
              "${aws_s3_bucket.app_bucket.arn}/*"
      ]
        }
    ]
}
EOF

  depends_on = [
    aws_s3_bucket_public_access_block.this
  ]
}

