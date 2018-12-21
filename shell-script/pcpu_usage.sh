#!/bin/bash
#文件名: pcpu_usage.sh
#用途:计算1个小时内进程的CPU占用情况
SECS=300
UNIT_TIME=10
#将SECS更改成需要进行监视的总秒数
#UNIT_TIME是取样的时间间隔，单位是秒
STEPS=$(( $SECS / $UNIT_TIME ))
echo Watching CPU usage... ;
for((i=0;i<STEPS;i++))
do
ps -eocomm,pcpu | tail -n +2 >> /tmp/cpu_usage.$$
sleep $UNIT_TIME
done
echo
echo CPU eaters :
cat /tmp/cpu_usage.$$ | \
awk '
{ process[$1]+=$2; }
END{
for(i in process)
{
printf("%-20s %s\n",i, process[i]) ;
}
}' | sort -nrk 2 | head
