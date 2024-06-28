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

#resource "google_cloudfunctions_function" "function" {      
#  project             = var.project_id
#  name                = var.function
#  available_memory_mb = 256
#  runtime             = "python39"
#  service_account_email = google_service_account.service_account.email
#  #source_repository {
#  #  url = "https://github.com/jrh44/pluto/tree/main/cloudfunction"
#  #}
#  source_archive_bucket = google_storage_bucket.pluto_source.name
#  source_archive_object = "function_source.zip"
#  entry_point       = "pubsub_to_bigquery"
#  timeout = 60
#  event_trigger {
#    resource   = google_pubsub_topic.topic.name
#    event_type = "google.pubsub.topic.publish"
#  }
#  depends_on = [google_pubsub_topic.topic,null_resource.fetch_and_zip_source]
#}

