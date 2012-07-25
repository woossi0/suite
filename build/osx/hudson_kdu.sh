#!/bin/bash

# Script directory
d=`dirname $0`

# Load versions
source ${d}/hudson_config.sh

function usage() {
  echo "Usage: $0 <destdir>"
  exit 1
}

if [ $# -lt 1 ]; then
  usage
fi

srcdir=$PWD/files/kdu

if [ "x$1" = "x" ]; then
  destdir=$buildroot
else
  destdir=$1
fi

# Get the KDU source
cp -v $buildroot/v${kdu_version}.zip files/.

# Clean up anything from a previous build and extract the sources into place
pushd files
rm -rf kdu
unzip v${kdu_version}.zip
mv v${kdu_version} kdu
cp ../Makefile-KDU-OSX-FAT ./kdu/coresys/Makefile
popd
 
if [ ! -d $srcdir ]; then
  echo "Source directory is missing."
  exit 1
else 
  pushd $srcdir
fi

rm -rf ${buildroot}/kdu
mkdir -p ${buildroot}/kdu/lib
mkdir -p ${buildroot}/kdu/include

export CXX=g++-4.2
export CC=gcc-4.2
export buildroot
pushd coresys
make
# Copy the headers into place
find . -name "*.h" -exec cp {} ${buildroot}/kdu/include/. \;
popd
checkrv $? "KDU build"

pushd ${buildroot}/kdu
popd

popd

exit 0
    
