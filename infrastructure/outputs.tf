# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Main

# Root outputs
output gcp_firestore_name {
    description = "Firestore Metrics DB Name"
    value       = google_firestore_database.metrics_db.name
}

# Load metrics outputs
output load_metrics_cloud_run_name {
    description = "Load Metrics Cloud Run Name"
    value       = module.load_metrics_service.load_metrics_cloud_run_name
}

output load_metrics_cloud_scheduler_name {
    description = "Load Metrics Cloud Scheduler Name"
    value       = module.load_metrics_service.load_metrics_cloud_scheduler_name
}
