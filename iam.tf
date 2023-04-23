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

resource "google_service_account_iam_member" "vm_creator_keycrypto" {
  for_each = toset([
    roles/compute.instanceAdmin,
    roles/cloudkms.cryptoKeyEncrypterDecrypter
    ])
  member = "serviceaccount:${google_service_account.vm_creator_sa.email}"
  role = each.key
  
}

