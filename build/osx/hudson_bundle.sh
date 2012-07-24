#!/bin/bash

# Script directory
d=`dirname $0`

# Load versions
source ${d}/hudson_config.sh

function usage() {
  echo "Usage: $0 <destdir>"
  exit 1
}

# Check for one argument
if [ $# -lt 1 ]; then
  usage
fi

workdir=`pwd`

if [ "x$1" = "x" ]; then
  destdir=$webroot
else
  destdir=$1
fi

# Enter source directory
#if [ ! -d $srcdir ]; then
#  exit 1
#else
#  pushd $srcdir
#fi

# Check for the existence of the GTK environment
if [ ! -d $HOME/gtk ]; then
  echo "Missing GTK install."
  exit 1
fi
if [ ! -d $HOME/.local ]; then
  echo "Missing jhbuild install."
  exit 1
fi

# Check that we have a mostly-built pgsql in the buildroot...
if [ ! -d ${buildroot}/pgsql ]; then
  echo "Missing pgsql buildroot! ${buildroot}/pgsql"
  exit 1
fi

# Set up paths necessary to build
export PATH=${buildroot}/pgsql/bin:${HOME}/gtk/inst/bin:${HOME}/.local/bin:${PATH}
export DYLD_LIBRARY_PATH=${buildroot}/pgsql/lib

# Copy the latest libpq libraries into a place the
# bundler can find them...
cp -f ${buildroot}/pgsql/lib/libpq.*.dylib ${HOME}/gtk/inst/lib

# Bundle the pgShapeLoader.app
pushd shp2pgsql-ige-mac-bundle
echo buildroot = $buildroot
export buildroot
jhbuild run ige-mac-bundler ShapeLoader.bundle
# Copy the missing and libraries into place
cp -f ../files/postgis/loader/.libs/shp2pgsql-gui ${buildroot}/pgsql/pgShapeLoader.app/Contents/MacOS/pgShapeLoader-bin
cp -f ${buildroot}/pgsql/lib/liblwgeom-2.0.1.dylib ${buildroot}/pgsql/pgShapeLoader.app/Contents/Resources/lib/
cp -f ${buildroot}/pgsql/lib/libgeos_c.1.dylib ${buildroot}/pgsql/pgShapeLoader.app/Contents/Resources/lib/
cp -f ${buildroot}/pgsql/lib/libgeos-3.3.3.dylib ${buildroot}/pgsql/pgShapeLoader.app/Contents/Resources/lib/
cp -f ${buildroot}/pgsql/lib/libproj.0.dylib ${buildroot}/pgsql/pgShapeLoader.app/Contents/Resources/lib/
cp -f ${buildroot}/pgsql/lib/libz.1.2.6.dylib ${buildroot}/pgsql/pgShapeLoader.app/Contents/Resources/lib/
cp -f ${HOME}/gtk/source/ige-mac-integration-0.8.6/src/.libs/libigemacintegration.0.dylib ${buildroot}/pgsql/pgShapeLoader.app/Contents/Resources/lib/
checkrv $? "Bundle pgshapeloader"
popd

# Zip up the results 
pushd ${buildroot}
if [ -f ${workdir}/postgis-osx.zip ]; then
  rm -f ${workdir}/postgis-osx.zip
fi
zip -r9 ${workdir}/postgis-osx.zip pgsql
checkrv $? "Bundle zip"
echo "Wrote postgis-osx.zip to $workdir"
popd

# Move the results to the web directory
mv -fv ${workdir}/postgis-osx.zip ${destdir}
checkrv $? "Move zip to web"

# Exit cleanly
exit 0
