# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- Main

terraform {
    required_version = ">= 1.6.6"

    required_providers {
        google = {
            source  = "hashicorp/google"
            version = ">= 5.10.0"
        }
    }
}
