
resource "google_project_service" "composer_api" {
  provider = google
  project = "db-cicdpipeline-wave-2"
  service = "composer.googleapis.com"
  disable_on_destroy = false
}
resource "google_composer_environment" "composer_environment" {
  provider = google
  name = "composer-environment"
  config {
    software_config {
      image_version = "composer-2.1.14-airflow-2.5.1"
    }

    node_config {
     zone ="asia-south2-b"
     machine_type="n1-standard-1"
     network = "custom"
     subnetwork = "wave2-as2"
     service_account = "new-service-account@db-cicdpipeline-wave-2.iam.gserviceaccount.com"
    }
    database_config {
      machine_type = "db-n1-standard-2"
    }
    web_server_config {
      machine_type = "composer-n1-webserver-2"
    }
  }
}
