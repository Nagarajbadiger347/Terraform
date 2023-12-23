resource "aws_s3_bucket" "tf_state_file" {
    lifecycle {
      prevent_destroy = true
    }
  
}

resource "aws_s3_bucket_versioning" "file_versioning" {
    bucket = aws_s3_bucket.tf_state_file.id
    versioning_configuration {
      status = "Enabled"
    }
  
}
# for file locking
resource "aws_dynamodb_table" "tf_state_lock" {
    name = "tf-state-lock"
    hash_key = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }
    billing_mode = "PAY_PER_REQUEST"
}