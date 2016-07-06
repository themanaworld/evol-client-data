#!/bin/bash

source ./.tools/init.sh

clientdata_init

aptget_update
aptget_install git-core gcc ca-certificates grep
rm -rf tools
gitclone https://gitlab.com/evol evol-tools.git tools

cd tools/licensecheck

./clientdata.sh >license.log
check_error $?

export RES=$(cat license.log)
if [[ -n "${RES}" ]]; then
    echo "Detected missing licesnes"
    cat license.log
    exit 1
fi
