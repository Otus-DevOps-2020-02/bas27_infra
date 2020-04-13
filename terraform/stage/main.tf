provider "google" {
  version = "~> 2.15"
  project = var.project
  region  = var.region
}

module "app" {
  source           = "../modules/app"
  public_key_path  = var.public_key_path
  zone             = var.zone
  app_disk_image   = var.app_disk_image
  private_key_path = var.private_key_path
  db_external_ip   = module.db.db_external_ip
  db_internal_ip   = module.db.db_internal_ip
}

module "db" {
  source           = "../modules/db"
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  zone             = var.zone
  db_disk_image    = var.db_disk_image
  db_internal_ip   = module.db.db_internal_ip
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}
