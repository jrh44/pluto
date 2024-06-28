resource "null_resource" "fetch_and_zip_source" {
  provisioner "local-exec" {
    command = "bash -c 'mkdir -p /tmp/function_source && curl -L -o /tmp/main.zip https://github.com/${var.github_username}/${var.repo_name}/archive/refs/heads/main.zip && unzip -o /tmp/main.zip -d /tmp/function_source && cd /tmp/function_source/pluto-main/cloudfunction && zip -r /tmp/function_source.zip . && gsutil cp /tmp/function_source.zip gs://${google_storage_bucket.pluto_source.name}/function_source.zip'"
    #command = <<-EOT
    #  mkdir -p /tmp/function_source
    #  curl -L -o /tmp/main.zip "https://github.com/${var.github_username}/${var.repo_name}/archive/refs/heads/main.zip"
    #  unzip /tmp/main.zip -d /tmp/function_source
     # cd /tmp/function_source/pluto-main/cloudfunction
     # zip -r /tmp/function_source.zip .
      #gsutil cp /tmp/function_source.zip "gs://${google_storage_bucket.pluto_source.name}/function_source.zip"
    #EOT
   # interpreter = ["/bin/sh" ,"-c"]
  }
}

##resource "null_resource" "set_cloud_build_service_account" {
##  provisioner "local-exec" {
##    command = <<-EOF
##      gcloud projects add-iam-policy-binding ${var.project_id} \
##        --member=serviceAccount:${google_service_account.service_account.email} \
##        --role=roles/cloudbuild.builds.editor
##    EOF
##  }

##resource "google_storage_bucket_object" "function_zip" {
##  name   = "function_source.zip"
##  bucket = google_storage_bucket.pluto_source.name
##  source = "/tmp/function_source.zip"
##  depends_on = [null_resource.fetch_and_zip_source]
##}

resource "google_cloudfunctions2_function" "function" {      
  project             = var.project_id
  name                = var.function
  location            = "us-central1"
  build_config {
    runtime           = "python39"
    entry_point       = "pubsub_to_bigquery"
    service_account   = google_service_account.service_account.id
    source{
        storage_source {
            bucket = google_storage_bucket.pluto_source.name
            object = google_storage_bucket_object.source_archive.name
        }
    }
  }
  service_config {
      available_memory = "256M"
      timeout_seconds = 60
      service_account_email   = google_service_account.service_account.email
  } 

event_trigger {
        pubsub_topic   = google_pubsub_topic.topic.name
        event_type = "google.cloud.pubsub.topic.v1.messagePublished"
        service_account_email =     google_service_account.service_account.email
}

  depends_on = [google_pubsub_topic.topic,null_resource.fetch_and_zip_source]
}

