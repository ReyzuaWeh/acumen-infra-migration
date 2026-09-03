job "web" {
  datacenters = ["acumen-dc1"]

  group "web" {
    network {
      port "http" {
        static = 8080
        to     = 80
      }
    }

    service {
      name     = "web"
      port     = "http"
      provider = "consul"
    }

    task "nginx" {
      driver = "docker"

      config {
        image        = "nginx:alpine"
        ports        = ["http"]
        network_mode = "host"
      }

      shutdown_delay = "10s"
    }
  }
}
