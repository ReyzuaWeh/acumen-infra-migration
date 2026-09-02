datacenter = "acumen-dc1"
data_dir   = "/var/consul"
bind_addr  = "0.0.0.0"
client_addr = "0.0.0.0"
node_name  = "NODE_NAME_PLACEHOLDER"

server           = true
bootstrap_expect = 3

retry_join = ["10.0.10.11", "10.0.10.12", "10.0.10.13"]

ui_config {
  enabled = true
}

ports {
  dns = 8600
}
