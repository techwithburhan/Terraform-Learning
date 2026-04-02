# Create S3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "techwithburhan-12345"  # yeh S3 bucket ka naam hai (globally unique hona chahiye)

  tags = {
    Environment = "Dev"            # yeh tag hai jo batata hai ki yeh Dev environment ke liye hai
  }
}

# Enable static website hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.bucket.id   # yeh us bucket ka reference hai jo upar create hua

  index_document {
    suffix = "index.html"            # default page jo open hoga jab website hit karega
  }

  error_document {
    key = "error.html"               # agar koi error aaye to yeh page show hoga
  }
}

# Disable block public access
resource "aws_s3_bucket_public_access_block" "public" {
  bucket = aws_s3_bucket.bucket.id  # same bucket pe public access settings apply ho rahi hai

  block_public_acls       = false   # public ACLs allow kar rahe hain
  block_public_policy     = false   # public bucket policy allow kar rahe hain
  ignore_public_acls      = false   # public ACL ignore nahi karega
  restrict_public_buckets = false   # public access restrict nahi kar rahe
}

# Bucket policy for public read
resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.bucket.id  # bucket pe policy attach ho rahi hai

  depends_on = [
    aws_s3_bucket_public_access_block.public   # ensure kare ki pehle public access block disable ho
  ]

  policy = jsonencode({
    Version = "2012-10-17"        # AWS policy version
    Statement = [
      {
        Effect = "Allow"          # allow access
        Principal = "*"           # sabko access dena (public)
        Action = "s3:GetObject"   # sirf read access (download/view)
        Resource = "${aws_s3_bucket.bucket.arn}/*"  # bucket ke saare objects pe apply hoga
      }
    ]
  })
}

# Upload index.html
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.bucket.id   # kis bucket me file upload hogi
  key    = "index.html"              # S3 me file ka naam kya hoga
  source = "index.html"              # local system se kaunsi file upload karni hai
  content_type = "text/html"         # browser ko batata hai ki yeh HTML file hai
}

# Upload error.html
resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.bucket.id   # same bucket me upload ho raha hai
  key    = "error.html"              # S3 me error file ka naam
  source = "error.html"              # local error.html file upload hogi
  content_type = "text/html"         # yeh bhi HTML content hai
}