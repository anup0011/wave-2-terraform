resource "google_compute_instance" "wav2-linux" {
  name         = "wave2-linux1"
  machine_type = var.machine_type
  zone         = "asia-south2-b"

  boot_disk {
    initialize_params {
      image = var.image_linux
      labels = {
        my_label = "value"
      }
    }
  }
  
  network_interface {
    network = "custom"
    subnetwork = "projects/db-cicdpipeline-wave-2/regions/asia-south2/subnetworks/wave2-as2"

  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "new-service-account@db-cicdpipeline-wave-2.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}
/*resource "google_compute_instance" "wav2-windows" {
  count        = var.vm_count
  name         = var.instance_names[count.index]
  machine_type = var.machine_type
  zone         = "asia-south2-c"

  boot_disk {
    initialize_params {
      image = var.image_windows
      labels = {
        my_label = "value"
      }
    }
  }
  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "custom"
    subnetwork = "wave2-as2"

  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.wave2-garage-sa.email
    scopes = ["cloud-platform"]
  }
}*/
