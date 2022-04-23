#!/bin/bash
SH_PATH=$(cd "$(dirname $0)"; pwd)
OSLAB_PATH=$(dirname "${SH_PATH}")

if [ "$1" ] && [ "$1" = "-m" ]
then
	cd "$OSLAB_PATH"/linux-0.11
	make clean
	make all
	if [ !"$?" = "0" ]
	then
		echo "compile linux failed."
		exit
	fi
	echo "compile linux success"
	echo
fi

if [ "$2" ] && [ "$2" = "-c" ]
then
	cd "$OSLAB_PATH"
	sudo ./mount-hdc
	cp test/iam.c test/whoami.c hdc/usr/root
	cp testlab2.c testlab2.sh hdc/usr/root
	cp linux-0.11/include/unistd.h hdc/usr/include
	sudo umount hdc
	if [ !"$?" = "0" ]
	then
		echo "cp file failed."
		exit
	fi
	echo "cp file success"
	echo
fi


./run