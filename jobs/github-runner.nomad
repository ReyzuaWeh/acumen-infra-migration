variable "runner_token" {
  type = string
}

job "github-runner" {
  datacenters = ["acumen-dc1"]
  type        = "service"

  group "runner" {
    count = 1
    restart {
      attempts = 10
      interval = "30m"
      delay    = "15s"
      mode     = "delay"
    }
    task "runner" {
      driver = "docker"
      config {
        image = "myoung34/github-runner:latest"
      }
      env {
        REPO_URL      = "https://github.com/ReyzuaWeh/acumen-infra-migration"
        RUNNER_NAME   = "acumen-nomad-runner"
        RUNNER_TOKEN  = "${var.runner_token}"
        RUNNER_WORKDIR = "/tmp/runner"
        EPHEMERAL     = "false"
        LABELS        = "acumen,nomad"
      }

      resources {
        cpu    = 500
        memory = 512
      }
    }
  }
}