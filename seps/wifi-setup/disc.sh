#!/bin/sh
sudo pkill wpa_supplicant
sudo pkill dhclient
sudo ifconfig wlan0 down
