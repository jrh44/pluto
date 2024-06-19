resource "google_pubsub_topic_iam_member" "member" {
  project  = var.project_id                      
  topic    = google_pubsub_topic.topic.id 
  role     = "roles/pubsub.publisher"
  member   = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudasset.iam.gserviceaccount.com"
}

resource "google_cloud_asset_project_feed" "project_feed" {
  project      = var.project_id
  feed_id      = "assets"
  content_type = "RESOURCE"
  asset_types = var.asset_list
  feed_output_config {
    pubsub_destination {
      topic = google_pubsub_topic.topic.id
    }
  }
  depends_on = [google_pubsub_topic.topic]
}