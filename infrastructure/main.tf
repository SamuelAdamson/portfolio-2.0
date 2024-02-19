# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Main

# Data resource for project
data "google_project" "default" {}

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
    gcp_project_number      = data.google_project.default.number
    metrics_firestore_id    = var.gcp_firestore_id

    cloud_run_container_image   = var.load_metrics_container_image
    env_gh_username             = var.env_gh_username
    secret_gh_token_id          = var.secret_gh_token_id
    env_lc_username             = var.env_lc_username
    env_metrics_db              = google_firestore_database.metrics_db.name
    env_metrics_collection      = var.env_metrics_collection
    env_gh_contributions_doc    = var.env_gh_contributions_doc
    env_gh_repos_doc            = var.env_gh_repos_doc
    env_lc_solved_doc           = var.env_lc_solved_doc
    cloud_run_invoker           = var.gcp_service_account_invoker
}

# TODO for API Endpoints
# VPC Network for API Gateway
#     Three subnets -> one for each region 10.0.1.0/24, 10.0.2.0/24, 10.0.3.0/24
#     In the future, this should only allow HTTPS (443) not HTTP (80)
# Cloud armor for API Gateway -> Rate limiting
# API Gateway set up

# In modules:
# Cloud function
