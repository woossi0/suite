#!/bin/bash

d=`dirname $0`
source ${d}/pg_config.sh

# Read the pg port from the ini file or set 
# up the defaults
pg_check_ini

bin=$(pg_check_bin)
if [ "$bin" != "good" ]; then
  echo "Cannot find PgSQL component: $bin"
  exit 1
fi

# We want to run all these as postgres superuser
export PGUSER=postgres
export PGPORT=$pg_port

"$pg_bin_dir/createdb" template_postgis >> "$pg_log"
rv=$?
if [ $rv -gt 0 ]; then
  echo "Create database failed with return value $rv"
  exit 1
fi

"$pg_bin_dir/psql" -d template_postgis -c "CREATE EXTENSION postgis" >> "$pg_log"
rv=$?
if [ $rv -gt 0 ]; then
  echo "PostGIS Extension Creation failed with return value $rv"
  exit 1
fi

"$pg_bin_dir/psql" -d template_postgis -c "update pg_database set datistemplate = true where datname = 'template_postgis'" >> "$pg_log"
rv=$?
if [ $rv -gt 0 ]; then
  echo "Set template database flag failed with return value $rv"
  exit 1
fi

exit 0

