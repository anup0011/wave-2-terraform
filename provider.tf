terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.7.0"
    }
  }
  
 backend "gcs" {
   bucket  = "1010101-terraform-tfstate"
   prefix  = "terraform/state"
 }
}
