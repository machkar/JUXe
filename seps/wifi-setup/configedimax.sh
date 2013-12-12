#!/bin/sh
sudo apt-get install bridge-utils hostapd isc-dhcp-client
unzip hostapd.zip
sudo mv /usr/sbin/hostapd /usr/sbin/hostapd.bak
sudo mv hostapd /usr/sbin/hostapd
sudo chown root.root /usr/sbin/hostapd
sudo chmod 755 /usr/sbin/hostapd
sudo mv /etc/network/interfaces /etc/network/interfaces-bak
sudo mv interfaces /etc/network/interfaces
sudo mv hostapd-text /etc/default/hostapd
sudo apt-get install isc-dhcp-server

