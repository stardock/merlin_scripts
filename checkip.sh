#!/bin/sh
#verify if the ip changes and then resart zerotier network.

time1=$(date "+%Y-%m-%d %H:%M:%S")
echo $time1

sync
if [ ! -d /jffs/var  ];then
  mkdir /jffs/var
  echo "created /jffs/var"
else
  echo "/jffs/var exist!"
fi

touch /jffs/var/ips6.asp
old=$(cat /jffs/var/ips6.asp)
echo "$old"
wget -q -O /jffs/var/ips7.asp curl ipv4.ip.sb
sync
sleep 10
new=$(cat /jffs/var/ips7.asp)
echo "$new"
if [ "$old" != "$new" ]
then
  rm -rf /jffs/var/ips6.asp
  mv /jffs/var/ips7.asp /jffs/var/ips6.asp
  /koolshare/scripts/zerotier_config stop
  sleep 10
  /koolshare/scripts/zerotier_config start
else
        echo "==same!"
fi
