FROM basessh
MAINTAINER Dave P

# Bind setup script
COPY regen-bind-key /start.d/regen-bind-key 

# Supervisor script
COPY bind.conf /etc/supervisor/conf.d/bind.conf

# Install software
RUN apt-get update ; \
    apt-get install -y bind9 dnsutils ; \
    rm /etc/bind/rndc.key ; \
    chmod +x /start.d/regen-bind-key

# DNS port
EXPOSE 53/udp

