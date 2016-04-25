#!/bin/bash

function check_error {
    if [ "$1" != 0 ]; then
        exit $result
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
    check_error
}

function aptget_update {
    apt-get update
    if [ "$?" != 0 ]; then
        sleep 1s
        apt-get update
        if [ "$?" != 0 ]; then
            sleep 1s
            apt-get update
        fi
    fi
    check_error
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
    check_error
}

function clientdata_init {
    mkdir shared
    cd ..
    ln -s clientdata client-data
    check_error
}
