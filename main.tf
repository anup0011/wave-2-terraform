resource "google_compute_instance" "windows_vm" {
  name = "windows-instance"
  count = var.instance_count
  machine_type = "e2-medium"
  boot_disk {
    initialize_params{
        image = "windows-cloud/windows-2022"
    }
  }
  network_interface {
    network = "custom"
    subnetwork = "wave2-as2"
  }
}

resource "google_compute_instance" "linux_vm" {
  name = "linux-instance"
  machine_type = "e2-medium"
  boot_disk {
    initialize_params{
        image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = "custom"
    subnetwork = "wave2-as2"
  }
}