#!/bin/sh
#takes 2 arguments ESSID and wpa password for now
sudo wpa_passphrase $1 $2 > wpa.conf
sudo wpa_supplicant -iwlan0 -cwpa.conf -Dwext &
sudo dhclient wlan0
