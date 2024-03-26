#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

BOARD_REV_1_23=$1

sleep_time=0.3

function kill_gpioset_bg {
	# $1 -> GPIO chip
	# $2 -> GPIO index
	if [ $(ps -t | grep gpioset | grep "$1 $2" | wc -l) -eq 1 ]; then
		PID_GPIOSET_BG=$(ps -t | grep gpioset | grep "$1 $2" | awk '{print $1;}')

		kill $PID_GPIOSET_BG

		if [ $(ps -t | grep gpioset | grep "$1 $2" | wc -l) -eq 1 ]; then
			echo "Unable to kill process $PID_GPIOSET_BG"
		fi
	fi
}

function run_gpioset_out {
	# $1 -> GPIO chip
	# $2 -> GPIO index
	# $3 -> output value

	# If there is a gpioset command is working in background (for the selected GPIO), kill it
	kill_gpioset_bg $1 $2

	# Run the gpioset command in background (to keep the GPIO value continuously)
	gpioset --mode=signal $1 $2=$3 &
}

#gpiochip2 - pcf8574a
OUT0_PIN="2 4"
OUT1_PIN="2 5"
OUT2_PIN="2 6"

if $BOARD_REV_1_23; then
	OUT0_PIN=`gpiofind "PY.02"`
	OUT1_PIN=`gpiofind "PY.03"`
	OUT2_PIN=`gpiofind "PY.04"`
fi

run_gpioset_out $OUT0_PIN=1
run_gpioset_out $OUT1_PIN=1
run_gpioset_out $OUT2_PIN=1

sleep $sleep_time

echo "DIGITAL_OUT0 OFF"
run_gpioset_out $OUT0_PIN=0
echo "DIGITAL_OUT1 OFF"
run_gpioset_out $OUT1_PIN=0
echo "DIGITAL_OUT2 OFF"
run_gpioset_out $OUT2_PIN=0

#Single Test
echo "step: 1/14"
echo "DIGITAL_OUT0 ON"
run_gpioset_out $OUT0_PIN=1
sleep $sleep_time

echo "step: 2/14"
echo "DIGITAL_OUT0 OFF"
run_gpioset_out $OUT0_PIN=0
sleep $sleep_time

echo "step: 3/14"
echo "DIGITAL_OUT1 ON"
run_gpioset_out $OUT1_PIN=1
sleep $sleep_time

echo "step: 4/14"
echo "DIGITAL_OUT1 OFF"
run_gpioset_out $OUT1_PIN=0
sleep $sleep_time

echo "step: 5/14"
echo "DIGITAL_OUT2 ON"
run_gpioset_out $OUT2_PIN=1
sleep $sleep_time

echo "step: 6/14"
echo "DIGITAL_OUT2 OFF"
run_gpioset_out $OUT2_PIN=0
sleep $sleep_time

#Double Test
echo "step: 7/14"
echo "DIGITAL_OUT0 ON"
echo "DIGITAL_OUT1 ON"
run_gpioset_out $OUT0_PIN=1
run_gpioset_out $OUT1_PIN=1
sleep $sleep_time

echo "step: 8/14"
echo "DIGITAL_OUT0 OFF"
echo "DIGITAL_OUT1 OFF"
run_gpioset_out $OUT0_PIN=0
run_gpioset_out $OUT1_PIN=0
sleep $sleep_time

echo "step: 9/14"
echo "DIGITAL_OUT1 ON"
echo "DIGITAL_OUT2 ON"
run_gpioset_out $OUT1_PIN=1
run_gpioset_out $OUT2_PIN=1
sleep $sleep_time

echo "step: 10/14"
echo "DIGITAL_OUT1 OFF"
echo "DIGITAL_OUT2 OFF"
run_gpioset_out $OUT1_PIN=0
run_gpioset_out $OUT2_PIN=0
sleep $sleep_time

echo "step: 11/14"
echo "DIGITAL_OUT0 ON"
echo "DIGITAL_OUT2 ON"
run_gpioset_out $OUT0_PIN=1
run_gpioset_out $OUT2_PIN=1
sleep $sleep_time

echo "step: 12/14"
echo "DIGITAL_OUT0 OFF"
echo "DIGITAL_OUT2 OFF"
run_gpioset_out $OUT0_PIN=0
run_gpioset_out $OUT2_PIN=0
sleep $sleep_time

#Triple Test
echo "step: 13/14"
echo "DIGITAL_OUT0 ON"
echo "DIGITAL_OUT1 ON"
echo "DIGITAL_OUT2 ON"
run_gpioset_out $OUT0_PIN=1
run_gpioset_out $OUT1_PIN=1
run_gpioset_out $OUT2_PIN=1
sleep $sleep_time

echo "step: 14/14"
echo "DIGITAL_OUT0 OFF"
echo "DIGITAL_OUT1 OFF"
echo "DIGITAL_OUT2 OFF"
run_gpioset_out $OUT0_PIN=0
run_gpioset_out $OUT1_PIN=0
run_gpioset_out $OUT2_PIN=0

echo "Completed"

sleep 1
run_gpioset_out $OUT0_PIN=1
run_gpioset_out $OUT1_PIN=1
run_gpioset_out $OUT2_PIN=1
sleep 1

