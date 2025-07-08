output "bucket_name" {
  value = google_storage_bucket.this.name
}

output "bucket_id" {
  value = google_storage_bucket.this.id
}

output "bucket_url" {
  value = "gs://${google_storage_bucket.this.name}"
}

output "bucket_self_link" {
  value = google_storage_bucket.this.self_link
}

output "bucket_location" {
  value = google_storage_bucket.this.location
}

output "bucket_storage_class" {
  value = google_storage_bucket.this.storage_class
}

output "bucket_project" {
  value = google_storage_bucket.this.project
}

output "bucket_force_destroy" {
  value = google_storage_bucket.this.force_destroy
}

output "bucket_versioning" {
  value = google_storage_bucket.this.versioning
}

output "bucket_website" {
  value = google_storage_bucket.this.website
}
