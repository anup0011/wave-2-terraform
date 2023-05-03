resource "google_project_service" "composer_api" {
  project = var.project
  service = "composer.googleapis.com"
  disable_on_destroy = false
}

resource "google_composer_environment" "composer_environment" {
  name = "composer-env"
  region = var.composer_region
  config {
    software_config {
      image_version = "composer-2.1.14-airflow-2.5.1"
    }

    node_config {
     zone ="asia-south1-a"
     machine_type="n1-standard-1"
     network = "custom"
     subnetwork = "wave2-as1"
     service_account = "serviceAccount:${var.new_sa}"
    }
    /*database_config {
      machine_type = "db-n1-standard-2"
    }
    web_server_config {
      machine_type = "composer-n1-webserver-2"
    }
    */
    encryption_config {
      kms_key_name = google_kms_crypto_key.key_composer.id
    }
  }
}

resource "google_project_iam_member" "composer-worker" {
project = var.project
role = "roles/composer.worker"
member = var.new_sa
}
