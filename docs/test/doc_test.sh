#!/usr/bin/env bash

set -e 

doc_dirs="geoexplorer geoserver geowebcache install sdk-api usermanual"
bad_modules=""
cd docs

for doc_dir in ${doc_dirs}
do
  echo "================ ${doc_dir} ============================="
  result=0

  # check status
  if ! test/status_check.sh ${doc_dir}
  then
    result=1
  fi

  # check links
  if ! test/link_check.sh ${doc_dir}
  then
    result=1
  fi

  # better reporting results when individually compiling modules
  if ! mvn clean compile -Ptest -projects ${doc_dir} --quiet
  then
    result=1
  fi

  if [ $result -eq 1 ] 
  then  
    bad_docs="${bad_docs} ${doc_dir}"
  fi
  
  echo
  echo
done

if [ -n "${bad_docs}" ]
then
  echo "ERRORS FOUND IN FOLLOWING DOCUMENTATION: "
  for bad_doc in ${bad_docs}
  do
    echo "... ${bad_doc}"
  done
  exit 1
else
  exit 0
fi

