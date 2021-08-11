resource "aws_cloudfront_distribution" "cf" {
  enabled             = true
  price_class         = "PriceClass_100"
  default_root_object = var.index_loc
  is_ipv6_enabled     = true
  aliases             = ["*.yoursite.co.uk", "yoursite.co.uk"] #Change to reflect your domain name, or comment it out if you don't have your own.

  origin {
    domain_name = aws_s3_bucket.my-site.bucket_domain_name
    origin_id   = "mysite"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.my-site.cloudfront_access_identity_path
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    target_origin_id = "mysite"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 7200
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }
}

resource "aws_cloudfront_origin_access_identity" "my-site" {
  comment = "Stop access to s3 directly."
}