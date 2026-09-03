variable "runner_token" {
  type = string
}
job "github-runner" {
  datacenters = ["acumen-dc1"]
  type        = "service"
  group "runner" {
    count = 1
    task "runner" {
      driver = "docker"
      config {
        image = "myoung34/github-runner:latest"
      }
      env {
        REPO_URL     = "https://github.com/ReyzuaWeh/acumen-infra-migration"
        RUNNER_NAME  = "acumen-nomad-runner"
        RUNNER_TOKEN = "${var.runner_token}"
        RUNNER_WORKDIR = "/tmp/runner"
        LABELS       = "acumen,nomad"
      }
      resources {
        cpu    = 500
        memory = 512
      }
    }
  }
}
