/*resource "google_service_account" "wave2-garage-sa" {
  account_id   = "test-sa"
  display_name = "test-sa"
}
*/
/*resource "google_compute_instance_iam_binding" "instance_binding" {
  depends_on = [ google_compute_instance.wav2-linux ]
  project = var.project
  zone = "asia-south2-b"
  instance_name = google_compute_instance.wav2-linux.name
  role = "roles/compute.instances.setMetadata"
  members = [
    "user:koshike.sushmitha@tcs.com",
    "user:kushal.malla@tcs.com"
  ]
}*/

resource "google_compute_instance_iam_binding" "instance_binding_win" {
  depends_on = [ google_compute_instance.wav2-windows ]
  project = var.project
  zone = "asia-south2-c"
  for_each = toset(var.instance_names)
  instance_name = each.value
  role = "roles/compute.instanceAdmin"
  members = [
    "user:koshike.sushmitha@tcs.com",
    "user:kushal.malla@tcs.com"
  ]
}

data "google_service_account" "new_service_account" {
  account_id = "new-service-account"
}

resource "google_service_account_iam_binding" "sa_user_iam" {
  depends_on = [ data.google_service_account.new_service_account ]
  service_account_id = data.google_service_account.new_service_account.name
  role               = "roles/iam.serviceAccountUser"

  members = [
    "user:koshike.sushmitha@tcs.com",
    "user:kushal.malla@tcs.com",
    "user:neeraja.balireddy@tcs.com",
    "user:ajaykumar.shah@tcs.com",
    "user:apanya.chauhan1@tcs.com",
    "user:keerthivashan.kc@tcs.com",
    "user:manushri.m@tcs.com",
    "user:meetu.singh@tcs.com",
    "user:nisha.shashi@tcs.com",
    "user:pavan.gowda@tcs.com",
    "user:prabin.mohanty@tcs.com",
    "user:sahithi.narla@tcs.com",
    "user:sitaramachakravarthy.peruvel@tcs.com",
    "user:srisahithi.banda@tcs.com",
    "user:suhasini.dussa@tcs.com"
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
