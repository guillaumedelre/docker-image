FROM postgres:9.6

# Debian image is mandatory because alpine doesn't have localedef
RUN localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8
ENV LANG fr_FR.utf8

# users and databases
COPY ./docker-entrypoint-initdb.d/init-db.sh   /docker-entrypoint-initdb.d/init-db.sh

VOLUME ["/var/log/postgresql", "/var/lib/postgresql/data"]

