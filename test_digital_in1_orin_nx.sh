#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sudo echo 309 > /sys/class/gpio/export
sudo echo in > /sys/class/gpio/gpio309/direction

watch -n 0.1 sudo cat /sys/class/gpio/gpio309/value

sudo echo 309 > /sys/class/gpio/unexport
