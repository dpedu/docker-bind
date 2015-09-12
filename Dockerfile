FROM ubuntu:trusty
MAINTAINER Dave P

ADD start /start

# Install bind and dns utils
RUN chmod +x /start ; \
    apt-get update ; \
    apt-get install -y supervisor bind9 dnsutils ; \
    rm /etc/bind/rndc.key ; \
    mkdir /var/run/named ; \
    chown bind /var/run/named ; \
    chgrp bind /var/run/named ; \
    touch /var/log/named.log ; \
    chgrp bind /var/log/named.log ; \
    chmod 775 /var/log/named.log ; \
    mkdir /start.d ; \
    rm -rf /var/lib/apt/lists/*

# Supervisor script
ADD bind.conf /etc/supervisor/conf.d/bind.conf
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf

# Bind setup script
ADD regen-bind-key /start.d/regen-bind-key

# DNS port
EXPOSE 53/udp

ENTRYPOINT ["/start"]