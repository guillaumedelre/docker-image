#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    DROP ROLE IF EXISTS dev;
    CREATE ROLE dev;
    ALTER ROLE dev WITH SUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'dev';
    -- wetest-webapp
    CREATE DATABASE "wetest-webapp" WITH TEMPLATE = template0 OWNER = postgres;
    REVOKE ALL ON DATABASE "wetest-webapp" FROM PUBLIC;
    REVOKE ALL ON DATABASE "wetest-webapp" FROM postgres;
    GRANT ALL ON DATABASE "wetest-webapp" TO postgres;
    GRANT CONNECT,TEMPORARY ON DATABASE "wetest-webapp" TO PUBLIC;
    GRANT ALL ON DATABASE "wetest-webapp" TO dev;
    -- wetest-webapp_test
    CREATE DATABASE "wetest-webapp_test" WITH TEMPLATE = template0 OWNER = postgres;
    REVOKE ALL ON DATABASE "wetest-webapp_test" FROM PUBLIC;
    REVOKE ALL ON DATABASE "wetest-webapp_test" FROM postgres;
    GRANT ALL ON DATABASE "wetest-webapp_test" TO postgres;
    GRANT CONNECT,TEMPORARY ON DATABASE "wetest-webapp_test" TO PUBLIC;
    GRANT ALL ON DATABASE "wetest-webapp_test" TO dev;

EOSQL

# EOF
