resource "google_pubsub_topic" "topic" {
  name = "start-stop"

  labels = {
    foo = "bar"
  }

  message_retention_duration = "86600s"
}
