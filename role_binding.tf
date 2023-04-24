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

