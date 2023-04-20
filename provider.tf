terraform {
   required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.62.1"
    }
  }
 backend "gcs" {
   bucket  = "1010101-terraform-tfstate"
   prefix  = "terraform/state"
 }
}
