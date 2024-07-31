# Samuel Adamson (giibbu)
# Portfolio Page
# Terraform Configuration -- VPC Network

# TODO
# resource "google_compute_network" "metrics_network" {  }

# TODO -- subnetworks 
#       In main variables file create a list of subnet CIDR blocks which correspond to regions
#       Pass to this module and create a for loop to iterate over these
# resource "google_compute_subnetwork" "" {  }

# TODO -- Allow HTTPS rule (permanent)
# resource "google_compute_firewall" "allow_https"

# TODO -- Allow HTTP rule (temporary for development [until we have custom domain set up])
# resource "google_compute_firewall" "allow_https"
