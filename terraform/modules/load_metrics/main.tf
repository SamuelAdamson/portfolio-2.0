# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Load Metrics

resource "google_cloud_run_v2_job" "load_metrics" {
    name        = var.cloud_run_name
    location    = var.gcp_region

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

resource "google_cloud _scheduler_job" "load_metrics_scheduler" {
    name        = var.cloud_scheduler_name
    description = var.cloud_scheduler_description
    schedule    = var.schedule
    region      = var.gcp_region

    retry_config {
        retry_count = 3
    }

    http_target {
        http_method = "POST"
        uri         = "https://${google_cloud_run_v2_job.load_metrics.location}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${var.gcp_project_number}/jobs/${google_cloud_run_v2_job.load_metrics.name}:run"
    }
}
