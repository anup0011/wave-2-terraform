/*resource "google_service_account" "wave2-garage-sa" {
  account_id   = "test-sa"
  display_name = "test-sa"
}
*/
resource "google_compute_instance_iam_binding" "instance_binding" {
  depends_on = [ google_compute_instance.wave2-linux ]
  project = var.project
  zone = "asia-south2-b"
  instance_name = google_compute_instance.wave2-linux.name
  role = "roles/compute.instanceAdmin"
  members = var.iam_members
}

resource "google_compute_instance_iam_binding" "instance_binding_win" {
  depends_on = [ google_compute_instance.wave2-windows ]
  project = var.project
  zone = "asia-south2-c"
  count = var.vm_count
  instance_name = "wave2-win${count.index}"
  role = "roles/compute.instanceAdmin"
  members = var.iam_members
}

data "google_service_account" "new_service_account" {
  account_id = "new-service-account"
}

resource "google_service_account_iam_binding" "sa_user_iam" {
  depends_on = [ data.google_service_account.new_service_account ]
  service_account_id = data.google_service_account.new_service_account.name
  role               = "roles/iam.serviceAccountUser"

  members = var.iam_members
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
*/
data "google_kms_key_ring" "keyring-garage" {
  name     = "keyring-wave2-garge"
  location = "global"
}

resource "google_kms_crypto_key" "key-garage" {
  name            = "key-test"
  key_ring        = data.google_kms_key_ring.keyring-garage.id
  rotation_period = "2592000s"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key_version" "example-key" {
  crypto_key = google_kms_crypto_key.key-garage.id
}
/*
resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  crypto_key_id = google_kms_crypto_key.key-garage.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = [ "serviceAccount:my-service-account@${var.project}.iam.gserviceaccount.com" ]
}

resource "google_project_iam_member" "keycrypto_role" {
  project = var.project
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:my-service-account@${var.project}.iam.gserviceaccount.com"
}
*/
/*resource "google_project_iam_member" "keycrypto_role_sa" {
  project = var.project
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:service-817731629023@compute-system.iam.gserviceaccount.com"
}*/

