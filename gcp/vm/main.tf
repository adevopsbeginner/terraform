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

resource "google_compute_instance" "this" {
  name         = var.this_name
  description  = "${var.this_name}"
  zone         = var.zone
  machine_type = var.instance_type

  allow_stopping_for_update = true

  tags = ["ssh", "y2025", "jul"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      labels = {
        deployment      = "terraform"
        created_by      = var.created_by
        link            = var.link
      }
    }
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = var.subnet_name

    access_config {
      # This assigns a public IP
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
    # ssh-keys       = <<-EOT
    #   devops:${file("~/.ssh/google_compute_engine.pub")}
    #   devops:${file("~/.ssh/id_ed25519.pub")}
    # EOT
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    echo "Hello from tbeginner" > /var/www/html/index.html
  EOF

  labels = {
    deployment      = "terraform"
    created_by      = var.created_by
    link            = var.link
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/templates/user_data.sh")}"

  vars = {
    region            = var.gcp_region
    this_name         = var.this_name
  }
}
