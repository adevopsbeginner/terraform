output "cluster_name" {
  value = google_container_cluster.this.name
}

output "cluster_endpoint" {
  value = google_container_cluster.this.endpoint
}

output "client_certificate" {
  value     = google_container_cluster.this.master_auth[0].client_certificate
  sensitive = true
}

output "client_key" {
  value     = google_container_cluster.this.master_auth[0].client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = google_container_cluster.this.master_auth[0].cluster_ca_certificate
  sensitive = true
}