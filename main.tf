resource "google_compute_firewall" "ssh_rule" {
  project     = var.project
  name        = "allow-ssh-rule"
  network     = "custom"
  description = "Creates ssh connection"
  direction = "INGRESS"
  source_ranges = [ "0.0.0.0/0" ]
  target_tags = ["wave-2-git"]

  allow {
    protocol  = "tcp"
    ports     = ["22"]
  }

}

resource "google_compute_instance" "wave2-linux" {
  name         = "wave2-linux1"
  machine_type = var.machine_type
  zone         = "asia-south2-b"
  allow_stopping_for_update = true
  tags = [ "wave-2-git" ]

  boot_disk {
    kms_key_self_link = google_kms_crypto_key.key-garage.id
    initialize_params {
      image = var.image_linux
      labels = {
        my_label = "value"
      }
    }
  }
  network_interface {
    network = "custom"
    subnetwork = var.test_subnet
    access_config {
      
    }

  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "my-service-account@${var.project}.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "wave2-windows" {
  count        = var.vm_count
  name         = "wave2-win${count.index}"
  machine_type = var.machine_type
  zone         = "asia-south2-c"
  allow_stopping_for_update = true
  tags = [ "wave-2-git" ]
  depends_on = [ google_kms_crypto_key_iam_binding.crypto_key ]

  boot_disk {
    kms_key_self_link = google_kms_crypto_key.key-garage.id
    initialize_params {
      image = var.image_windows
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "custom"
    subnetwork = var.test_subnet
    access_config {
      
    }

  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "my-service-account@${var.project}.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}
