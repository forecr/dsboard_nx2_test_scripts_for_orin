#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

BOARD_REV_1_23=$1

IN0_PIN_NUM=309
IN0_PIN=gpio309

if $BOARD_REV_1_23; then
	IN0_PIN_NUM=471
	IN0_PIN=PY.01
fi

sudo echo $IN0_PIN_NUM > /sys/class/gpio/export
sudo echo in > /sys/class/gpio/$IN0_PIN/direction

trap interrupt_func INT
interrupt_func() {
	sudo echo $IN0_PIN_NUM > /sys/class/gpio/unexport
}

watch -n 0.1 sudo cat /sys/class/gpio/$IN0_PIN/value

