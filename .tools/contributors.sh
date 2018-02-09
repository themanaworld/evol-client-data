#!/bin/bash

echo "[FIXME][TODO] Our project is not using contributors check."
echo "[FIXME][TODO] This is an important error. We must auto-check licenses!"
exit 0

source ./.tools/init.sh

clientdata_init

aptget_update
aptget_install git-core gcc ca-certificates libxml2-utils make xsltproc
rm -rf tools
gitclone https://gitlab.com/TMW2 evol-tools.git tools

cd tools/contrib_xsl

make about-server
check_error $?

cd ../../clientdata

export RES=$(git diff)
if [[ -n "${RES}" ]]; then
    echo "Contributors list not updated"
    git diff
    exit 1
fi
