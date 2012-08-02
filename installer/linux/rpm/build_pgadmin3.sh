#!/bin/bash

. functions

build_info

VER=1.16.0beta3
PGADMIN=pgadmin3-$VER
PGADMIN_POSTGIS=opengeosuite-$REV-pgadmin-postgis.zip

# grab files
# NOTE rpm cannot have a - in a version. Move back to regular source bundles once 1.16 leaves beta
#get_file ftp://ftp.postgresql.org/pub/pgadmin3/release/v$VER/src/$PGADMIN.tar.gz
get_file http://data.opengeo.org/suite/$PGADMIN.tar.gz
get_file $BUILDS/$DIST_PATH/$REV/$PGADMIN_POSTGIS

cp files/$PGADMIN.tar.gz $RPM_SOURCE_DIR
unzip -o files/$PGADMIN_POSTGIS -d $RPM_BUILD_DIR

# build
build_rpm yes

# publish
publish_rpm

