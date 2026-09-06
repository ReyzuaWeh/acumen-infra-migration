#!/usr/bin/env bash
set -e

chown acumen:acumen /home/acumen/.ssh
chmod 700 /home/acumen/.ssh
chmod 600 /home/acumen/.ssh/authorized_keys 2>/dev/null || true

/usr/sbin/rsyslogd

exec /usr/sbin/sshd -D