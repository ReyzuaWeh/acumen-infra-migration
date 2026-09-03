job "web" {
  datacenters = ["acumen-dc1"]

  group "web" {
    network {
      port "http" {
        static      = 8080
        to          = 80
        host_network = "default"
      }
    }

    service {
      name         = "web"
      port         = "http"
      provider     = "consul"
      address_mode = "host"
    }

    task "nginx" {
      driver = "docker"

      config {
        image = "nginx:alpine"
        ports = ["http"]
      }
    }
  }
}