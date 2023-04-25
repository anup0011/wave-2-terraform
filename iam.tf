resource "google_service_account" "vm_creator_sa" {
  project = var.project_id
  account_id   = "vm-creator"
  display_name = "vm creator sa"
}

resource "google_service_account_iam_binding" "comupte_key_iam" {
  service_account_id = google_service_account.vm_creator_sa.name
  for_each = var.roles
  role = each.value

  members = [
    "serviceaccount:${google_service_account.vm_creator_sa.email}",
  ]
}


