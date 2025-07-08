locals {
  tags = {
    Name            = var.this_name
    deployment      = "terraform"
    created_by      = var.created_by
    link            = var.link
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

resource "google_storage_bucket" "this" {
  name          = var.this_name
  location      = "us-central1"
  storage_class = "STANDARD"

  force_destroy = true

  versioning {
    enabled = false
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365
    }
  }

  labels = {
    deployment      = "terraform"
    created_by      = var.created_by
    link            = var.link
  }
}
