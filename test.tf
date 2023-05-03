resource "google_project_service" "kms_key" {
  project = "db-cicdpipeline-wave2"
  service = "cloudkms.googleapis.com"
}
resource "google_kms_key_ring" "keyring" {
  name     = "keyring"
  location = "global"
}

resource "google_kms_crypto_key" "key-crypto" {
  name            = "key-crypto"
  key_ring        = google_kms_key_ring.keyring.id
  rotation_period = "2592000s"
  lifecycle {
    prevent_destroy = true
  }
  
}
