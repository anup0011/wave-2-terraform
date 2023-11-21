resource "google_project_service" "project" {
  for each = var.apis
  project = "your-project-id"
  service =  each.key

}