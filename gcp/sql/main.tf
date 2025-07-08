provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

module "postgresql_db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "~> 22.0"

  name              = var.this_name
  project_id        = var.gcp_project_id
  region            = var.gcp_region
  zone              = var.zone
  availability_type = var.availability_type
  database_version  = var.dbversion
  edition           = var.edition
  tier              = var.dbtier

  ip_configuration  = {
    ipv4_enabled = true
    authorized_networks = [
      {
        name  = "allow-all"
        value = "0.0.0.0/0"
      }
    ]
  }

  deletion_protection = false

  db_name       = var.dbname
  user_name     = var.dbuser
  user_password = var.dbpass
}
