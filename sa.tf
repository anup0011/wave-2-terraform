
resource "google_service_account" "garage-sa" {
  account_id   = "service-account"
  display_name = "Service Account "
}

resource "google_service_account_iam_member" "gce-account-iam" {
  service_account_id = google_service_account.garage-sa.name
  role               = "roles/iam.serviceAccountUser"
  member             = ["serviceAccount:${google_service_account.garage-sa.email}"
  ]
 }
