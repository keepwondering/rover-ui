locals {
  apis = toset([
    "run.googleapis.com",
    "artifactregistry.googleapis.com",
  ])
}

resource "google_project_service" "apis" {
  for_each = local.apis
  project  = var.project_id
  service  = each.key
}

resource "google_artifact_registry_repository" "repo" {
  repository_id = var.repo_name
  location      = var.region
  format        = "DOCKER"
  description   = "App images"
}

resource "google_cloud_run_v2_service" "svc" {
  name     = var.service_name
  location = var.region
  depends_on = [google_project_service.apis, google_artifact_registry_repository.repo]

  template {
    containers {
      image = var.image
    }
    max_instance_request_concurrency = 80
  }
}

resource "google_cloud_run_v2_service_iam_member" "public" {
  count    = var.allow_unauthenticated ? 1 : 0
  name     = google_cloud_run_v2_service.svc.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_domain_mapping" "mapping" {
  provider = google-beta
  count    = var.domain_name != "" ? 1 : 0

  location = var.region
  name     = var.domain_name

  metadata { namespace = var.project_id }

  spec {
    route_name = google_cloud_run_v2_service.svc.name
  }

  depends_on = [google_cloud_run_v2_service.svc]
}
