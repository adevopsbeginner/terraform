output "vm_name" {
  value = google_compute_instance.this.name
}

output "vm_id" {
  value = google_compute_instance.this.id
}

output "vm_self_link" {
  value = google_compute_instance.this.self_link
}

output "vm_zone" {
  value = google_compute_instance.this.zone
}

output "vm_machine_type" {
  value = google_compute_instance.this.machine_type
}

output "vm_internal_ip" {
  value = google_compute_instance.this.network_interface[0].network_ip
}

output "vm_external_ip" {
  value = google_compute_instance.this.network_interface[0].access_config[0].nat_ip
}

output "vm_status" {
  value = google_compute_instance.this.current_status
}

output "vm_tags" {
  value = google_compute_instance.this.tags
}

# output "vm_service_account_email" {
#   value = google_compute_instance.this.service_account[0].email
# }
