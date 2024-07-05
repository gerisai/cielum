locals {
  domain_name     = "cielum.com.mx"
  origin_id       = "cielumS3"
  cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6" # CachingOptimized from AWS
  tags = {
    Environment = "Production"
    App         = "Cielum"
  }
}