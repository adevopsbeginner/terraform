variable "gcp_project_id" {}

variable "gcp_region" {
  type        = string
  description = "The Compute Region to deploy to"
  default     = "us-central1"
}

variable "this_name" {}
variable "vpc_name" {}
variable "subnet_name" {}
variable "zone" {}
variable "machine_type" {}
variable "node_count" {}
variable "created_by" {}
variable "link" {}
