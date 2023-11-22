resource "google_service_account_iam_binding" "compute-iam" {
  service_account_id = google_service_account.service_account_compute.name
  role               = "roles/compute.instanceAdmin.v1"
}