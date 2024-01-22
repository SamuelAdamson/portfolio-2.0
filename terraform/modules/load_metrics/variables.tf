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

variable env_gh_token {
    description = "Load Metrics Environment Variable -- GitHub Auth Token"
    type        = string
    sensitive   = true
}

variable env_lc_username {
    description = "Load Metrics Environment Variable -- Leetcode Username"
    type        = string
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
