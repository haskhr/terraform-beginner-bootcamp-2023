output "bucket_name" {
    description = "bucket for our static web site hosting "
    value = module.terrahouse_aws.bucket_name   
}