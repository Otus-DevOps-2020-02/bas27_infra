terraform {
  backend "gcs" {
    bucket = "stor-bucket-bas27"
    prefix = "terraform/prod"
  }
}
