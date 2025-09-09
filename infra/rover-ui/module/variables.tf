variable "project_id" { type = string }
variable "region" {
  type    = string
  default = "us-central1"
}
variable "service_name" { type = string }
variable "image" { type = string } # full AR image URL (passed by CI)
variable "domain_name" {
  type    = string
  default = ""
} # "" to skip mapping
variable "allow_unauthenticated" {
  type    = bool
  default = true
}
