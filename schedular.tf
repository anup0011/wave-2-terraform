resource "google_cloud_scheduler_job" "stop_job" {
  name        = "stop-job"
  description = "stop job"
  schedule    = "0 18 * * 1-5"
  region      = "us-central1"
  time_zone        = "America/New_York"

  pubsub_target {
    # topic.id is the topic's full resource name.
    topic_name = google_pubsub_topic.topic.id
    data       = base64encode("stop")
  }
}

resource "google_cloud_scheduler_job" "start_job" {
  name        = "start-job"
  description = "start job"
  schedule    = "0 9 * * 1-5"
  region      = "us-central1"
  time_zone        = "America/New_York"

  pubsub_target {
    # topic.id is the topic's full resource name.
    topic_name = google_pubsub_topic.topic.id
    data       = base64encode("start")
  }
}
