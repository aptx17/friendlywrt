#!/bin/bash

BOARD=$1
if [ ! -e "config_${BOARD}.seed" ];then
	echo "$0 [nanopi-h3|nanopi-h5|nanopi-h6]"
	exit 1
fi

CPU_CORES=`cat /proc/cpuinfo | grep "processor" | wc -l`
VER=18.06.1

cd ..
./scripts/feeds update -a
./scripts/feeds install -a

cp friendlyelec/config_${BOARD}.seed .config
make defconfig

if [ ! -d dl ]; then
	echo "dl directory not exist. Will make download full package from openwrt site."
fi
make download -j${CPU_CORES}
make -j${CPU_CORES}

