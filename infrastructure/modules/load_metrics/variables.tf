# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Load Metrics

variable gcp_region {
    description = "Region for Load Metrics Cloud Run"
    type        = string
}

variable gcp_project_number {
    description = "Project Number of GCP Project"
    type        = string
}

variable metrics_firestore_id {
    description = "Firestore Database Name for Project"
    type        = string
}

# Load metrics variables
variable cloud_run_name {
    description = "Name of Cloud Run Instance"
    type        = string
    default     = "load-metrics"
}

variable cloud_run_container_image {
    description = "Container Image for Load Metrics"
    type        = string
}

# Environment variables for cloud run instance
variable env_gh_username {
    description = "Load Metrics Environment Variable -- GitHub Username"
    type        = string
}

variable env_lc_username {
    description = "Load Metrics Environment Variable -- Leetcode Username"
    type        = string
}

variable env_metrics_db {
    description = "Metrics Firestore Database Name"
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

# Load metrics cloud scheduler
variable cloud_scheduler_name {
    description = "Load Metrics Scheduler Name"
    type        = string
    default     = "load-metrics-scheduler"
}

variable cloud_scheduler_description {
    description = "Load Metrics Scheduler Name"
    type        = string
    default     = "Schedule for Metrics Refresh"
}

variable schedule {
    description = "Load Metrics Schedule (Cron Expression)"
    type        = string
    default     = "0 2 * * *"
}

variable cloud_run_invoker {
    description = "Cloud Run Invoker Service Account"
    type        = string
}
