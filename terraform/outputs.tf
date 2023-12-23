# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Main

output gcp_firestore_name {
    description = "Firestore Metrics DB Name"
    value       = google_firestore_database.metrics_db.name
}
