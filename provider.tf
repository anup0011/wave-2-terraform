terraform {
   required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.62.1"
    }
  }
 backend "gcs" {
   bucket  = "terraform-state-db-poc-wave-4"
   prefix  = "terraform/state"
 }
}
