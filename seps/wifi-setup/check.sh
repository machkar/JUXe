#!/bin/bash
ip_var=$(ip route | head -1 | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]")
if [ -z $ip_var ]; then
    echo 0
else
#attempt to ping gateway
    ping_var=$(ping -c 1 -w 2 $ip_var | grep -o "$ip_var:")
    if [ -z $ping_var ]; then
        echo 0
        else
        echo 1
    fi
fi
