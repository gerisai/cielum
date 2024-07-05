data "aws_iam_policy_document" "cielum_bucket_policy" {
  statement {
    sid = "CielumAllowCloudFront"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.cielum_bucket.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.cielum_cf_distribution.arn]
    }
  }
}