#!/bin/sh
#verify if the ip changes and then resart zerotier network.

time1=$(date "+%Y-%m-%d %H:%M:%S")
echo $time1

#status1=$(/koolshare/bin/zerotier-cli status)
#output1=$(/koolshare/bin/zerotier-cli listnetworks)

keyword1="ONLINE"
keyword2="ztks5wuvcf"


var1=$(/koolshare/bin/zerotier-cli status | grep -i $keyword1 | wc -l)
var2=$(/koolshare/bin/zerotier-cli listnetworks | grep -i $keyword2 | wc -l)


if [ $var1 == "1" ];then
  echo "The service is up, checking network state..."
    if [ $var2 == "1" ];then
      echo "The tunnel is changed, trying to reboot the service..."
      /koolshare/scripts/zerotier_config start > /dev/null
      echo "The network is refreshed!"
    else
      echo "The network is fine, exit"
    fi
  else
  echo "The service is stopped, starting the service..."
  /koolshare/scripts/zerotier_config start > /dev/null
  echo "The service is up"
fi

