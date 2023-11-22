resource "google_service_account" "service_account_compute" {
  account_id   = "compute-sa"
  display_name = "Service Account for compute service"
}

resource "google_service_account" "service_account_cf" {
  account_id   = "cloudfunction-sa"
  display_name = "Service Account for cloudfunction"
}

resource "google_service_account" "service_account_pubsub" {
  account_id   = "pubsub-sa"
  display_name = "Service Account for pubsub"
}