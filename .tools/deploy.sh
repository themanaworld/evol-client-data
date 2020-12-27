#!/bin/bash

source ./.tools/init.sh

clientdata_init

aptget_update
aptget_install git-core zip gcc zlib1g-dev ca-certificates libxml2-utils python
rm -rf tools
gitclone https://gitlab.com/evol evol-tools.git tools

cd clientdata
rm -rf public
mkdir public

cd ..

rm -rf music
gitclone https://gitlab.com/evol evol-music.git music

cd tools/update

./createnew.sh
check_error $?
./create_music.sh
check_error $?

cp -r upload/* ../../clientdata/public
cd ../../clientdata
gitclone https://gitlab.com/themanaworld/manaplus/ pagesindexgen.git pagesindexgen
cd pagesindexgen
./pagesindexgen.py ../public
check_error $?
ls ../public
