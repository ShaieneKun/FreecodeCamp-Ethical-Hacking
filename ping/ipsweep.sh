#!/bin/bash

# This is a basic utility that sends a ping to all devices on a 255.255.255.0 masked local network
# Usage: pingsweep.sh 192.168.0

ip_start=$1 # Get user input

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