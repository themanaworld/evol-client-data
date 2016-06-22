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
    echo "xml check failed" >../../clientdata/shared/error.log
    echo ${RES} >>../../clientdata/shared/error.log
    cat ../../clientdata/shared/error.log
    exit 1
fi

echo >../../clientdata/shared/error.log
./testxml.py silent >../../clientdata/shared/error.log
if [ "$?" != 0 ]; then
    echo "test xml error"
    cat ../../clientdata/shared/error.log
    exit 1
fi

echo >../../clientdata/shared/error.log
