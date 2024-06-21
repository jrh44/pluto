resource "null_resource" "fetch_and_zip_source" {
  provisioner "local-exec" {
    interpreter = ["/bin/sh" ,"-c"],
    command = <<-EOT
      exec "mkdir -p /tmp/function_source"
      exec "curl -L -o /tmp/main.zip https://github.com/${var.github_username}/${var.repo_name}/archive/refs/heads/main.zip"
      exec "unzip /tmp/main.zip -d /tmp/function_source"
      exec "cd /tmp/function_source/cloudfunction"
      exec "zip -r /tmp/function_source.zip ."
      exec "gsutil cp /tmp/function_source.zip gs://${google_storage_bucket.pluto_source.name}/function_source.zip"
    EOT
  }
}

resource "google_storage_bucket_object" "function_zip" {
  name   = "function_source.zip"
  bucket = google_storage_bucket.pluto_source.name
  source = "/tmp/function_source.zip"
  depends_on = [null_resource.fetch_and_zip_source]
}

resource "google_cloudfunctions_function" "function" {      
  project             = var.project_id
  name                = var.function
  available_memory_mb = 256
  runtime             = "python39"
  #source_repository {
  #  url = "https://github.com/jrh44/pluto/tree/main/cloudfunction"
  #}
  source_archive_bucket = google_storage_bucket.pluto_source.name
  source_archive_object = google_storage_bucket_object.function_zip.name
  entry_point       = "pubsub_to_bigquery"
  timeout = 60
  event_trigger {
    resource   = google_pubsub_topic.topic.name
    event_type = "google.pubsub.topic.publish"
  }
  depends_on = [google_pubsub_topic.topic,null_resource.fetch_and_zip_source]
}
