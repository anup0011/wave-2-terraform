#creating new storage bucket
resource "google_storage_bucket" "new_storage_bucket" {
  name          = var.bucket_name
  force_destroy = false
  location      = var.bucket_location
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}