resource "google_compute_network" "custom-vpc" {
  name                    = "test"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "custom-subnetwork" {
  name          = "uc1"
  ip_cidr_range = "192.168.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.custom-vpc.id

}

