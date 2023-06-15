#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

BOARD_REV_1_23=$1

sleep_time=0.3

R_PIN_NUM=310
R_PIN=gpio310
G_PIN_NUM=311
G_PIN=gpio311
B_PIN_NUM=315
B_PIN=gpio315

if $BOARD_REV_1_23; then
	R_PIN_NUM=353
	R_PIN=PA.05
	G_PIN_NUM=354
	G_PIN=PA.06
	B_PIN_NUM=355
	B_PIN=PA.07
fi

sudo echo $R_PIN_NUM > /sys/class/gpio/export
sudo echo out > /sys/class/gpio/$R_PIN/direction
sudo echo $G_PIN_NUM > /sys/class/gpio/export
sudo echo out > /sys/class/gpio/$G_PIN/direction
sudo echo $B_PIN_NUM > /sys/class/gpio/export
sudo echo out > /sys/class/gpio/$B_PIN/direction

sleep $sleep_time

echo "POWER_LED0 OFF"
sudo echo 0 > /sys/class/gpio/$R_PIN/value
echo "POWER_LED1 OFF"
sudo echo 0 > /sys/class/gpio/$G_PIN/value
echo "POWER_LED2 OFF"
sudo echo 0 > /sys/class/gpio/$B_PIN/value

#Single Test
echo "step: 1/14"
echo "POWER_LED0 ON"
sudo echo 1 > /sys/class/gpio/$R_PIN/value
sleep $sleep_time

echo "step: 2/14"
echo "POWER_LED0 OFF"
sudo echo 0 > /sys/class/gpio/$R_PIN/value
sleep $sleep_time

echo "step: 3/14"
echo "POWER_LED1 ON"
sudo echo 1 > /sys/class/gpio/$G_PIN/value
sleep $sleep_time

echo "step: 4/14"
echo "POWER_LED1 OFF"
sudo echo 0 > /sys/class/gpio/$G_PIN/value
sleep $sleep_time

echo "step: 5/14"
echo "POWER_LED2 ON"
sudo echo 1 > /sys/class/gpio/$B_PIN/value
sleep $sleep_time

echo "step: 6/14"
echo "POWER_LED2 OFF"
sudo echo 0 > /sys/class/gpio/$B_PIN/value
sleep $sleep_time

#Double Test
echo "step: 7/14"
echo "POWER_LED0 ON"
echo "POWER_LED1 ON"
sudo echo 1 > /sys/class/gpio/$R_PIN/value
sudo echo 1 > /sys/class/gpio/$G_PIN/value
sleep $sleep_time

echo "step: 8/14"
echo "POWER_LED0 OFF"
echo "POWER_LED1 OFF"
sudo echo 0 > /sys/class/gpio/$R_PIN/value
sudo echo 0 > /sys/class/gpio/$G_PIN/value
sleep $sleep_time

echo "step: 9/14"
echo "POWER_LED1 ON"
echo "POWER_LED2 ON"
sudo echo 1 > /sys/class/gpio/$G_PIN/value
sudo echo 1 > /sys/class/gpio/$B_PIN/value
sleep $sleep_time

echo "step: 10/14"
echo "POWER_LED1 OFF"
echo "POWER_LED2 OFF"
sudo echo 0 > /sys/class/gpio/$G_PIN/value
sudo echo 0 > /sys/class/gpio/$B_PIN/value
sleep $sleep_time

echo "step: 11/14"
echo "POWER_LED0 ON"
echo "POWER_LED2 ON"
sudo echo 1 > /sys/class/gpio/$R_PIN/value
sudo echo 1 > /sys/class/gpio/$B_PIN/value
sleep $sleep_time

echo "step: 12/14"
echo "POWER_LED0 OFF"
echo "POWER_LED2 OFF"
sudo echo 0 > /sys/class/gpio/$R_PIN/value
sudo echo 0 > /sys/class/gpio/$B_PIN/value
sleep $sleep_time

#Triple Test
echo "step: 13/14"
echo "POWER_LED0 ON"
echo "POWER_LED1 ON"
echo "POWER_LED2 ON"
sudo echo 1 > /sys/class/gpio/$R_PIN/value
sudo echo 1 > /sys/class/gpio/$G_PIN/value
sudo echo 1 > /sys/class/gpio/$B_PIN/value
sleep $sleep_time

echo "step: 14/14"
echo "POWER_LED0 OFF"
echo "POWER_LED1 OFF"
echo "POWER_LED2 OFF"
sudo echo 0 > /sys/class/gpio/$R_PIN/value
sudo echo 0 > /sys/class/gpio/$G_PIN/value
sudo echo 0 > /sys/class/gpio/$B_PIN/value

echo "Completed"

sleep 1
sudo echo 1 > /sys/class/gpio/$R_PIN/value
sudo echo 1 > /sys/class/gpio/$G_PIN/value
sudo echo 1 > /sys/class/gpio/$B_PIN/value
sleep 1

sudo echo $R_PIN_NUM > /sys/class/gpio/unexport
sudo echo $G_PIN_NUM > /sys/class/gpio/unexport
sudo echo $B_PIN_NUM > /sys/class/gpio/unexport

