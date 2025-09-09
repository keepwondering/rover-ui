resource "google_cloud_run_v2_service" "svc" {
  name     = var.service_name
  location = var.region

  template {
    containers { image = var.image }
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
  count    = var.domain_name != "" ? 1 : 0
  provider = google-beta

  location = var.region
  name     = var.domain_name

  metadata { namespace = var.project_id }
  spec { route_name = google_cloud_run_v2_service.svc.name }

  depends_on = [google_cloud_run_v2_service.svc]
}
