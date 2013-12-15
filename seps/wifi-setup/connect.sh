#!/bin/sh
#takes 2 arguments ESSID and wpa password for now
PI_LOC=/home/pi
CONFIG_LOC=$PI_LOC/network-config
sudo ifconfig wlan0 up
sudo wpa_passphrase $1 $2 > $CONFIG_LOC/wpa.conf
sudo wpa_supplicant -iwlan0 -c$CONFIG_LOC/wpa.conf -Dwext &
sudo dhclient wlan0
echo $1 > $CONFIG_LOC/network-name
echo $2 > $CONFIG_LOC/network-pass
