terraform {
  backend "s3" {
    bucket         = "secure-hub-tf-state"
    key            = "devsecops-pipeline/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
