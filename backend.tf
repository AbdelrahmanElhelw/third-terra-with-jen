terraform {
    backend "s3" {
    bucket         = "abdo-s2-bu1"
    key            = "dev/backend.tfstate"    #or dynamo_dbtable
    use_lockfile   = true
    region         = "us-west-2"
  }
}
