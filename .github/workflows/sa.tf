resource "google_service_account" "sa" {
  project       = var.project_id
  account_id    = var.account_id
  display_name  = var.descrition
  
  depends_on = [
    google_project_serice.enabled_apis,
    ]
}
resource  "google_project_iam_member" "sa_iam" {
  for_each = toset(var.roles)s
  project  = var.project_id 
  role     = each.value
  member   = "serviceAccount:${google_service_account.sa_email}"
  depends_on = [
    google_project_service.enabled_apis,
    
    }
}
  
