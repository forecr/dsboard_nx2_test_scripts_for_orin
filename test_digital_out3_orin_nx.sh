#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sleep_time=1

sudo echo 315 > /sys/class/gpio/export
sudo echo out > /sys/class/gpio/gpio315/direction

echo "step: 1/4"
echo "DIGITAL_OUT0 ON"
sudo echo 1 > /sys/class/gpio/gpio315/value
sleep $sleep_time

echo "step: 2/4"
echo "DIGITAL_OUT0 OFF"
sudo echo 0 > /sys/class/gpio/gpio315/value
sleep $sleep_time

echo "step: 3/4"
echo "DIGITAL_OUT0 ON"
sudo echo 1 > /sys/class/gpio/gpio315/value
sleep $sleep_time

echo "step: 4/4"
echo "DIGITAL_OUT0 OFF"
sudo echo 0 > /sys/class/gpio/gpio315/value

sudo echo 315 > /sys/class/gpio/unexport

