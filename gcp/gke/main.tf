provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}


resource "google_container_cluster" "this" {
  name     = var.this_name
  location = var.gcp_region

  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false

  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {} # Required for VPC-native clusters

  # Optional - enables control plane logging
  #logging_service    = "logging.googleapis.com/kubernetes"
  #monitoring_service = "monitoring.googleapis.com/kubernetes"
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.this_name}-node-pool"
  location   = var.gcp_region
  cluster    = google_container_cluster.this.name
  node_count = var.node_count

  node_config {
    preemptible  = false
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    labels = {
      env = "dev"
    }
    tags = ["gke-node"]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
