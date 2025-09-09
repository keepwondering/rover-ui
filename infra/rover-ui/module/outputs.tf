output "service_url" { value = google_cloud_run_v2_service.svc.uri }
output "image" { value = var.image }
output "domain_name" { value = var.domain_name }
