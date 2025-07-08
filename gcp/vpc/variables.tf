variable "gcp_project_id" {}

variable "gcp_region" {
  type        = string
  description = "The Compute Region to deploy to"
  default     = "us-central1"
}

variable "this_name" {}
variable "subnet_name" {}

variable "subnet_cidr" {
  description = "The IP range to attribute to the virtual network."
}

variable "created_by" {}
variable "link" {}
