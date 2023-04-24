
resource "google_kms_key_ring" "default" {
  name = "wave2-key-ring"
  location = "global"
}

resource "google_kms_crypto_key" "default"{
  name = "wave2-crypto-key"
  key_ring = google_kms_key_ring.default.self_link
}
