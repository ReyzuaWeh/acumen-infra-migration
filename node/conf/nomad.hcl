datacenter = "acumen-dc1"
data_dir   = "/var/nomad"
bind_addr  = "0.0.0.0"

server {
  enabled          = true
  bootstrap_expect = 3

  server_join {
    retry_join = ["10.0.10.11", "10.0.10.12", "10.0.10.13"]
  }
}

client {
  enabled = true
  host_network "default" {
    cidr = "0.0.0.0/0"
  }
}

advertise {
  http = "NODE_IP_PLACEHOLDER"
  rpc  = "NODE_IP_PLACEHOLDER"
  serf = "NODE_IP_PLACEHOLDER"
}

consul {
  address = "127.0.0.1:8500"
}
