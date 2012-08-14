#!/bin/bash

. functions

build_info

DL_HOST=http://data.opengeo.org/suite/jai/

# grab files
get_file $DL_HOST/jai-1_1_3-lib-linux-amd64-jdk.bin
get_file $DL_HOST/jai-1_1_3-lib-linux-i586-jdk.bin
get_file $DL_HOST/jai_imageio-1_1-lib-linux-amd64-jdk.bin
get_file $DL_HOST/jai_imageio-1_1-lib-linux-i586-jdk.bin

# clean
clean_src

# unpack sources
unzip -o files/jai-1_1_3-lib-linux-amd64-jdk.bin -d ${PKG_SOURCE_DIR}
#checkrc $? "unpacking jai amd64"
unzip -o files/jai_imageio-1_1-lib-linux-amd64-jdk.bin -d ${PKG_SOURCE_DIR}
#checkrc $? "unpacking jai imageio amd64"
unzip -o files/jai-1_1_3-lib-linux-i586-jdk.bin -d ${PKG_SOURCE_DIR}
#checkrc $? "unpacking jai i586"
unzip -o files/jai_imageio-1_1-lib-linux-i586-jdk.bin -d ${PKG_SOURCE_DIR}
#checkrc $? "unpacking jai imageio i586"

# build 
build_rpm

# publish
publish_rpm

