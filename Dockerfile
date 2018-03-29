FROM ubuntu:16.04

ARG username=username
ARG password=password
ARG smtp_server=smtp_server
ARG site_host=site_host

ADD sources.list /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y curl supervisor software-properties-common python-software-properties && \
    add-apt-repository ppa:max-c-lv/shadowsocks-libev && apt-get update && \
    apt-get install -y shadowsocks-libev && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install -y nodejs

#RUN npm i -g shadowsocks-manager --unsafe-perm

ADD code /var/www/shadowsocks-manager

ADD config /etc/shadowsocks
ADD supervisor /etc/supervisor
ADD entry.sh .



CMD sed -i "s/\'username\'/\'$username\'/g" /var/www/shadowsocks-manager/config/webui.yml.example && sed -i "s/\'password\'/\'$password\'/g" /var/www/shadowsocks-manager/config/webui.yml.example && sed -i "s/\'smtp_server\'/\'$smtp_server'/g" /var/www/shadowsocks-manager/config/webui.yml.example && sed -i "s/\'site_host'/\'$site_host'/g" /var/www/shadowsocks-manager/config/webui.yml.example

ENTRYPOINT ["bash", "./entry.sh"]
