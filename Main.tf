terraform {
  backend "s3" {
    bucket = "<example bucket name>" #Name of the S3 bucket to store your Terraform state file
    key    = "<example S3 key>" #For specifying directory structure of saved tfstate e.g tfstate/yourwebsite/tfstate.json
    region = "eu-west-1"
  }
}