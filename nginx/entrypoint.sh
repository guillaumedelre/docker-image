#!/bin/bash

set -e

echo "hydrating dev hosts"
cat /tmp/hosts >> /etc/hosts

echo "hydrating root bashrc"
cat /tmp/.bashrc >> /root/.bashrc

echo "enabling sites"
ln -s /etc/nginx/sites-available/documentation.vhost /etc/nginx/sites-enabled/documentation.vhost
ln -s /etc/nginx/sites-available/rabbitmq.vhost /etc/nginx/sites-enabled/rabbitmq.vhost
ln -s /etc/nginx/sites-available/static.vhost /etc/nginx/sites-enabled/static.vhost
ln -s /etc/nginx/sites-available/supervisor.vhost /etc/nginx/sites-enabled/supervisor.vhost
ln -s /etc/nginx/sites-available/gateway-wetest.vhost /etc/nginx/sites-enabled/gateway-wetest.vhost
ln -s /etc/nginx/sites-available/wetest-webapp.vhost /etc/nginx/sites-enabled/wetest-webapp.vhost

echo "starting nginx"
#/usr/sbin/service nginx start
#/usr/sbin/nginx
/usr/sbin/nginx -c /etc/nginx/nginx.conf -g "daemon off; master_process on;"
/usr/sbin/service nginx status
echo "nginx start: ($?)"

# EOF
