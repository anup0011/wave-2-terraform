resource "google_project_service" "composer_api" {
  provider = google
  project = "db-cicdpipeline-wave-2"
  service = "composer.googleapis.com"
  disable_on_destroy = false
}
resource "google_composer_environment" "composer_environment" {
  provider = google
  name = "composer-environment"
  region = "asia-south1"
  config {
    software_config {
      image_version = "composer-1.20.0-airflow-1.10.15"
    }

    node_config {
     zone ="asia-south1-a"
     machine_type="n1-standard-1"
     network = "custom"
     subnetwork = "wave2-as1"
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
resource "google_project_iam_member" "composer-worker" {
project = "db-cicdpipeline-wave-2"
role = "roles/composer.worker"
member = "serviceAccount:new-service-account@db-cicdpipeline-wave-2.iam.gserviceaccount.com"
}
