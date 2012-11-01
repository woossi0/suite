#!/usr/bin/env bash

set -e 

doc_dirs="geoexplorer geoserver geowebcache install sdk-api usermanual"
bad_modules=""
cd docs

for doc_dir in ${doc_dirs}
do
  echo "=== ${doc_dir} ============================================="
  result=0

  echo "+++ document status"
  if ! test/status_check.sh ${doc_dir}
  then
    result=1
  fi

  echo "+++ link check"
  if ! test/link_check.sh ${doc_dir}
  then
    result=1
  fi

  # better reporting results when individually compiling modules
  # capture mvn error code then grep for ERROR and WARNING to report
  echo "+++ sphinx warnings"
  tmp=$(mktemp)
  if ! mvn clean compile -Ptest -projects ${doc_dir} --quiet > ${tmp}
  then
    result=1
    grep -E "(WARNING|ERROR)" ${tmp} | grep -v "BUILD ERROR"
  fi
  rm ${tmp}

  if [ $result -eq 1 ] 
  then  
    bad_docs="${bad_docs} ${doc_dir}"
  fi
  
  echo
  echo
done

if [ -n "${bad_docs}" ]
then
  echo "ERRORS FOUND IN FOLLOWING MODULES: "
  for bad_doc in ${bad_docs}
  do
    echo "... ${bad_doc}"
  done
  exit 1
else
  exit 0
fi

