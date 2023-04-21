resource "google_service_account" "sa-name" {
  account_id="sa-name"
  display_name="SA"
}
resource "google_project_iam_member" "owner_binding" {
  project="db-cicdpipeline-wave-2"
  role=roles/compute.instanceAdmin
  member="serviceAccount:${google_service_account.sa-name.email}"
}
