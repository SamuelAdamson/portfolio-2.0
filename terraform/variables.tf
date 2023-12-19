# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Main

variable gcp_project_id {
    description = "Google Cloud Project ID"
    type        = string
}

variable gcp_service_account {
    description = "GCP Terraform Service Account"
    type        = string
}

variable gcp_regions {
    description = "GCP Regions For Deployment"
    type        = list
    default     = ["us-east1", "us-west1", "europe-west2"]
}

variable gcp_primary_region {
    description = "GCP Primary Region (Firestore, Batch Load Metrics)"
    type        = string
    default     = "us-west1"
}

variable gcp_firestore_id {
    description = "Firestore Database Name for Project"
    type        = string
}
