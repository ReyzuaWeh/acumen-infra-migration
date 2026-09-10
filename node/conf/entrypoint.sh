#!/usr/bin/env bash
set -e

chown acumen:acumen /home/acumen/.ssh
chmod 700 /home/acumen/.ssh

mkdir -p /var/log/consul /var/log/nomad

sed -i "s/NODE_NAME_PLACEHOLDER/${NODE_NAME}/" \
    /etc/consul.d/consul.hcl

sed -i "s/NODE_IP_PLACEHOLDER/${NODE_IP}/g" \
    /etc/consul.d/consul.hcl

sed -i "s/NODE_IP_PLACEHOLDER/${NODE_IP}/g" \
    /etc/nomad.d/nomad.hcl


echo "Starting Docker..."
dockerd --storage-driver=vfs \
    > /var/log/dockerd.log 2>&1 &

echo "Waiting for Docker..."
until docker info >/dev/null 2>&1; do
    sleep 1
done

echo "Docker ready."

echo "Starting Consul..."
consul agent \
    -config-dir=/etc/consul.d \
    > /var/log/consul/consul.log 2>&1 &

sleep 3

echo "Starting Nomad..."
nomad agent \
    -config=/etc/nomad.d/nomad.hcl \
    > /var/log/nomad/nomad.log 2>&1 &

echo "Starting dnsmasq..."
service dnsmasq start
echo "nameserver 127.0.0.1" > /etc/resolv.conf

echo "Starting SSH..."
exec /usr/sbin/sshd -D -e