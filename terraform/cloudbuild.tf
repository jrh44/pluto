resource "google_cloudbuild_trigger" "trigger" {
  name = "pluto-cloud-function-trigger"

  github {
    owner        = "jrh44"
    name         = "pluto"
    push {
      branch = "main"
    }
  }

  build {
    step {
      name = "gcr.io/cloud-builders/gcloud"
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
    timeout = "1200s"
  }
}