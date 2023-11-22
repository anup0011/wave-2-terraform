
resource "google_compute_instance" "vm1" {
  name         = "vm1"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["vm1"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = google_compute_network.custom_vpc.id
	subnetwork = google_compute_subnetwork.custom_subnetwork.id

  }

  metadata = {
    foo = "bar"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.service_account_compute.email
    scopes = ["cloud-platform"]
  }
}
