#!/bin/bash

source ./.tools/init.sh

clientdata_init

aptget_update
aptget_install git-core zip gcc zlib1g-dev ca-certificates libxml2-utils python python-pyvorbis python-ogg python-pil
rm -rf tools
gitclone https://gitlab.com/evol evol-tools.git tools

cd tools/testxml

./xsdcheck.sh
check_error $?
export RES=$(cat errors.txt)
if [[ -n "${RES}" ]]; then
    echo "xml check failed" >../../client-data/shared/error.log
    echo ${RES} >>../../client-data/shared/error.log
    cat ../../client-data/shared/error.log
    exit 1
fi

echo >../../client-data/shared/error.log
./testxml.py silent >../../client-data/shared/error.log
res="$?"
cat ../../client-data/shared/error.log
if [ "$res" != 0 ]; then
    echo "test xml error"
    exit 1
fi

echo >../../client-data/shared/error.log
