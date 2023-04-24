resource "google_kms_crypto_key_iam_binding" "crypto_key_binding" {

  crypto_key_id = google_kms_crypto_key.key-garage.id

  role = "roles/cloudkms.cryptoKeyEncrypter"

  members = [

    "service_account:my-service-account@${db_cicdpipeline-wave-2.project}.iam.gserviceaccount.com",

  ]

}

 resource "google_service_account_iam_binding" "sa-account-iam" {

  service_account_id = google_service_account.service_account.name

  role = "roles/storage.admin"

  members = [

    "service_account:my-service-account@${db-cicdpipeline-wave-2.project}.iam.gserviceaccount.com",

  ]

}
