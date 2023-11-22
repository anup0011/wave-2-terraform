resource "google_service_account" "service_account_compute" {
  account_id   = "cs"
  display_name = "Service Account for compute service"
}

resource "google_service_account" "service_account_cf" {
  account_id   = "cf"
  display_name = "Service Account for cloudfunction"
}

resource "google_service_account" "service_account_pubsub" {
  account_id   = "pubsub"
  display_name = "Service Account for pubsub"
}