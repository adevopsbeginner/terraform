provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# resource "google_compute_network" "this_name" {
#   name                    = var.this_name
#   description             = "custom VPC created using Terraform"

#   auto_create_subnetworks = false
# }

# resource "google_compute_subnetwork" "subnet_name" {
#   name          = var.subnet_name
#   region        = var.gcp_region
#   network       = google_compute_network.this_name.id
#   ip_cidr_range = var.subnet_cidr
# }

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 11.0.0"

  project_id   = var.gcp_project_id
  network_name = var.this_name
  routing_mode = "REGIONAL"

  subnets = [
    {
      subnet_name           = "aries"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = var.gcp_region
      subnet_private_access = true
      subnet_flow_logs      = true
    },
    {
      subnet_name           = "taurus"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = var.gcp_region
      subnet_private_access = false
      subnet_flow_logs      = false
    }
  ]

  secondary_ranges = {
    subnet-1 = [
      {
        range_name    = "pods"
        ip_cidr_range = "10.20.0.0/16"
      },
      {
        range_name    = "services"
        ip_cidr_range = "10.30.0.0/20"
      }
    ]
  }

  # Optional
  firewall_rules = [
    {
      name        = "allow-ssh"
      direction   = "INGRESS"
      priority    = 1000
      ranges      = ["0.0.0.0/0"]
      allow       = [{ protocol = "tcp", ports = ["22"] }]
      target_tags = ["ssh"]
    }
  ]

  # labels = {
  #   deployment  = "terraform"
  #   created_by  = var.created_by
  #   link        = var.link
  # }
}