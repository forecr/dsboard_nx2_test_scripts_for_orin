#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

BOARD_REV_1_23=$1
BOARD_REV_1_2=false

HALF_FULL=`gpiofind "PG.06"`
HALF_FULL_VAL=0
RS422_232=`gpiofind "PAC.06"`
RS422_232_VAL=1

if $BOARD_REV_1_2; then
	HALF_FULL_VAL=1
fi

if $BOARD_REV_1_23; then
	HALF_FULL=`gpiofind "PAC.06"`
	RS422_232=`gpiofind "PG.06"`
fi

gpioset --mode=signal $HALF_FULL=$HALF_FULL_VAL &
PID_HALF_FULL=$!
gpioset --mode=signal $RS422_232=$RS422_232_VAL &
PID_RS422_232=$!

trap interrupt_func INT
interrupt_func() {
	kill $PID_RS422_232
	kill $PID_HALF_FULL
}

sudo gtkterm -p /dev/ttyTHS0 -s 115200


