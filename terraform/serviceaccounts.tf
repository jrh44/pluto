resource "google_service_account" "service_account" {
  account_id   = var.function_sa
}

resource "google_project_iam_member" "function_sa_binding" {
  project       = var.project_id
  role          = "roles/viewer"
  member        = "serviceAccount:${google_service_account.service_account.email}"
}

