#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sleep_time=0.3

sudo echo 312 > /sys/class/gpio/export
sudo echo out > /sys/class/gpio/gpio312/direction
sudo echo 313 > /sys/class/gpio/export
sudo echo out > /sys/class/gpio/gpio313/direction
sudo echo 314 > /sys/class/gpio/export
sudo echo out > /sys/class/gpio/gpio314/direction

sleep $sleep_time

echo "DIGITAL_OUT0 OFF"
sudo echo 0 > /sys/class/gpio/gpio312/value
echo "DIGITAL_OUT1 OFF"
sudo echo 0 > /sys/class/gpio/gpio313/value
echo "DIGITAL_OUT2 OFF"
sudo echo 0 > /sys/class/gpio/gpio314/value

#Single Test
echo "step: 1/14"
echo "DIGITAL_OUT0 ON"
sudo echo 1 > /sys/class/gpio/gpio312/value
sleep $sleep_time

echo "step: 2/14"
echo "DIGITAL_OUT0 OFF"
sudo echo 0 > /sys/class/gpio/gpio312/value
sleep $sleep_time

echo "step: 3/14"
echo "DIGITAL_OUT1 ON"
sudo echo 1 > /sys/class/gpio/gpio313/value
sleep $sleep_time

echo "step: 4/14"
echo "DIGITAL_OUT1 OFF"
sudo echo 0 > /sys/class/gpio/gpio313/value
sleep $sleep_time

echo "step: 5/14"
echo "DIGITAL_OUT2 ON"
sudo echo 1 > /sys/class/gpio/gpio314/value
sleep $sleep_time

echo "step: 6/14"
echo "DIGITAL_OUT2 OFF"
sudo echo 0 > /sys/class/gpio/gpio314/value
sleep $sleep_time

#Double Test
echo "step: 7/14"
echo "DIGITAL_OUT0 ON"
echo "DIGITAL_OUT1 ON"
sudo echo 1 > /sys/class/gpio/gpio312/value
sudo echo 1 > /sys/class/gpio/gpio313/value
sleep $sleep_time

echo "step: 8/14"
echo "DIGITAL_OUT0 OFF"
echo "DIGITAL_OUT1 OFF"
sudo echo 0 > /sys/class/gpio/gpio312/value
sudo echo 0 > /sys/class/gpio/gpio313/value
sleep $sleep_time

echo "step: 9/14"
echo "DIGITAL_OUT1 ON"
echo "DIGITAL_OUT2 ON"
sudo echo 1 > /sys/class/gpio/gpio313/value
sudo echo 1 > /sys/class/gpio/gpio314/value
sleep $sleep_time

echo "step: 10/14"
echo "DIGITAL_OUT1 OFF"
echo "DIGITAL_OUT2 OFF"
sudo echo 0 > /sys/class/gpio/gpio313/value
sudo echo 0 > /sys/class/gpio/gpio314/value
sleep $sleep_time

echo "step: 11/14"
echo "DIGITAL_OUT0 ON"
echo "DIGITAL_OUT2 ON"
sudo echo 1 > /sys/class/gpio/gpio312/value
sudo echo 1 > /sys/class/gpio/gpio314/value
sleep $sleep_time

echo "step: 12/14"
echo "DIGITAL_OUT0 OFF"
echo "DIGITAL_OUT2 OFF"
sudo echo 0 > /sys/class/gpio/gpio312/value
sudo echo 0 > /sys/class/gpio/gpio314/value
sleep $sleep_time

#Triple Test
echo "step: 13/14"
echo "DIGITAL_OUT0 ON"
echo "DIGITAL_OUT1 ON"
echo "DIGITAL_OUT2 ON"
sudo echo 1 > /sys/class/gpio/gpio312/value
sudo echo 1 > /sys/class/gpio/gpio313/value
sudo echo 1 > /sys/class/gpio/gpio314/value
sleep $sleep_time

echo "step: 14/14"
echo "DIGITAL_OUT0 OFF"
echo "DIGITAL_OUT1 OFF"
echo "DIGITAL_OUT2 OFF"
sudo echo 0 > /sys/class/gpio/gpio312/value
sudo echo 0 > /sys/class/gpio/gpio313/value
sudo echo 0 > /sys/class/gpio/gpio314/value

echo "Completed"

sleep 1
sudo echo 1 > /sys/class/gpio/gpio312/value
sudo echo 1 > /sys/class/gpio/gpio313/value
sudo echo 1 > /sys/class/gpio/gpio314/value
sleep 1

sudo echo 312 > /sys/class/gpio/unexport
sudo echo 313 > /sys/class/gpio/unexport
sudo echo 314 > /sys/class/gpio/unexport

