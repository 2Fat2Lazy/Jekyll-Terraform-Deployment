variable "bucket_name" {
  type = string
}

variable "bucket_acl" {
  type = string
}

variable "index_loc" {
  type = string
}

variable "error_loc" {
  type = string
}

variable "git_URL" {
  type = string
}

variable "codebuild_service_arn" {
  type = string
}

variable "tfstate_bucket_name" {
  type = string
}

variable "tfstate_S3_key" {
  type = string
}

variable "codepipeline_service_arn" {
  type = string
}

variable "repo_owner" {
  type = string
}

variable "oauth_token" {
  type = string
  sensitive = true
}

variable "poll_source_changes" {
  type = bool
}

variable "acm_certificate_arn" {
  type = string
}

variable "region" {
  type = string
}

variable "route_53_zone_name" {
  type = string
}

output "web_url" {
  description = "Website URL"
  value       = join(".", ["www", data.aws_route53_zone.selected.name])
}

output "cf_url" {
  description = "CloudFront URL"
  value       = aws_cloudfront_distribution.cf.domain_name
}

output "cf_aliases" {
  description = "CloudFront Aliases"
  value       = aws_cloudfront_distribution.cf.aliases
}
