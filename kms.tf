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
  members = [
    "serviceaccount:${google_service_account.garage-sa.email}",
  ]

}
