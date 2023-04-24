resource "google_kms_key_ring" "keyring-garage" {

  name     = "keyring-wave2-garge"

  location = "global"

}

resource "google_kms_crypto_key" "key-garage" {

  name            = "key-wave2-garage"

  key_ring        = google_kms_key_ring.keyring-garage.id

  rotation_period = "100000s"

  lifecycle {

    prevent_destroy = true

  }

}
