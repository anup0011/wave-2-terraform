resource "google_kms_key_ring" "crypto_keyring" {
  project = var.project_id
  name = "crypto-keyring"
  location = "global"
}

resource "google_kms_crypto_key" "crypto_key" {
  name = "crypto-key"
  key_ring = google_kms_key_ring.crypto_keyring.id 
}