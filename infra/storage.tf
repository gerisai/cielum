resource "aws_s3_bucket" "cielum_bucket" {
  bucket = "cielum-static-site"

  tags = {
    Name        = "cielum-static-site"
    Environment = "Production"
    App         = "Cielum"
  }
}

resource "aws_s3_bucket_ownership_controls" "cielum_bucket_owner" {
  bucket = aws_s3_bucket.cielum_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "cielum_public_access_block" {
  bucket = aws_s3_bucket.cielum_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.cielum_bucket.id
  policy = data.aws_iam_policy_document.cielum_bucket_policy.json
}
