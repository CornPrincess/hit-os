#!/bin/bash

function install_gcc34() {
    if [ -z "$(which gcc-3.4)" ]
    then
        mkdir gcc-3.4-build   
        tar -zxvf gcc-3.4-ubuntu.tar.gz -C gcc-3.4-build
        cd ./gcc-3.4-build/gcc-3.4 || echo "cd gcc-3.4-build failed"; eixt
        sudo ./inst.sh amd64
        echo "gcc-3.4 install success."
    else
        echo "gcc-3.4 has exited"
    fi
}

function install_dep_i386() {    
    echo "Install x86(i386) dependencies for x86_64(amd64) arch now"
    # Install bin86
    echo "* Install bin86 that includes as86 and ld86 for compiling and linking bootsect.s and setup.s"
    sudo apt-get install bin86
    echo "Done"
    echo

    # Install 32bit libs
    echo "* Install 32bit libs"
    sudo apt-get install libc6-dev-i386
    echo "Done"
    echo

    # Install compilation environment for C
    echo "* Install compilation environment for C"
    sudo apt-get install build-essential
    echo "Done"
    echo

    # Install libSM:i386 for bochs
    echo "* Install libSM:i386 for bochs"
    sudo apt-get install libsm6:i386
    echo "Done"
    echo

    # Install libX11-6:i386 for bochs
    echo "* Install libX11-6:i386 for bochs"
    sudo apt-get install libx11-6:i386
    echo "Done"
    echo

    # Install libxpm4:i386 for bochs
    echo "* Install libxpm4:i386 for bochs"
    sudo apt-get install libxpm4:i386
    echo "Done"
    echo "Install x86(i386) dependencies for x86_64(amd64) arch success"
    echo

    # Install lib32ncurses5 for rungdb
    echo "* Install lib32ncurses5 for rungdb"
    sudo apt-get install lib32ncurses5
    echo "Done"
    echo "Install x86(i386) dependencies for x86_64(amd64) arch success"
    echo

    # Install libexpat:i386 for rungdb
    echo "* Install libexpat:i386 for rungdb"
    sudo apt-get install libexpat-dev:i386
    echo "Done"
    echo "Install x86(i386) dependencies for x86_64(amd64) arch success"
    echo

}

# Main Code
DIR_PATH=$(cd "$(dirname $0)"; pwd)
WORK_DIR=$(dirname "${DIR_PATH}")/oslab

# 1.Create Work Directory
echo "================= 1.Create work directory ================="
if [ -d "$WORK_DIR" ] 
then
    echo "Work directory " "$WORK_DIR" " has existed."
else
    mkdir -p "$WORK_DIR"
    echo "Create work directory " "$WORK_DIR" " success"
fi
echo

# 2.Extract linux-0.11 and bochs and hdc image
echo "================= 2.Extract linux-0.11 and bochs and hdc image ================="
tar -zxvf hit-oslab-linux-20220419.tar.gz  -C "$WORK_DIR"
echo "Extract success"
echo


echo "================= 3.Update apt source ================="
if [ "$1" ] && ([ "$1" = "-s" ] || [ "$1" = "--skip-update" ]) 
then
    echo "Skip update apt source"
else
    echo "Start to update apt source"
    sudo apt-get update
    echo "Update apt sources success"
fi
echo


# Extract and Install gcc-3.4
echo "================= 4.Install gcc-3.4 ================="
install_gcc34
echo

# Install x86(i386) dependencies for x86_64(amd64) arch
echo "================= 5.Install x86(i386) dependencies for x86_64(amd64) arch ================="
install_dep_i386
echo

echo "Setup lab environment success."
