resource "google_service_account" "wave2-garage-sa" {
  account_id   = "new-service-accout"
  display_name = "new-service-account"
}
resource "google_service_account_iam_binding" "sa-account-iam" {
  service_account_id = google_service_account.wave2-garage-sa.name
  role               = "roles/compute.instanceAdmin"

  members = [
    "service_account:new-service-account@${var.project}.iam.gserviceaccount.com",
  ]
}
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
resource "google_kms_crypto_key_iam_binding" "crypto_key_binding" {
  crypto_key_id = google_kms_crypto_key.key-garage.id
  role          = "roles/cloudkms.cryptoKeyEncrypter"

  members = [
    "service_account:new-service-account@${var.project}.iam.gserviceaccount.com",
  ]
}
