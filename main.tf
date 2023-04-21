resource "google_service_account" "service_account" {
  account_id = "vm_service_account"
  display_name = "Service Account"
}

resource "google_project_iam_binding" "default" {
  binding{
  project = "db-cicdpipeline-wave-2"
  role = "roles/compute.instanceAdmin"
  members = [
    "serviceAccount:${google_service_account.default.email}"
  ]
}
  resource "google_compute_instance" "windows-vm" {
  name         = "vm-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-2022"
    }
  }
  network_interface {
    network = "custom"
    subnetwork = "wave2-vm"
  }
}


