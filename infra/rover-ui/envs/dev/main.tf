variable "project_id" { type = string }
variable "region" { type = string }
variable "image" { type = string }

variable "service_name" { type = string }
variable "domain_name" { type = string }

module "svc" {
  source = "../../module"

  project_id   = var.project_id
  region       = var.region
  service_name = var.service_name
  image        = var.image
  domain_name  = var.domain_name
}
