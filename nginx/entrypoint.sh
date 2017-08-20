#!/bin/bash

set -e

echo "hydrating dev hosts"
cat /tmp/hosts >> /etc/hosts

echo "hydrating root bash*"
cat /tmp/root/.bashrc >> /root/.bashrc
cat /tmp/root/.bash_profile >> /root/.bash_profile

echo "enabling sites"
ln -s /etc/nginx/sites-available/wetest.webapp.local.io.vhost /etc/nginx/sites-enabled/wetest.webapp.local.io.vhost
ln -s /etc/nginx/sites-available/wetest.documentation.local.io.vhost /etc/nginx/sites-enabled/wetest.documentation.local.io.vhost

ln -s /etc/nginx/sites-available/gdelre.gallery.local.io.vhost /etc/nginx/sites-enabled/gdelre.gallery.local.io.vhost

ln -s /etc/nginx/sites-available/gateway.local.io.vhost /etc/nginx/sites-enabled/gateway.local.io.vhost
ln -s /etc/nginx/sites-available/static.local.io.vhost /etc/nginx/sites-enabled/static.local.io.vhost
ln -s /etc/nginx/sites-available/rabbitmq.local.io.vhost /etc/nginx/sites-enabled/rabbitmq.local.io.vhost
ln -s /etc/nginx/sites-available/supervisor.local.io.vhost /etc/nginx/sites-enabled/supervisor.local.io.vhost

echo "starting nginx"
#/usr/sbin/service nginx start
#/usr/sbin/nginx
/usr/sbin/nginx -c /etc/nginx/nginx.conf -g "daemon off; master_process on;"
/usr/sbin/service nginx status
echo "nginx start: ($?)"

# EOF
