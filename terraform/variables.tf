# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Main

# Project Variables
variable gcp_project_id {
    description = "Google Cloud Project ID"
    type        = string
}

variable gcp_service_account_tf {
    description = "GCP Terraform Service Account"
    type        = string
}

variable gcp_service_account_invoker {
    description = "GCP Invoker Service Account"
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
    default     = "metrics"
}

# Load Metrics Variables
variable load_metrics_container_image {
    description = "Container Image for Load Metrics"
    type        = string
}

variable load_metrics_env_gh_username {
    description = "Load Metrics Environment Variable -- GitHub Username"
    type        = string
}

variable load_metrics_env_gh_token {
    description = "Load Metrics Environment Variable -- GitHub Auth Token"
    type        = string
    sensitive   = true
}

variable load_metrics_env_lc_username {
    description = "Load Metrics Environment Variable -- Leetcode Username"
    type        = string
}
