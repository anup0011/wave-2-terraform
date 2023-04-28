resource "google_service_account" "terraform" {
  account_id = "terraform-sa"
  display_name = "service-account"
}

resource "google_service_account_iam_binding" "sa_roles" {
  service_account_id = google_service_account.terraform.name
  role   = "roles/compute.instanceAdmin"
  members = [
    "serviceAccount:${google_service_account.terraform.email}"
  ]
  depends_on = [google_service_account.terraform]
}

resource "google_kms_key_ring" "my-key" {
  name = "key-ring"
  location = "asia-south2-a"
}

resource "google_kms_crypto_key" "my_crypto_key" {
  name            = "my-crypto-key"
  key_ring        = google_kms_key_ring.my-key.id
}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
   crypto_key_id = google_kms_crypto_key.my_crypto_key.id
   role   = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members       = [
     "serviceAccount:${google_service_account.terraform.email}"
  ]
}
