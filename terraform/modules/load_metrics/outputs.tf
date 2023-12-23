# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Load Metrics

output load_metrics_cloud_run_name {
    description = "Firestore Load Metrics Clour Run Job Name"
    value = google_cloud_run_v2_job.load_metrics.name
}
