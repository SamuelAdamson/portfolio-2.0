# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Load Metrics

resource "google_cloud_run_service" "load_metrics" {
    name = var.cloud_run_name
    location = var.gcp_region
}

