terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.13.0"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = file("cred-kupa.json")
  project = "weighty-casing-338809"
  region  = "us-west1"
  zone    = "us-west1-b"
}

output "gcp_instance_ip" {
  value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}



resource "google_compute_instance" "default" {
  name         = "my-test14"
  #This CPU: custom-NUMBER_OF_CPUS-AMOUNT_OF_MEMORY_MB
  machine_type = "custom-2-4048"
  zone         = "us-west1-b"

  boot_disk {
    initialize_params {
    #For quick access to options
    # https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_instance#nested_boot_disk

    #size - The size of the image in gigabytes.
    #type - The GCE disk type. One of pd-standard or pd-ssd.
    #image - The image from which this disk was initialised.
      size = "16"
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}  
  
