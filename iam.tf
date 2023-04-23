resource "google_kms_key_ring" "crypto_keyring" {
  name = "crypto-keyring"
  location = "global"
}

resource "google_kms_crypto_key" "crypto_key" {
  name = "crypto-key"
  key_ring = google_kms_key_ring.crypto_keyring.id 
}

resource "google_service_account" "vm_creator_sa" {
  account_id   = "vm-creator"
  display_name = "vm creator sa"
}

resource "google_service_account_iam_binding" "comupte_key_iam" {
  service_account_id = google_service_account.vm_creator_sa.name
  for_each = toset(["roles/compute.instanceAdmin","rols/cloudkms.cryptoKeyDecrypter"])
  role = each.value

  members = [
    "serviceaccount:${google_service_account.vm_creator_sa.email}",
  ]
}


