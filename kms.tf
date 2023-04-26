resource "google_kms_key_ring" "keyring" {
  name     = "keyring"
  location = "global"
}

resource "google_kms_crypto_key" "key-crypto" {
  name            = "key-crypto"
  key_ring        = google_kms_key_ring.keyring.id
  
}
