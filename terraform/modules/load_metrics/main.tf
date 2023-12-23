# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Load Metrics

resource "google_cloud_run_v2_job" "load_metrics" {
    name = var.cloud_run_name
    location = var.gcp_region

    # Docker image
    template {
        template {
            containers {
                image = var.cloud_run_container_image

                resources {
                    limits = {
                        cpu     = "2"
                        memory  = "1024Mi"
                    }
                }

                # Environment variables for cloud run instance
                env {
                    name    = "FIRESTORE_DB"
                    value   = var.metrics_firestore_id
                }
                env {
                    name    = "GH_USERNAME"
                    value   = var.env_gh_username
                }
                env {
                    name    = "GH_TOKEN"
                    value   = var.env_gh_token
                }
                env {
                    name    = "LC_USERNAME"
                    value   = var.env_lc_username
                }
            }
        }
    }
}
