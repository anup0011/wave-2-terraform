
resource "google_service_account" "garage-sa" {
  account_id   = "service-account"
  display_name = "Service Account "
}
  
resource "google_service_account_iam_binding" "gce-account-iam" {
  service_account_id = google_service_account.garage-sa.name
  for_each           = toset(var.roles)
  role               = each.value

  members = [
    "serviceaccount:${google_service_account.garage-sa.email}",
  ]
}
