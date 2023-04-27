resource "google_project_service" "composer_api" {
  project = "db-cicdpipeline-wave-2"
  service = "composer.googleapis.com"
  disable_on_destroy = false
}
resource "google_composer_environment" "composer-env" {
  name   = "composer-env"
  config {
    software_config {
      image_version = "composer-2-airflow-2"
    }

    node_config {
      zone         = "asia-south2-a"
      machine_type = "e2-medium"
      network    = "custom"
      subnetwork = "wave2-as2"

      service_account_id = google_service_account.garage-sa.name
    }

    database_config {
      machine_type = "db-n1-standard-2"
    }

    web_server_config {
      machine_type = "composer-n1-webserver-2"
    }
  }
}
