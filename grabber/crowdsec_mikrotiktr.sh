#!/bin/bash

# Variables
FIREHOL_URL="https://raw.githubusercontent.com/firehol/blocklist-ipsets/refs/heads/master/ip2location_country/ip2location_country_tr.netset"
OUTPUT_FILE="turkiships.rsc"
ADDRESS_LIST_NAME="turkiships"
TIMEOUT="7d"

# Create or clear the output file
echo "/ip firewall address-list" > $OUTPUT_FILE

# Pull the IP list
IP_LIST=$(curl -s $FIREHOL_URL | grep -E "^[0-9]")

# Iterate over each IP and append to the .rsc file
for IP in $IP_LIST; do
    echo "add address=$IP list=$ADDRESS_LIST_NAME timeout=$TIMEOUT" >> $OUTPUT_FILE
done

echo "Generated $OUTPUT_FILE with IP addresses for MikroTik."
