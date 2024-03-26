#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

BOARD_REV_1_23=$1
BOARD_REV_1_2=false

RS485_CTRL_NUM=331
RS485_CTRL=PCC.03
RS485_CTRL_VAL=0
HALF_FULL_NUM=389
HALF_FULL=PG.06
HALF_FULL_VAL=1
RS422_232_NUM=492
RS422_232=PAC.06
RS422_232_VAL=1

if $BOARD_REV_1_2; then
	HALF_FULL_VAL=0
fi

if $BOARD_REV_1_23; then
	HALF_FULL_NUM=492
	HALF_FULL=PAC.06
	RS422_232_NUM=389
	RS422_232=PG.06
fi

sudo echo $RS485_CTRL_NUM > /sys/class/gpio/export 
sudo echo $HALF_FULL_NUM > /sys/class/gpio/export 
sudo echo $RS422_232_NUM > /sys/class/gpio/export 
sudo echo out > /sys/class/gpio/$RS485_CTRL/direction 
sudo echo out > /sys/class/gpio/$HALF_FULL/direction 
sudo echo out > /sys/class/gpio/$RS422_232/direction 

sudo echo $RS485_CTRL_VAL > /sys/class/gpio/$RS485_CTRL/value 
sudo echo $HALF_FULL_VAL > /sys/class/gpio/$HALF_FULL/value 
sudo echo $RS422_232_VAL > /sys/class/gpio/$RS422_232/value

sudo gtkterm -p /dev/ttyTHS0 -s 115200 -w RS485

sudo echo $RS485_CTRL_NUM > /sys/class/gpio/unexport
sudo echo $HALF_FULL_NUM > /sys/class/gpio/unexport
sudo echo $RS422_232_NUM > /sys/class/gpio/unexport

