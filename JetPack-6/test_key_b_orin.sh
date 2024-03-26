#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

gpioset --mode=signal `gpiofind "PQ.05"`=1 &
PID_M2B_RESET=$!
sleep 1

kill $PID_M2B_RESET
gpioset --mode=signal `gpiofind "PQ.05"`=0 &

trap interrupt_func INT
interrupt_func() {
	kill $PID_M2B_RESET
}

watch -n 0.1 lsusb

