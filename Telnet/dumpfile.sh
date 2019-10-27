#!/bin/bash

xinetd -dontfork -stayalive &

eth=$1
listen_port=$2
work_dir=$3

echo "catching $eth:$listen_port"
mkdir $work_dir/dumps

times=0
while :
do
	#echo "Now $times"
	#timestamp=`date "+%Y-%m-%d_%H:%M:%S"`
	let times+=1
	tcpdump tcp -i $eth -c 100 -w $work_dir/dumps/log_$(date "+%Y-%m-%d_%H:%M:%S")_$times.pcap port $listen_port > /dev/null  2>&1
done
