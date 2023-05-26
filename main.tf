// Creating ssh firewall rule for linux instance.
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

// Creating linux instance.
// Using aisa-south2 region for subnet.
resource "google_compute_instance" "wave2-linux" {
  name         = "wave2-linux1"
  machine_type = var.machine_type
  zone         = "asia-south2-b"
  allow_stopping_for_update = true
  tags = [ "wave-2-git" ]
  depends_on = [google_project_iam_member.keycrypto_role_sa ]

  boot_disk {
    kms_key_self_link = google_kms_crypto_key.key-garage.id # Using kms key for disk encryption and decryption.
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
    email  = var.new_sa
    scopes = ["cloud-platform"]
  }
}

# Creating two windows instances.
// Using aisa-south2 region for subnet.
resource "google_compute_instance" "wave2-windows" {
  count        = var.vm_count
  name         = "wave2-win${count.index}"
  machine_type = var.machine_type
  zone         = "asia-south2-c"
  allow_stopping_for_update = true
  tags = [ "wave-2-git" ]
  depends_on = [google_project_iam_member.keycrypto_role_sa ]

  boot_disk {
    kms_key_self_link = google_kms_crypto_key.key-garage.id # Using kms key for disk encryption and decryption.
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
    email  = var.new_sa
    scopes = ["cloud-platform"]
  }
}

# Creating repository in Artifact Registry
resource "google_artifact_registry_repository" "wave2app_repo" {
  depends_on = [ google_project_iam_binding.artifact_iam ,google_project_iam_binding.artifact_iam_sa]
  location = "asia-south1"
  repository_id = "wave2app"
  description = "Maven repository"
  format = "MAVEN"
  kms_key_name = google_kms_crypto_key.key_composer.id
  maven_config {
    allow_snapshot_overwrites = true
    version_policy = "VERSION_POLICY_UNSPECIFIED"
  }
  
}

# Binding kms roles to artifactregistry service agent 
resource "google_project_iam_binding" "artifact_iam" {
  project = var.project
  role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = ["serviceAccount:service-817731629023@gcp-sa-artifactregistry.iam.gserviceaccount.com",
             "serviceAccount:wave-2-app@db-cicdpipeline-wave-2.iam.gserviceaccount.com",
             "serviceAccount:my-service-account@db-cicdpipeline-wave-2.iam.gserviceaccount.com"]
  
}

# Assigning artifact administrating roles to SA
resource "google_project_iam_binding" "artifact_iam_sa" {
  project = var.project
  role = "roles/artifactregistry.admin"
  members = ["serviceAccount:wave-2-app@db-cicdpipeline-wave-2.iam.gserviceaccount.com",
             "serviceAccount:my-service-account@db-cicdpipeline-wave-2.iam.gserviceaccount.com"]
}

# Binding roles to users on repository
resource "google_artifact_registry_repository_iam_binding" "artifact_iam_users"{
  project = var.project
  location = var.composer_region
  repository = google_artifact_registry_repository.wave2app_repo.name
  role = "roles/artifactregistry.repoAdmin"
  members = var.iam_members
}

# Public Access to Artifact
resource "google_artifact_registry_repository_iam_binding" "artifact_iam_all_users"{
  project = var.project
  location = var.composer_region
  repository = google_artifact_registry_repository.wave2app_repo.name
  role = "roles/artifactregistry.reader"
  members = "allUsers" 
}