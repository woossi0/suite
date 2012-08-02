#!/bin/bash

. functions

build_info

VERSION=1.16.0-beta3
PGADMIN=pgadmin3-$VERSION
PGADMIN_POSTGIS=opengeosuite-$REV-pgadmin-postgis.zip

# grab files
get_file ftp://ftp.postgresql.org/pub/pgadmin3/release/v$VERSION/src/$PGADMIN.tar.gz
get_file $BUILDS/$DIST_PATH/$REV/$PGADMIN_POSTGIS

# unpack files
unzip files/$PGADMIN_POSTGIS -d pgadmin3/debian

# clean out old sources
pushd pgadmin3
ls | grep -v debian | xargs rm -rf
popd

# unpack sources
rm -rf $PGADMIN
tar xzvf files/$PGADMIN.tar.gz
mv $PGADMIN/* pgadmin3
checkrc $? "unpacking pgadmin sources"
rmdir $PGADMIN 

# build
build_deb pgadmin3

# publish
publish_deb pgadmin3
