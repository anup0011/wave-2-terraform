resource "google_service_account" "terraform" {
  account_id = "terraform-sa"
  display_name = "service-account"
}
resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.terraform.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}
resource "google_project_iam_binding" "sa_roles" {
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
  key_ring        = "${google_kms_key_ring.my-key.self_link}"
}
resource "google_kms_crypto_key_iam_binding" "crypto_key" {
   crypto_key_id = google_kms_crypto_key.my_crypto_key.self_link
   role   = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members       = [
     "serviceAccount:${google_service_account.terraform.email}"
  ]
}
