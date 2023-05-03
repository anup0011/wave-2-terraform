resource "random_id" "bucket_prefix" {
  byte_length = 8
}
resource "google_storage_bucket" "storage-bucket"{
  name  = "${random_id.bucket_prefix.hex}-storage-bucket"
  location = "ASIA"
  storage_class = "STANDARD"
  force_destroy = false
  uniform_bucket_level_access = true
  versioning{
    enabled = true
  }
}
resource "google_storage_bucket_iam_binding" "binding" {
  depends_on = [google_storage_bucket.storage-bucket]
  bucket = google_storage_bucket.storage-bucket.name
  role = "roles/storage.admin"
  members = var.iam_members
}
