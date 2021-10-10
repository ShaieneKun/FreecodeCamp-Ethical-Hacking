#!/bin/bash

# This is a basic utility that uses nmap on port 80 (HTTP) to a given list of IPs
# Usage: httpsweep.sh [ xxx.xxx.xxx ] | [ -d ]

input=$1

if [ "$input" == "" ]
then
	echo "Expected a list of IP addresses"
	exit 1
fi

for ip in $input
do
	nmap -p 80 -T4 $ip &
done