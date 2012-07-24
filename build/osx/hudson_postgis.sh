#!/bin/bash

# Script directory
d=`dirname $0`

# Find script directory
pushd ${d}
p=`pwd`
popd

# Load versions
source ${d}/hudson_config.sh

srcdir=files/postgis

# Get the PostGIS source
get_file $postgis_url

# Clean up anything from a previous build and extract the sources into place
pushd files
rm -rf postgis
tar zxvf postgis-${postgis_version}.tar.gz
mv postgis-${postgis_version} postgis
popd

if [ ! -d $srcdir ]; then
  echo "Source directory is missing."
  exit 1
else
  pushd $srcdir
fi

# Download the EDB binaries if necessary
if [ ! -f ${buildroot}/${edb_zip} ]; then
  curl ${edb_url} > ${buildroot}/${edb_zip}
fi
# Clean up and unzip the EDB directory
if [ -d ${buildroot}/pgsql ]; then
  rm -rf ${buildroot}/pgsql
fi
unzip ${buildroot}/${edb_zip} -d ${buildroot}

# Patch PGXS
pushd ${buildroot}/pgsql/lib/postgresql/pgxs/src
patch -p0 < ${p}/pgxs.patch
checkrv $? "PostGIS makefile patch"
popd

# We need to patch the liblwgeom Makefile to use our ARCHFLAGS
# so we can build a fat binary. Bug in PostGIS build system stops
# LDFLAGS from being passed through.
pushd ${p}/files/postgis/liblwgeom/
patch -p0 < ${p}/liblwgeom.patch
checkrv $? "liblwgeom makefile patch"
popd

# Copy the Proj libraries into the pgsql build directory
if [ -d ${buildroot}/proj ]; then
  cp -rf ${buildroot}/proj/* ${buildroot}/pgsql
else
  echo "Cannot find proj files."
  exit 1
fi

# Copy the GEOS libraries into the pgsql build directory
if [ -d ${buildroot}/geos ]; then
  cp -rf ${buildroot}/geos/* ${buildroot}/pgsql
else
  echo "Cannot find GEOS files."
  exit 1
fi

# Copy the GDAL libraries into the pgsql build directory                        
if [ -d ${buildroot}/gdal/ ]; then
  cp -rf ${buildroot}/gdal/* ${buildroot}/pgsql
else
  echo "Cannot find GDAL files."
  exit 1
fi

# Check for the existence of the GTK environment
if [ ! -d $HOME/gtk ]; then
  echo "Cannot find GTK files."
  exit 1
fi
if [ ! -d $HOME/.local ]; then
  echo "Cannot find JH build support."
  exit 1
fi

# Set up paths necessary to build
export PATH=${buildroot}/pgsql/bin:${HOME}/gtk/inst/bin:${HOME}/.local/bin:${PATH}
export DYLD_LIBRARY_PATH=${buildroot}/pgsql/lib

# Configure PostGIS
./autogen.sh
export CC=gcc-4.2
export CFLAGS="-O2 -arch i386 -arch x86_64 -mmacosx-version-min=10.5"
export CXX=g++-4.2
export CXXFLAGS="-O2 -arch i386 -arch x86_64 -mmacosx-version-min=10.5"
./configure \
  --prefix=${buildroot}/pgsql/ \
  --with-pgconfig=${buildroot}/pgsql/bin/pg_config \
  --with-geosconfig=${buildroot}/pgsql/bin/geos-config \
  --with-projdir=${buildroot}/pgsql \
  --with-xml2config=/usr/bin/xml2-config \
  --with-gdalconfig=${buildroot}/pgsql/bin/gdal-config
checkrv $? "PostGIS configure"

# Build PostGIS
make clean && make && make install
checkrv $? "PostGIS build"

# Re-Configure without ppc arch so we can link to GTK
export CFLAGS="-O2 -arch i386 -mmacosx-version-min=10.4"
export CXXFLAGS="-O2 -arch i386 -mmacosx-version-min=10.4"

# Re-configure with GTK on the path
jhbuild run \ 
./configure \
  --prefix=${buildroot}/pgsql/ \
  --with-pgconfig=${buildroot}/pgsql/bin/pg_config \
  --with-geosconfig=${buildroot}/pgsql/bin/geos-config \
  --with-projdir=${buildroot}/pgsql \
  --with-xml2config=/usr/bin/xml2-config \
  --with-gdalconfig=${buildroot}/pgsql/bin/gdal-config \
  --with-gui
checkrv $? "PostGIS configure GUI"

pushd liblwgeom
jhbuild run make clean all
checkrv $? "PostGIS build GUI liblwgeom"
popd
pushd loader
jhbuild run make clean all
checkrv $? "PostGIS build GUI loader"
cp -f shp2pgsql-gui ${buildroot}/pgsql/bin
popd

# Exit cleanly
exit 0
    
