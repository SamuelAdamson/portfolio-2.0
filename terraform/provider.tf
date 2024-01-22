# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Main

provider "google" {
    project         = var.gcp_project_id
    access_token    = data.google_service_account_access_token.default.access_token
}

provider "google" {
    alias = "impersonation"
    scopes = [
        "https://www.googleapis.com/auth/cloud-platform",
        "https://www.googleapis.com/auth/userinfo.email",
    ]
}

locals {
    tf_service_account = var.gcp_service_account_tf
}

data "google_service_account_access_token" "default" {
    provider                = google.impersonation
    target_service_account  = local.tf_service_account
    scopes                  = ["userinfo-email", "cloud-platform"]
    lifetime                = "1200s" # exists for 20 minutes
}
