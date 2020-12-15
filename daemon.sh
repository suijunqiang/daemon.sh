#! /bin/sh
PRO_NAME_EMQX=/data/emqx
PRO_NAME_WIFIDOG=/data/wifidog

while true ; do
     # ps to get $PRO_NAME_EMQX
     NUM=`ps aux | grep -w ${PRO_NAME_EMQX} | grep -v grep |wc -l`
     #echo $NUM
     # less than 1，restart process
     if [ "${NUM}" -lt "1" ];then
         echo "${PRO_NAME_EMQX} was killed"
         ${PRO_NAME_EMQX} -d
    # more than 1，kill all to restart
    elif [ "${NUM}" -gt "1" ];then
        echo "more than 1 ${PRO_NAME_EMQX},killall ${PRO_NAME_EMQX}"
         killall -9 $PRO_NAME_EMQX
        ${PRO_NAME_EMQX} -d
     fi
     #kill zombi
     NUM_STAT=`ps aux | grep -w ${PRO_NAME_EMQX} | grep T | grep -v grep | wc -l`
     if [ "${NUM_STAT}" -gt "0" ];then
         killall -9 ${PRO_NAME_EMQX}
         ${PRO_NAME_EMQX} -d
    fi

     # ps to get $PRO_NAME_WIFIDOG
     NUM_WIFIDOG=`ps aux | grep -w ${PRO_NAME_WIFIDOG} | grep -v grep |wc -l`
     #echo $NUM_WIFIDOG
     # less than 1，restart process
     if [ "${NUM_WIFIDOG}" -lt "1" ];then
         echo "${PRO_NAME_WIFIDOG} was killed"
         ${PRO_NAME_WIFIDOG}  -d 7 -c /usr/local/etc/wifidog.conf
    # more than 1，kill all to restart
    elif [ "${NUM_WIFIDOG}" -gt "1" ];then
        echo "more than 1 ${PRO_NAME_WIFIDOG},killall ${PRO_NAME_WIFIDOG}"
         killall -9 $PRO_NAME_WIFIDOG
        ${PRO_NAME_WIFIDOG} -d 7 -c /usr/local/etc/wifidog.conf
     fi
     #kill zombi
     NUM_STAT_WIFIDOG=`ps aux | grep -w ${PRO_NAME_WIFIDOG} | grep T | grep -v grep | wc -l`
     if [ "${NUM_STAT_WIFIDOG}" -gt "0" ];then
         killall -9 ${PRO_NAME_WIFIDOG}
         ${PRO_NAME_WIFIDOG} -d 7 -c /usr/local/etc/wifidog.conf
    fi


     sleep 5s
 done

 exit 0
 
