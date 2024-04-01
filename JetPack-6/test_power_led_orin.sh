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
	gpioset --mode=time -u 500000 $1 $2=$3 &
}

#gpiochip2 - pcf8574a
PWR_LED_R="2 2"
PWR_LED_G="2 3"
PWR_LED_B="2 7"

if $BOARD_REV_1_23; then
	PWR_LED_R=`gpiofind "PA.05"`
	PWR_LED_G=`gpiofind "PA.06"`
	PWR_LED_B=`gpiofind "PA.07"`
fi

run_gpioset_out $PWR_LED_R=1
run_gpioset_out $PWR_LED_G=1
run_gpioset_out $PWR_LED_B=1

sleep $sleep_time

echo "POWER_LED0 OFF"
run_gpioset_out $PWR_LED_R=0
echo "POWER_LED1 OFF"
run_gpioset_out $PWR_LED_G=0
echo "POWER_LED2 OFF"
run_gpioset_out $PWR_LED_B=0

sleep $sleep_time

#Single Test
echo "step: 1/14"
echo "POWER_LED0 ON"
run_gpioset_out $PWR_LED_R=1
sleep $sleep_time

echo "step: 2/14"
echo "POWER_LED0 OFF"
run_gpioset_out $PWR_LED_R=0
sleep $sleep_time

echo "step: 3/14"
echo "POWER_LED1 ON"
run_gpioset_out $PWR_LED_G=1
sleep $sleep_time

echo "step: 4/14"
echo "POWER_LED1 OFF"
run_gpioset_out $PWR_LED_G=0
sleep $sleep_time

echo "step: 5/14"
echo "POWER_LED2 ON"
run_gpioset_out $PWR_LED_B=1
sleep $sleep_time

echo "step: 6/14"
echo "POWER_LED2 OFF"
run_gpioset_out $PWR_LED_B=0
sleep $sleep_time

#Double Test
echo "step: 7/14"
echo "POWER_LED0 ON"
echo "POWER_LED1 ON"
run_gpioset_out $PWR_LED_R=1
run_gpioset_out $PWR_LED_G=1
sleep $sleep_time

echo "step: 8/14"
echo "POWER_LED0 OFF"
echo "POWER_LED1 OFF"
run_gpioset_out $PWR_LED_R=0
run_gpioset_out $PWR_LED_G=0
sleep $sleep_time

echo "step: 9/14"
echo "POWER_LED1 ON"
echo "POWER_LED2 ON"
run_gpioset_out $PWR_LED_G=1
run_gpioset_out $PWR_LED_B=1
sleep $sleep_time

echo "step: 10/14"
echo "POWER_LED1 OFF"
echo "POWER_LED2 OFF"
run_gpioset_out $PWR_LED_G=0
run_gpioset_out $PWR_LED_B=0
sleep $sleep_time

echo "step: 11/14"
echo "POWER_LED0 ON"
echo "POWER_LED2 ON"
run_gpioset_out $PWR_LED_R=1
run_gpioset_out $PWR_LED_B=1
sleep $sleep_time

echo "step: 12/14"
echo "POWER_LED0 OFF"
echo "POWER_LED2 OFF"
run_gpioset_out $PWR_LED_R=0
run_gpioset_out $PWR_LED_B=0
sleep $sleep_time

#Triple Test
echo "step: 13/14"
echo "POWER_LED0 ON"
echo "POWER_LED1 ON"
echo "POWER_LED2 ON"
run_gpioset_out $PWR_LED_R=1
run_gpioset_out $PWR_LED_G=1
run_gpioset_out $PWR_LED_B=1
sleep $sleep_time

echo "step: 14/14"
echo "POWER_LED0 OFF"
echo "POWER_LED1 OFF"
echo "POWER_LED2 OFF"
run_gpioset_out $PWR_LED_R=0
run_gpioset_out $PWR_LED_G=0
run_gpioset_out $PWR_LED_B=0
sleep $sleep_time

echo "Completed"

sleep 1
run_gpioset_out $PWR_LED_R=1
run_gpioset_out $PWR_LED_G=1
run_gpioset_out $PWR_LED_B=1
sleep 1


