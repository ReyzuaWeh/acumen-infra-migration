#!/bin/bash
set -e

chown -R acumen:acumen /home/acumen/.ssh
chmod 700 /home/acumen/.ssh
chmod 600 /home/acumen/.ssh/authorized_keys 2>/dev/null || true

mkdir -p /var/log/consul /var/log/nomad

consul agent -config-dir=/etc/consul.d > /var/log/consul/consul.log 2>&1 &
sleep 3
nomad agent -config=/etc/nomad.d/nomad.hcl > /var/log/nomad/nomad.log 2>&1 &

service dnsmasq start

exec /usr/sbin/sshd -D
