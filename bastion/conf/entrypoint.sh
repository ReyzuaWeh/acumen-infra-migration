#!/bin/bash
set -e

chown -R acumen:acumen /home/acumen/.ssh
chmod 700 /home/acumen/.ssh
chmod 600 /home/acumen/.ssh/authorized_keys 2>/dev/null || true

exec /usr/sbin/sshd -D
