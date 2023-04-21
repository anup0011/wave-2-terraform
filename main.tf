resource "google_service_account" "default" {
  account_id   = "wave2-vm"
  display_name = "wave2-vm-creator"
}

resource "google_project_iam_binding" "default"{
   binding{
   project = "db-cicdpipeline-wave-2"
   role = roles/compute.instanceAdmin

   members = [
     "serviceAccount:${google_service_account.default.email}"
   ]
   }
   binding{   
   project = "db-cicdpipeline-wave-2"
   role = roles/cloudkms.cryptoKeyEncrypterDecrypter

   members = [
     "serviceAccount:${google_service_account.default.email}"
   ]
   }
}

resource "google_kms_key_ring" "default" {
  name = "wave2-key-ring"
  location = "global"
}

resource "google_kms_crypto_key" "default"{
  name = "wave2-crypto-key"
  key_ring = google_kms_key_ring.default.self_link
}

resource "google_compute_instance" "default" {
  name         = "linux_VM"
  machine_type = "e2-medium"
  zone         = "asia-south2-a"


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
     
    }
  }

  network_interface {
    network = "default"

  }

}

resource "google_compute_instance" "default" {
  name         = "win_VM_1"
  machine_type = "e2-medium"
  zone         = "asia-south2-a"


  boot_disk {
    initialize_params {
      image = "windows-server-2022-dc-v20230315"
     
    }
  }

  network_interface {
    network = "default"

  }
}
resource "google_compute_instance" "default" {
  name         = "win_VM_1"
  machine_type = "e2-medium"
  zone         = "asia-south2-a"


  boot_disk {
    initialize_params {
      image = "windows-server-2022-dc-v20230315"
     }
  }

  network_interface {
    network = "default"
  }
}