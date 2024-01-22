# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Load Metrics

output load_metrics_cloud_run_name {
    description = "Load Metrics Cloud Run Job Name"
    value       = google_cloud_run_v2_job.load_metrics.name
}

output load_metrics_cloud_scheduler_name {
    description = "Load Metrics Cloud Scheduler Job Name"
    value       = google_cloud_scheduler_job.load_metrics_scheduler.name
}
