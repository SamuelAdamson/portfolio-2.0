# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Main

# NOTE that the Google Cloud Storage (GCS) bucket which stores the 
# terraform state file should be managed manually.

terraform {
    backend "gcs" {
        bucket  = var.gcp_backend_bucket
        prefix  = "terraform/state"
    }
}
