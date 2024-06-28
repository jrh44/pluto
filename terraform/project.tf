data "google_project" "project" {
    project_id = var.project_id
}

output "project_number" {
    value = data.google_project.project.number
}

resource "google_project_service" "gcp_services_enable" {
  project = var.project_id
  for_each = toset(var.service_list)
  service = each.key
  disable_on_destroy = false
}

resource "google_project_service" "gcp_services_enable_default" {
  project = var.project_id
  for_each = toset(var.default_service_list)
  service = each.key
  disable_on_destroy = false
}
