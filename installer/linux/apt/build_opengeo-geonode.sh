#!/usr/bin/env bash

. functions

build_info

GEONODE=geonode-1.2

# grab files
git clone https://github.com/opengeo/geonode.git $GEONODE

# clean out old sources
pushd opengeo-geonode
ls | grep -v debian | xargs rm -rf
popd

# unpack sources
pushd $GEONODE
git checkout geoserver-2.2-configurable
git submodule init
git submodule update
popd
mv $GEONODE/* opengeo-geonode
checkrc $? "unpacking geonode sources"
rm -rf $GEONODE

# build
build_deb opengeo-geonode

# publish
publish_deb opengeo-geonode
