resource "google_service_account" "wave2-garage-sa" {
  account_id   = "new-service-account-wave2"
  display_name = "new-service-account-wave2"
}
resource "google_service_account_iam_binding" "sa-account-iam" {
  service_account_id = google_service_account.wave2-garage-sa.name
  for_each           = toset(var.roles)
  role               = each.value

  members = [
    "serviceAccount:${google_service_account.wave2-garage-sa.email}",
  ]
}

resource "google_project_service" "cloudkms_service" {
  project = var.project
  service = "cloudkms.googleapis.com"
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

