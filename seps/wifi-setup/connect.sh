#!/bin/sh
#takes 3 arguments, connection type WEP(0)/WPA(1) ESSID and password
PI_LOC=/home/pi
CONFIG_LOC=$PI_LOC/network-config
sudo ifconfig wlan0 up
encrypted=0
if [ $# -lt 2 ]; then
exit 1
fi
if [ $# -eq 3 ]; then
encrypted=1
fi
if [ $1 -eq 0 ]; then
if [ $encrypted -eq 0 ]; then
sudo iwconfig wlan0 essid $2
else
sudo iwconfig wlan0 essid $2 key s:$3
fi
else
sudo wpa_passphrase $2 $3 > $CONFIG_LOC/wpa.conf
sudo wpa_supplicant -iwlan0 -c$CONFIG_LOC/wpa.conf -Dwext &
fi
sudo dhclient wlan0
echo $1 > $CONFIG_LOC/network-enc
echo $2 > $CONFIG_LOC/network-name
echo $3 > $CONFIG_LOC/network-pass
