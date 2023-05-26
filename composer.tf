# Enabling Composer Api.
resource "google_project_service" "composer_api" {
  project = var.project
  service = "composer.googleapis.com"
  disable_on_destroy = false
}

# Creating Composer Environment.
# Composer is Available only in asia-south1 in ASIA region. 
# Using subnet of asia-south1.
resource "google_composer_environment" "composer_environment" {
  name = "composer-env"
  region = var.composer_region
  depends_on = [ google_project_iam_binding.composerkey_role_sa ]
  config {
    software_config {
      image_version = "composer-2.1.14-airflow-2.5.1"
    }

    node_config {
     network = "custom"
     subnetwork = "wave2-as1"
     service_account = var.new_sa
    }
    encryption_config {
      kms_key_name = google_kms_crypto_key.key_composer.id 
    }
  }
}

# Assign composer worker role to the service account.
resource "google_project_iam_member" "composer-worker" {
project = var.project
role = "roles/composer.worker"
member = "serviceAccount:${var.new_sa}"
}

# Assigning serviceAgentV2Ext role for service Account.
resource "google_service_account_iam_member" "custom_service_account" {
  service_account_id = data.google_service_account.new_service_account.name
  role = "roles/composer.ServiceAgentV2Ext"
  member = "serviceAccount:service-817731629023@cloudcomposer-accounts.iam.gserviceaccount.com"
}

# Assigning cryptoKeyEncrypterDecrypter role on service agents used by composer environment.
resource "google_project_iam_binding" "composerkey_role_sa" {
  project = var.project
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members  = ["serviceAccount:service-817731629023@cloudcomposer-accounts.iam.gserviceaccount.com",
              "serviceAccount:service-817731629023@container-engine-robot.iam.gserviceaccount.com",
              "serviceAccount:service-817731629023@compute-system.iam.gserviceaccount.com",
              "serviceAccount:service-817731629023@gcp-sa-artifactregistry.iam.gserviceaccount.com",
              "serviceAccount:service-817731629023@gcp-sa-pubsub.iam.gserviceaccount.com",
              "serviceAccount:service-817731629023@gs-project-accounts.iam.gserviceaccount.com",
              "serviceAccount:service-817731629023@gcp-sa-artifactregistry.iam.gserviceaccount.com",
              "serviceAccount:wave-2-app@db-cicdpipeline-wave-2.iam.gserviceaccount.com",
              "serviceAccount:my-service-account@db-cicdpipeline-wave-2.iam.gserviceaccount.com"
  ]
}

# Assigning ServiceAgentV2Ext role to composer service agent since we are using composer v2.
resource "google_project_iam_member" "composerkey_role_sav2ext" {
  project = var.project
  role    = "roles/composer.ServiceAgentV2Ext"
  member  = "serviceAccount:service-817731629023@cloudcomposer-accounts.iam.gserviceaccount.com"
}

# Assigning environmentAndStorageObjectAdmin role to users to work on composer environment.
resource "google_project_iam_binding" "composer_users_iam" {
  project = var.project
  role = "roles/composer.environmentAndStorageObjectAdmin"
  members = var.iam_members
}


