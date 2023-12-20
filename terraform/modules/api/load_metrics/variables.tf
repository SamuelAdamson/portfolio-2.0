# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Load Metrics

variable "cloud_run_name" {
    description = "Name of Cloud Run Instance"
    type        = string
    default     = "load_metrics"
}

variable "gcp_region" {
    description = "Region for Load Metrics Cloud Run"
    type        = string
}

variable "load_metrics_container_image" {
    description = "Container Image for Load Metrics"
    type        = string
}
