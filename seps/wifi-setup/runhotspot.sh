#!/bin/sh
SCRIPT_LOC=/home/pi/wifi-setup
sudo mv /etc/network/interfaces /etc/network/interfaces-bak
sudo cp $SCRIPT_LOC/hotspot/interfaces /etc/network/interfaces
sudo cp $SCRIPT_LOC/hotspot/hostapd-text /etc/default/hostapd
sudo mv /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf-bak
sudo cp $SCRIPT_LOC/hotspot/hostapd.conf /etc/hostapd/hostapd.conf
sudo mv /etc/default/isc-dhcp-server /etc/default/isc-dhcp-server-bak
sudo cp $SCRIPT_LOC/hotspot/isc-dhcp-server /etc/default/isc-dhcp-server
sudo mv /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf-bak
sudo cp $SCRIPT_LOC/hotspot/dhcpd.conf /etc/dhcp/dhcpd.conf
sudo service networking restart
sudo hostapd /etc/hostapd/hostapd.conf &
#sudo ip addr add 10.5.5.1 dev wlam0
sudo ifconfig wlan0 10.5.5.1 netmask 255.255.255.0
sleep 2
sudo service isc-dhcp-server start
