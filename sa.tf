resource "google_service_account" "sa-name" {
  account_id="sa-name"
  display_name="SA"
}
resource "google_project_iam_binding" "owner_binding" {
  binding{
  project="db-cicdpipeline-wave-2"
  role=roles/compute.instanceAdmin
  members= ["serviceAccount:${google_service_account.sa-name.email}"]
    
}
