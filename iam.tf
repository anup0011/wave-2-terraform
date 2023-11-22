resource "google_project_iam_binding" "project-compute" {
  project = var.project_id
  role    = "roles/compute.instanceAdmin.v1"

  members = [
    "serviceAccount:${google_service_account.service_account_compute.email}",
  ]
}