# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Main

# Firestore for api metrics
resource "google_firestore_database" "metrics_db" {
    project                 = var.gcp_project_id
    name                    = var.gcp_firestore_id
    location_id             = "nam5"
    type                    = "FIRESTORE_NATIVE"
    delete_protection_state = "DELETE_PROTECTION_DISABLED"
    deletion_policy         = "DELETE"
}
