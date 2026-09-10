variable "gh_pat" {
  type = string
}

job "github-runner" {
  datacenters = ["acumen-dc1"]
  type        = "service"

  group "runner" {
    count = 1

    restart {
      attempts = 0
      mode     = "fail"
    }

    reschedule {
      unlimited      = true
      delay          = "10s"
      delay_function = "constant"
    }

    task "runner" {
      driver = "docker"

      config {
        image = "myoung34/github-runner:latest"
      }

      env {
        REPO_URL       = "https://github.com/ReyzuaWeh/acumen-infra-migration"
        RUNNER_NAME    = "acumen-nomad-runner"
        RUNNER_WORKDIR = "/tmp/runner"
        EPHEMERAL      = "false"
        LABELS         = "acumen,nomad"
        ACCESS_TOKEN   = var.gh_pat
      }

      resources {
        cpu    = 500
        memory = 512
      }
    }
  }
}