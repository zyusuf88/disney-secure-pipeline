terraform {
  backend "s3" {
    bucket         = "secure-hub-tf-state"
    key            = "devsecops-pipeline/terraform.tfstate"
    region         = "eu-west-2"
    use_lockfile = true
    encrypt        = true
  }
}
