#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

BOARD_REV_1_23=$1

#gpiochip2 - pcf8574a
IN1_PIN="2 1"

if $BOARD_REV_1_23; then
	IN1_PIN=`gpiofind "PY.01"`
fi

watch -n 0.1 gpioget $IN1_PIN

