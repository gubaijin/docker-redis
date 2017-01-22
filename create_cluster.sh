#!/bin/bash

#####
#determine Cluster
#####

[ -f /data/redis/check ] && exit 0

#####
#Get Node
#####

M1=`printf '%s' "$SERVERS" | awk -F',' '{print$1}'`
M2=`printf '%s' "$SERVERS" | awk -F',' '{print$2}'`
M3=`printf '%s' "$SERVERS" | awk -F',' '{print$3}'`
M4=`printf '%s' "$SERVERS" | awk -F',' '{print$4}'`
M5=`printf '%s' "$SERVERS" | awk -F',' '{print$5}'`
M6=`printf '%s' "$SERVERS" | awk -F',' '{print$6}'`

#####
#Get Node IP
#####

IP1=`ping -c 1 ${M1} | grep PING | awk -F'(' '{print $2}' | awk -F')' '{print $1}'`
IP2=`ping -c 1 ${M2} | grep PING | awk -F'(' '{print $2}' | awk -F')' '{print $1}'`
IP3=`ping -c 1 ${M3} | grep PING | awk -F'(' '{print $2}' | awk -F')' '{print $1}'`
IP4=`ping -c 1 ${M4} | grep PING | awk -F'(' '{print $2}' | awk -F')' '{print $1}'`
IP5=`ping -c 1 ${M5} | grep PING | awk -F'(' '{print $2}' | awk -F')' '{print $1}'`
IP6=`ping -c 1 ${M6} | grep PING | awk -F'(' '{print $2}' | awk -F')' '{print $1}'`

#####
#Create Cluster
#####

echo "yes"|redis-trib.rb create --replicas 1 ${IP1}:6379 ${IP2}:6379 ${IP3}:6379 ${IP4}:6379 ${IP5}:6379 ${IP6}:6379
[ $? -eq 0 ] && echo ${IP1},${IP2},${IP3},${IP4},${IP5},${IP6} > /data/redis/check || exit 0
