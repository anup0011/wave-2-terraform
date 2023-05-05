# Assigning instanceAdmin role to users on linux instance.
resource "google_compute_instance_iam_binding" "instance_binding" {
  depends_on = [ google_compute_instance.wave2-linux ]
  project = var.project
  zone = "asia-south2-b"
  instance_name = google_compute_instance.wave2-linux.name
  role = "roles/compute.instanceAdmin"
  members = var.iam_members
}

# Assigning instanceAdmin role to users on windows instance.
resource "google_compute_instance_iam_binding" "instance_binding_win" {
  depends_on = [ google_compute_instance.wave2-windows ]
  project = var.project
  zone = "asia-south2-c"
  count = var.vm_count
  instance_name = "wave2-win${count.index}"
  role = "roles/compute.instanceAdmin"
  members = var.iam_members
}

# Retrieving service account data created in console.
data "google_service_account" "new_service_account" {
  account_id = "new-service-account"
}

# Assigning serviceAccountUser role to users on service account.
resource "google_service_account_iam_binding" "sa_user_iam" {
  depends_on = [ data.google_service_account.new_service_account ]
  service_account_id = data.google_service_account.new_service_account.name
  role               = "roles/iam.serviceAccountUser"

  members = var.iam_members
}

# Enabling cloud kms api.
resource "google_project_service" "cloudkms_service" {
  project = var.project
  service = "cloudkms.googleapis.com"
}

# Retrieving kms key ring data from console.
# Key ring used for instance disk encryption and decryption.
data "google_kms_key_ring" "keyring-garage" {
  name     = "keyring-wave2-garge"
  location = "global"
}

#Creating key for key ring.
resource "google_kms_crypto_key" "key-garage" {
  name            = "key-test"
  key_ring        = data.google_kms_key_ring.keyring-garage.id
  rotation_period = "2592000s"

  lifecycle {
    prevent_destroy = true
  }
}

# Enabling versioning for keys.
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
# Assigning cryptoKeyEncrypterDecrypter role to the service agent at project level.
resource "google_project_iam_member" "keycrypto_role_sa" {
  project = var.project
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:service-817731629023@compute-system.iam.gserviceaccount.com"
}

# Creating key ring for composer environment.
// The keys location must be the same as the composer environment. You cannot use regional or global keys.
resource "google_kms_key_ring" "keyring_composer" {
  name     = "composer-keyring"
  location = "asia-south1"
}

# Creating keys for composer key ring.
resource "google_kms_crypto_key" "key_composer" {
  name            = "key-composer"
  key_ring        = google_kms_key_ring.keyring_composer.id
  rotation_period = "2592000s"

  lifecycle {
    prevent_destroy = true
  }
}

# Enabling key versioning.
resource "google_kms_crypto_key_version" "composer_key_verison" {
  crypto_key = google_kms_crypto_key.key_composer.id
}

# Assigning cryptoKeyEncrypterDecrypter role to the customer managed service account at Key level.
resource "google_kms_crypto_key_iam_binding" "crypto_key_iam" {
  crypto_key_id = google_kms_crypto_key.key_composer.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = [ "serviceAccount:${var.new_sa}" ]
}