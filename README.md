# Overview
This project focuses on building the foundational "Acumen" environment: a Bastion host for secure access, and a private network of nodes running Consul, Nomad, and dnsmasq for service discovery and orchestration.

*CODE : DEV-710*

# Progress

| Date | Summary | Evidence |
| --- | --- | --- |
| 29 August 2026 | Focus on initialization and quick setup | [Docker Compose Services](./documentation/20260829/setup-init-configuration.png) |
| 02 September 2026 | Focus on configure Nomad and Consul locally. Also, learn about the dnsmasq configuration | [Nomad and Consul Configuration](./documentation/20260902/nomad-consul-configuration.png) |
| 03 September 2026 | Today's goal was to complete all the remaining step locally | |

# Configuration

## Prerequisites

- Docker Engine and Docker Compose
- SSH client (OpenSSH or Termux on mobile)
- `git` (to clone this repo)

## Generating SSH keys

Generate a dedicated keypair for this project (do not reuse your personal SSH key):

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_acumen -C "acumen-lab" -N ""
```

This creates:
- `~/.ssh/id_acumen` — private key (keep secret)
- `~/.ssh/id_acumen.pub` — public key (referenced by `docker-compose.yml`)

Remember, if you can't access your host machine, you can remove old known hosts. Here is the command:

```bash
ssh-keygen -R <host-ip>
``` 

## Starting The Project

```bash
git clone 
cd acumen-infra-migration
docker compose up -d --build
docker compose ps   # all services should show "Up"
```

Access the Bastion:
```bash
ssh -i ~/.ssh/id_acumen acumen@<host-ip> -p 2222
```

Private nodes are only reachable through the Bastion, not directly from outside the Docker host.

## Testing in Different Machine/Device

After you start it, you may realize that you can't test it on the same device. That's you need a second device to test it. Here is some you have to do.

### Tools to Install

- OpenSSH client (or Termux on Android)

### Configuration

First, go to machine you used to run the service. Then, run this command

```bash
scp ~/.ssh/id_acumen <user>@<second-device-ip>:~/.ssh/id_acumen
```

Then, on the second device, set correct permissions and test:

```bash
chmod 600 ~/.ssh/id_acumen

# Should succeed
ssh -i ~/.ssh/id_acumen acumen@<host-ip> -p 2222

# Should fail/timeout — proves node isolation
ssh -i ~/.ssh/id_acumen acumen@10.0.10.11 -p 22
```

Then, you might need to test the SSH jump. Just copy the `jump_config/config` file to your second machine's `~/.ssh/config`:

```bash
scp jump_config/config <user>@<second-device-ip>:~/.ssh/config
```

On the second device, set correct permissions, then connect through the Bastion in one step:

```bash
chmod 600 ~/.ssh/config
ssh <host-name>
```

## Access Nomad and Consul in Each Nodes
To do this, you can use 2 method to access.

1. Forwarding port

This method requires `ssh` to forward the port from the node to your local machine. For example, to access Nomad on node1:

```bash
ssh -i ~/.ssh/id_acumen -L 4646:<host-ip>:4646 acumen@<host-ip> -p 2222
ssh -i ~/.ssh/id_acumen -L 8500:<host-ip>:8500 acumen@<host-ip> -p 2222
```

Then, you can access Nomad UI in your browser at `http://localhost:4646` and Consul UI at `http://localhost:8500`.

2. Use its host IP address

This method just the nodes original addresses. For example, if you want to access Nomad in node-1, you can use `http://10.0.10.11:4646` and Consul in node1, you can use `http://10.0.10.11:8500`.
