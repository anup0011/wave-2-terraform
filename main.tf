
resource "google_compute_instance" "default" {
  name         = "virtual-machine1"
  machine_type = "n1-standard-1"
  zone         = "asia-south2-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-server-2019-dc-core-v20220405"
     
    }
  }

  
  network_interface {
    network = "default"

    access_config {
     
    }
  }

  metadata = {
   windows-startup-script-ps1 = "New-Item -Path C:\\Windows\\Temp\\hello-world.txt -ItemType File -Value 'Hello, World!'"
  }

  }

