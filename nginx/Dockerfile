FROM ubuntu:xenial

USER root

# install packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
    gnupg-curl \
    software-properties-common \
    net-tools \
    iputils-ping \
    iputils-tracepath \
    iotop \
    iptraf \
    httpie \
    tree \
    vim
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
    nginx \
    nginx-extras \
    luajit \
    libluajit-5.1-2 \
    libluajit-5.1-common \
    libperl5.22 \
    lua-cjson \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# hosts
COPY ./etc/hosts /tmp/hosts

# bash
COPY ./root/ /tmp/root/

# lua
COPY ./usr+local+share+lua+5.1/ /usr/local/share/lua/5.1/

# parameters
#COPY ./var+opt+symfony/ /var/opt/symfony/

# nginx
COPY ./etc+nginx/nginx.conf /etc/nginx/nginx.conf
RUN rm -f /etc/nginx/sites-available/default
RUN rm -f /etc/nginx/sites-enabled/default
#RUN /etc/init.d/nginx start

# sites-available
COPY ./etc+nginx/sites-available/ /etc/nginx/sites-available/

VOLUME ["/var/log/nginx"]
EXPOSE 80
EXPOSE 443

# entrypoint
COPY ./entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh
ENTRYPOINT ["/sbin/entrypoint.sh"]

