#!/bin/bash

echo ==== START ====

echo .. rsync.sh  ..
/workspace/rsync.sh &

echo ..   dump    ..
/usr/src/telnet/dumpfile.sh eth0 23 /backup

