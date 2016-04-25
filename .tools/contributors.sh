#!/bin/bash

source ./.tools/init.sh

clientdata_init

aptget_update
aptget_install git-core gcc ca-certificates libxml2-utils make xsltproc
gitclone https://gitlab.com/evol/evol-tools.git tools

cd tools/contrib_xsl

pwd
make about-server
check_error $?

cd ../../clientdata
pwd
git diff

export RES=$(git diff)
if [[ -n "${RES}" ]]; then
    echo "Contributors list not updated"
    echo "Diff:"
    echo ${RES}
    exit 1
fi
