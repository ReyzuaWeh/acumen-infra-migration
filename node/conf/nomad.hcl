datacenter = "acumen-dc1"
data_dir   = "/var/nomad"
bind_addr  = "0.0.0.0"

server {
  enabled          = true
  bootstrap_expect = 3
}

client {
  enabled = true
}

consul {
  address = "127.0.0.1:8500"
}
