#!/bin/bash

set -e

echo "hydrating dev hosts"
cat /tmp/hosts >> /etc/hosts

echo "hydrating root bashrc"
cat /tmp/.bashrc >> /root/.bashrc

echo "enabling sites"
ln -s /etc/nginx/sites-available/webapp.wetest.local.io.vhost /etc/nginx/sites-enabled/webapp.wetest.local.io.vhost
ln -s /etc/nginx/sites-available/documentation.wetest.local.io.vhost /etc/nginx/sites-enabled/documentation.wetest.local.io.vhost

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
