sudo echo 453 > /sys/class/gpio/export
sudo echo high > /sys/class/gpio/PQ.05/direction
sleep 1
sudo echo low > /sys/class/gpio/PQ.05/direction

trap interrupt_func INT
interrupt_func() {
	sudo echo 453 > /sys/class/gpio/unexport
}

watch -n 0.1 lsusb

