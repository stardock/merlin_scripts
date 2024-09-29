#!/bin/sh
#verify if the ip changes and then resart zerotier network.

time1=$(date "+%Y-%m-%d %H:%M:%S")
echo $time1

sync
touch /tmp/ips6.asp
old=$(cat /tmp/ips6.asp)
echo "$old"
WANIP=$(nvram get wan0_ipaddr)
echo $WANIP > /tmp/ips7.asp
sync
sleep 10
new=$(cat /tmp/ips7.asp)
echo "$new"
if [ "$old" != "$new" ]
then
  rm -rf /tmp/ips6.asp
  mv /tmp/ips7.asp /tmp/ips6.asp
  /koolshare/scripts/zerotier_config stop
  sleep 10
  /koolshare/scripts/zerotier_config start
else
        echo "==same!"
fi
