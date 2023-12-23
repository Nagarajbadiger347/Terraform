terraform {
  backend "s3" {
    bucket = "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
    key    = "terraform/backend/terraform.tfstate"

    region = "us-east-1"
    dynamodb_table = "tf_state_lock"
    encrypt = true
    
  }
}