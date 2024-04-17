output "static_website_endpoint" {
  description = "static s3 application bucket endpoint"
  value       = aws_s3_bucket_website_configuration.app_bucket.website_endpoint
}
