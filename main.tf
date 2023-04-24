resource "google_compute_instance" "vm_linux" {
  name         = "linx-vm"
  machine_type = "e2-medium"
  zone         = "asia-south2-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network       = "custom"
    subnetwork    = "wave2-as"
    access_config { }
  }
}

resource "google_compute_instance" "vm_windows1" {
  name         = "windows-vm1"
  machine_type = "e2-medium"
  zone         = "asia-south2-a"
  boot_disk {
    initialize_params {
      image = "windows-server-2022-datacenter"
    }
  }
  network_interface {
    network       = "custom"
    subnetwork    = "wave2-as"
    access_config { }
  }
}

resource "google_compute_instance" "vm_windows2" {
  name         = "windows-vm2"
  machine_type = "e2-medium"
  zone         = "asia-south2-a"
  boot_disk {
    initialize_params {
      image = "windows-server-2022-datacenter"
    }
  }
  network_interface {
    network       = "custom"
    subnetwork    = "wave2-as"
    access_config { }
  }
}
