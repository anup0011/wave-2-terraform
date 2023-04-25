resource "google_compute_instance" "windows_vm" {
  count = var.instance_count
  name = var.instance_names[count.index]
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
