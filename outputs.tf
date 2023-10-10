output "bucket_name" {
  description = "Bucket name for our static website hosting"
  value = module.home_the-nomad-pad_hosting.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 Static Website hosting endpoint"
  value = module.home_the-nomad-pad_hosting.website_endpoint
}

output "domain_name" {
  description = "The CloudFront Distribution Domain Name"
  value = module.home_the-nomad-pad_hosting.domain_name
}