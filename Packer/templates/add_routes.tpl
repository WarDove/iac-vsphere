#!/bin/bash

for ip in "${IP_LIST[@]}"
do
ip route add $ip/32 via $GATEWAY
done

