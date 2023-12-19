# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Main

variable gcp_project_id {
    description = "Google Cloud Project ID"
    type        = "string"
}

variable gcp_service_account {
    description = "GCP Terraform Service Account"
    type        = "string"
}

variable gcp_regions {
    description = "GCP Regions For Deployment"
    type        = "list"
    default     = ["us-east1", "us-west1", "europe-west2"]
}

variable gcp_backend_bucket {
    description = "GCS Backend for TF State File"
    type        = "string"
}
