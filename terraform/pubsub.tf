resource "google_pubsub_topic" "topic" {
  project                    = var.project_id
  name                       = var.topic
  message_retention_duration = "10000s"
}

resource "google_pubsub_subscription" "subscription" {
  project              = var.project_id
  name                 = "${var.project_id}-catchall"
  topic                = google_pubsub_topic.topic.name
  ack_deadline_seconds = 60
  depends_on           = [google_pubsub_topic.topic]
}