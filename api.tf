resource "google_project_service" "project-compute" {
  project = var.project_id
  service =  "compute.googleapis.com"

}

resource "google_project_service" "project-iam" {
  project = var.project_id
  service =  "iam.googleapis.com"

}

resource "google_project_service" "project-cf" {
  project = var.project_id
  service =  "cloudfunctions.googleapis.com"

}

resource "google_project_service" "project-schedular" {
  project = var.project_id
  service =  "schedular.googleapis.com"

}