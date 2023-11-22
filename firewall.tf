resource "google_compute_firewall" "default" {
  name    = "test-allow-iap-ssh"
  network = google_compute_network.custom_vpc.name
  direction = "INGRESS"
  allow {
    protocol = "ssh"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_range = ["0.0.0.0/0"]
}
