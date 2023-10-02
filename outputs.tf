output "bucket_name" {
    description = "bucket for our static web site hosting "
    value = module.terrahouse_aws.bucket_name   
}

output "S3_website_endpoint" {
    description = "S3 static web site hosting end point "
    value = module.terrahouse_aws.website_endpoint   
}

output "cloudfront_url" {
  description = "The CloudFront Distribution Domain Name"
  value = module.terrahouse_aws.cloudfront_url
}