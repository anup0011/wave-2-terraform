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
  rotation_period = "100000s"
  lifecycle {
    prevent_destroy = true
  }
  
}
resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  crypto_key_id = google_kms_crypto_key.key-crypto.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = ["serviceAccount:${data.google_kms_crypto_key_iam_binding.crypto_key.email_address}"]
}
