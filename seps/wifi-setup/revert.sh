#!/bin/sh
SCRIPT_LOC=/home/pi/wifi-setup
sudo cp -f $SCRIPT_LOC/revert/interfaces /etc/network/interfaces
sudo cp -f $SCRIPT_LOC/revert/hostapd /etc/default/hostapd
sudo cp -f $SCRIPT_LOC/revert/isc-dhcp-server /etc/default/isc-dhcp-server
sudo pkill hostapd
sudo ip addr del 10.5.5.1/24 dev wlan0
sudo service isc-dhcp-server stop
sudo service networking restart
