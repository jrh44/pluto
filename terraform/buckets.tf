resource "google_storage_bucket" "pluto_bucket" {
  project  = var.project_id
  name     = "${var.project_id}${var.bucketsuffix}"
  location = "US"
  force_destroy = true
}

resource "google_storage_bucket" "pluto_source" {
  project  = var.project_id
  name     = "${var.project_id}${var.sourcebucketsuffix}"
  location = "US"
  force_destroy = true
}

resource "google_storage_bucket_object" "source_archive" {
  name   = "function_source.zip"
  bucket = google_storage_bucket.pluto_source.name
  source = "function_source.zip"
}
