variable "gcp_project_id" {}

variable "gcp_region" {
  type        = string
  description = "The Compute Region to deploy to"
  default     = "us-central1"
}

variable "this_name" {}
variable "zone" {}
variable "availability_type" {}
variable "edition" {}
variable "dbtier" {}
variable "dbversion" {}
variable "dbname" {}
variable "dbuser" {}
variable "dbpass" {}
variable "created_by" {}
variable "link" {}
