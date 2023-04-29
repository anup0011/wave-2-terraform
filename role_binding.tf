/*resource "google_service_account" "wave2-garage-sa" {
  account_id   = "test-sa"
  display_name = "test-sa"
}
*/
resource "google_compute_instance_iam_binding" "instance_binding" {
  project = var.project
  zone = "asia-south2-b"
  instance_name = google_compute_instance.wav2-linux.name
  role = "roles/compute.osLogin"
  members = [
    "user:koshike.sushmitha@tcs.com",
    "user:kushal.malla@tcs.com"
  ]
}

resource "google_compute_instance_iam_binding" "instance_binding_win" {
  project = var.project
  zone = "asia-south2-c"
  for_each = toset(google_compute_instance.wav2-windows.name)
  instance_name = each.value
  role = "roles/compute.osLogin"
  members = [
    "user:koshike.sushmitha@tcs.com",
    "user:kushal.malla@tcs.com"
  ]
}

data "google_service_account" "new_service_account" {
  account_id = "new-service-account"
}

resource "google_service_account_iam_binding" "sa_user_iam" {
  service_account_id = data.google_service_account.new_service_account.name
  role               = "roles/iam.serviceAccountUser"

  members = [
    "user:koshike.sushmitha@tcs.com",
    "user:kushal.malla@tcs.com"
  ]
}


resource "google_project_service" "cloudkms_service" {
  project = var.project
  service = "cloudkms.googleapis.com"
}
/*
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
*/
