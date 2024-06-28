#resource "google_cloudbuildv2_connection" "my-connection" {
#  location = "us-central1"
#  name = "my-terraform-github-connection"
#  github_config {
#    
#  }
#}

#resource "google_cloudbuildv2_repository" "my-repository" {
#  name = "my-repo"
#  parent_connection = google_cloudbuildv2_connection.my-connection.id
#  remote_uri = "https://github.com/jrh44/pluto.git"
#}

resource "google_cloudbuild_trigger" "trigger" {
  name = "pluto-cloud-function-trigger"

  github {
    owner        = "jrh44"
    name         = "pluto"
    push {
      branch = "^main$"
    }
  }

  build {
    step {
      name = "gcr.io/google.com/cloudsdktool/cloud-sdk"
      args = [
        "functions",
        "deploy",
        var.function,
        "--runtime",
        "python39",
        "--trigger-http",
        "--source",
        "pluto/cloudfunction",
        "--entry-point",
        "pubsub_to_bigquery",
        "--region",
        "us-central1"
      ]
    }
    options {
      logging = "CLOUD_LOGGING_ONLY"
    }
    timeout = "1200s"
  }
}