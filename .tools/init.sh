#!/bin/bash

function check_error {
    if [ "$1" != 0 ]; then
        echo "Error $1"
        exit $1
    fi
}

function gitclone {
    git clone $*
    if [ "$?" != 0 ]; then
        sleep 1s
        git clone $*
        if [ "$?" != 0 ]; then
            sleep 3s
            git clone $*
        fi
    fi
    check_error $?
}

function update_repos {
    if [ "$CI_SERVER" == "" ];
    then
        return
    fi

    export DATA=$(cat /etc/resolv.conf|grep "nameserver 1.10.100.101")
    if [ "$DATA" != "" ];
    then
        echo "Detected local runner"
        sed -i 's!http://httpredir.debian.org/debian!http://1.10.100.103/debian!' /etc/apt/sources.list
    else
        echo "Detected non local runner"
    fi
}

function aptget_update {
    update_repos
    apt-get update
    if [ "$?" != 0 ]; then
        sleep 1s
        apt-get update
        if [ "$?" != 0 ]; then
            sleep 1s
            apt-get update
        fi
    fi
    check_error $?
}

function aptget_install {
    apt-get -y -qq install $*
    if [ "$?" != 0 ]; then
        sleep 1s
        apt-get -y -qq install $*
        if [ "$?" != 0 ]; then
            sleep 2s
            apt-get -y -qq install $*
        fi
    fi
    check_error $?
}

function clientdata_init {
    mkdir shared
    cd ..
    ln -s clientdata client-data
    check_error $?
}
