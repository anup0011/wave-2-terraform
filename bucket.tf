resource "google_storage_bucket" "storage-bucket"{
  name  = "ci-cd-bucket"
  location = "ASIA"
  storage_class = "STANDARD"
  force_destroy = false
  uniform_bucket_level_access = true
  versioning{
    enabled = true
  }
}
