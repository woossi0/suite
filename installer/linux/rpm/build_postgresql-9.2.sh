#!/bin/bash

. functions

build_info

POSTGRESQL=postgresql-9.2beta2
VER_DIR=9.2.0beta2

# grab files
get_file http://ftp.postgresql.org/pub/source/v$VER_DIR/$POSTGRESQL.tar.gz
cp files/$POSTGRESQL.tar.gz $RPM_SOURCE_DIR

# build
build_rpm yes

# publish
publish_rpm

