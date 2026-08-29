FROM debian:bookworm-slim

ARG SSH_USER=acumen

RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server sudo iproute2 iputils-ping dnsutils curl gnupg lsb-release dnsmasq && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends consul nomad && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    ssh-keygen -A && \
    useradd -m -s /bin/bash ${SSH_USER} && \
    usermod -aG sudo ${SSH_USER} && \
    sed -i 's/#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    mkdir -p /home/${SSH_USER}/.ssh && chmod 700 /home/${SSH_USER}/.ssh

COPY conf/consul.hcl /etc/consul.d/consul.hcl
COPY conf/nomad.hcl /etc/nomad.d/nomad.hcl
COPY conf/dnsmasq.conf /etc/dnsmasq.conf
COPY conf/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22
CMD ["/entrypoint.sh"]
