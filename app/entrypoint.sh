#!/bin/bash

set -e

echo "hydrating root bashrc"
cat /tmp/.bashrc >> /root/.bashrc

echo "hydrating dev bash_aliases"
cat /tmp/home/dev/.bash_aliases >> /home/dev/.bash_aliases
cat /tmp/home/dev/.bashrc >> /home/dev/.bashrc

echo "hydrating dev hosts"
cat /tmp/hosts >> /etc/hosts

echo "starting supervisor"
#/usr/sbin/service supervisor start
/usr/bin/python /usr/local/bin/supervisord -n -c /etc/supervisor/supervisord.conf
echo "supervisor start: ($?)"

#echo "starting php7-fpm"
##/usr/sbin/service php7.0-fpm start
#/usr/sbin/php-fpm7.0 --nodaemonize --fpm-config /etc/php/7.0/fpm/php-fpm.conf
#echo "php start: ($?)"

# EOF
