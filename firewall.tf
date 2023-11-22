resource "google_compute_firewall" "default" {
  name    = "test-allow-iap-ssh"
  network = google_compute_network.custom_vpc.name
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["vm1"]
}
