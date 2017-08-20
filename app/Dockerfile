FROM ubuntu:xenial

USER root

# install packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
    build-essential \
    gnupg-curl \
    software-properties-common \
    net-tools \
    iputils-ping \
    iputils-tracepath \
    iotop \
    iptraf \
    httpie \
    tree \
    jq \
    vim
RUN apt-key adv --fetch-keys https://packagecloud.io/gpg.key
RUN add-apt-repository "deb http://packages.blackfire.io/debian any main"
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
    php \
    php-fpm \
    php-curl \
    php-intl \
    php-mbstring \
    php-gd \
    php-json \
    php-mysql \
    php-pgsql \
    php-twig \
    php-xdebug \
    php-dev \
    php-gmp \
    php-amqp \
    php-apcu \
    php-redis \
    zip \
    unzip \
    git \
    blackfire-agent \
    blackfire-php \
    python2.7 \
    python2.7-dev \
    libffi-dev \
    libssl-dev \
    mkdocs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# non root user with shell
RUN useradd -m -p $(openssl passwd -1 "dev") -s /bin/bash -G sudo "dev"

# default fracking umask
COPY ./etc+pam.d /etc/pam.d

# bash
COPY ./root/ /tmp/root/
COPY ./home/dev/ /tmp/home/dev/

# hosts
COPY ./etc/hosts /tmp/hosts

# git cert to pull deps (npm)
COPY ./dev+ssh /home/dev/.ssh
RUN chown -R dev: /home/dev/.ssh
RUN chmod 600 /home/dev/.ssh/id_rsa

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN mkdir /home/dev/.composer
RUN chown -R dev: /home/dev/.composer
VOLUME ["/home/dev/.composer"]

# symfony installer
RUN mkdir -p /usr/local/bin
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
RUN chmod a+x /usr/local/bin/symfony

# fabric
RUN cd /tmp && curl -k -O https://bootstrap.pypa.io/get-pip.py && python get-pip.py \
    && pip install supervisor paramiko pyyaml semantic_version fabric pgcli mkdocs mkdocs-material pygments \
    && pip install --upgrade pygments

# nodejs
RUN NODE_VERSION="v6.9.2" ; NODE_PLATFORM="linux-x64" ; mkdir -p /opt/nodejs && cd /opt/nodejs \
    && echo "installing nodejs node-${NODE_VERSION}-${NODE_PLATFORM}" \
    && curl -k -O https://nodejs.org/download/release/${NODE_VERSION}/node-${NODE_VERSION}-${NODE_PLATFORM}.tar.gz \
    && tar -zxf node-${NODE_VERSION}-${NODE_PLATFORM}.tar.gz \
    && cd node-${NODE_VERSION}-${NODE_PLATFORM} \
    && ln -s /opt/nodejs/node-${NODE_VERSION}-${NODE_PLATFORM}/bin/node /usr/local/bin/node \
    && ln -s /opt/nodejs/node-${NODE_VERSION}-${NODE_PLATFORM}/bin/npm /usr/local/bin/npm \
    && echo -n "update npm old version: " \
    && ./bin/npm --version \
    && ./bin/npm install npm -g \
    && echo -n "updated npm to version: " \
    && ./bin/npm --version \
    && ./bin/npm install webpack -g \
    && ln -s /opt/nodejs/node-${NODE_VERSION}-${NODE_PLATFORM}/bin/webpack /usr/local/bin/webpack \
    && ./bin/npm install bower -g \
    && ln -s /opt/nodejs/node-${NODE_VERSION}-${NODE_PLATFORM}/bin/bower /usr/local/bin/bower

# applications parameters
#COPY ./var+opt+symfony/ /var/opt/symfony/

# php7.0-fpm
COPY ./etc+php+7.0/ /etc/php/7.0/
RUN /etc/init.d/php7.0-fpm start
VOLUME ["/var/log/php"]
EXPOSE 9000

# blackfire
COPY ./etc+blackfire/ /etc/blackfire/
RUN /etc/init.d/blackfire-agent start

# supervisor
COPY ./etc+supervisor/ /etc/supervisor/
VOLUME ["/var/log/supervisor"]
EXPOSE 9001

# entrypoint
COPY ./entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh
ENTRYPOINT ["/sbin/entrypoint.sh"]

