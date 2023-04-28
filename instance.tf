resource "google_compute_instance" "vm_instance"{
    name    = "linux-vm"
    machine_type  ="e2-medium"
    zone         = "asia-south2-a"

    boot_disk{
        initialize_params{
           image = "debian-cloud/debian-11"
        }
    }

    network_interface{
        network = "custom"
        subnetwork= "wave2-as2"
      }
    service_account{
        email = google_service_account.terraform.email
        scopes = ["cloud-platform"]
        }
}

resource "google_compute_instance" "vm_instance_1"{
    name    = "windows-vm"
    count = var.inst_count

    machine_type  ="e2-medium"
    zone         = "asia-south2-a"

    boot_disk{
        initialize_params{
           image = "windows-cloud/windows-2022"
        }
    }
    network_interface{
        network = "custom"
        subnetwork= "wave2-as2"
    }
    service_account{
        email = google_service_account.terraform.email
        scopes = ["cloud-platform"]
        }
}
