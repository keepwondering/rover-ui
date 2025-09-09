terraform {
  required_version = ">= 1.13.0"
  required_providers {
    google      = { source = "hashicorp/google", version = "~> 5.45" }
    google-beta = { source = "hashicorp/google-beta", version = "~> 5.45" }
  }
  backend "gcs" {}
}
