#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

BOARD_REV_1_23=$1

#gpiochip2 - pcf8574a
IN0_PIN="2 0"

if $BOARD_REV_1_23; then
	IN0_PIN=`gpiofind "PY.00"`
fi

watch -n 0.1 gpioget $IN0_PIN

