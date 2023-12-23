# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Main

# Firestore DB for metrics
resource "google_firestore_database" "metrics_db" {
    project                 = var.gcp_project_id
    name                    = var.gcp_firestore_id
    location_id             = "nam5"
    type                    = "FIRESTORE_NATIVE"
    delete_protection_state = "DELETE_PROTECTION_DISABLED"
    deletion_policy         = "DELETE"
}

# Load metrics
module "load_metrics_service" {
    source = "./modules/load_metrics"

    gcp_region              = var.gcp_primary_region
    metrics_firestore_id    = var.gcp_firestore_id

    cloud_run_container_image   = var.load_metrics_container_image
    env_gh_username             = var.load_metrics_env_gh_username
    env_gh_token                = var.load_metrics_env_gh_token
    env_lc_username             = var.load_metrics_env_lc_username
}
