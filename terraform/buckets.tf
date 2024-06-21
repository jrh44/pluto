resource "google_storage_bucket" "pluto_bucket" {
  project  = var.project_id
  name     = "${var.project_id}${var.bucketsuffix}"
  location = "US"
}

resource "google_storage_bucket" "pluto_source" {
  project  = var.project_id
  name     = "${var.project_id}${var.sourcebucketsuffix}"
  location = "US"
}