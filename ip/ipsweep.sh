#!/bin/bash

# This is a basic utility that sends a ping to all devices on a 255.255.255.0 masked local network
# Usage: ipsweep.sh [ xxx.xxx.xxx ] | [ -d ]

# Get user input for first 3 octets, defaults to "192.168.0"
input=$1

if [ "$input" == "" ]
then
	echo "Expected first three octets (xxx.xxx.xxx)"
	echo "-d option defaults to 192.168.0"
	exit 1
elif [ "$input" == "-d" ]
then
	ip_start="192.168.0"
else
	ip_start=$input 
fi

# Sends asynchronous ping
for ip_end in $(seq 1 255)
do
	ip="$ip_start.$ip_end"
	# Sends one ping to ip
	ping -c 1 $ip | 
	# Fetchs succesful ping
	grep "64 bytes"  | 
	# Cuts only the IP part
	cut -d " " -f 4  | 
	# Removes trailing ":" and run the loop on different threads
	tr -d ":" &
done

sleep 3