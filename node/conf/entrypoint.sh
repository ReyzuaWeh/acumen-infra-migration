#!/usr/bin/env bash
set -e

chown acumen:acumen /home/acumen/.ssh
chmod 700 /home/acumen/.ssh

mkdir -p /var/log/consul /var/log/nomad

sed -i "s/NODE_NAME_PLACEHOLDER/${NODE_NAME}/" /etc/consul.d/consul.hcl
sed -i "s/NODE_IP_PLACEHOLDER/${NODE_IP}/g" /etc/nomad.d/nomad.hcl

echo "nameserver 127.0.0.1" > /etc/resolv.conf

consul agent -config-dir=/etc/consul.d > /var/log/consul/consul.log 2>&1 &
sleep 3
nomad agent -config=/etc/nomad.d/nomad.hcl > /var/log/nomad/nomad.log 2>&1 &

service dnsmasq start

exec /usr/sbin/sshd -D
