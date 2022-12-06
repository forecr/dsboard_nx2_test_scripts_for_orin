#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

board_rev_1_2=$1

sudo echo 389 > /sys/class/gpio/export 
sudo echo 492 > /sys/class/gpio/export 
sudo echo out > /sys/class/gpio/PG.06/direction 
sudo echo out > /sys/class/gpio/PAC.06/direction 
if $board_rev_1_2; then
	sudo echo 1 > /sys/class/gpio/PG.06/value 
else
	sudo echo 0 > /sys/class/gpio/PG.06/value 
fi
sudo echo 0 > /sys/class/gpio/PAC.06/value

sudo gtkterm -p /dev/ttyTHS0 -s 115200

sudo echo 389 > /sys/class/gpio/unexport
sudo echo 492 > /sys/class/gpio/unexport

