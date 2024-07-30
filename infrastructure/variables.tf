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
    default     = "us-east1"
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


# Resource Runtime Environment Variables
variable env_gh_username {
    description = "Load Metrics Environment Variable -- GitHub Username"
    type        = string
}

variable env_lc_username {
    description = "Load Metrics Environment Variable -- Leetcode Username"
    type        = string
}

variable env_metrics_collection {
    description = "Metrics Firestore Collection Name"
    type        = string
}

variable env_gh_contributions_doc {
    description = "GitHub Contributions Metrics Firestore Document Name"
    type        = string
}

variable env_gh_repos_doc {
    description = "GitHub Repositories Firestore Document Name"
    type        = string
}

variable env_lc_solved_doc {
    description = "Leetcode Solved Count Firestore Document Name"
    type        = string
}

variable secret_gh_token_id {
    description = "Google Secret Manager ID for GitHub Personal Access Token"
    type        = string
    sensitive   = true
}
