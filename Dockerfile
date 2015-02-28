FROM basessh
MAINTAINER Dave P

# Bind setup script
COPY regen-bind-key /start.d/regen-bind-key 

# Supervisor script
COPY bind.conf /etc/supervisor/conf.d/bind.conf

# Install bind and dns utils
RUN apt-get update ; \
    apt-get install -y bind9 dnsutils ; \
    rm /etc/bind/rndc.key ; \
    chmod +x /start.d/regen-bind-key ; \
    mkdir /var/run/named ; \
    chown bind /var/run/named ; \
    chgrp bind /var/run/named ; \
    touch /var/log/named.log ; \
    chgrp bind /var/log/named.log ; \
    chmod 775 /var/log/named.log ; \
    sed -i -e's/include "\/etc\/bind\/named.conf.options";/logging{\n\tchannel simple_log {\n\t\tfile "\/var\/log\/named.log" versions 3 size 5m;\n\t\tseverity info;\n\t\tprint-time yes;\n\t\tprint-severity yes;\n\t\tprint-category yes;\n\t};\n\tcategory default{\n\t\tsimple_log;\n\t};\n};\ninclude "\/etc\/bind\/named.conf.options";/' /etc/bind/named.conf
    # edit named.conf to use the above log file

# DNS port
EXPOSE 53/udp

