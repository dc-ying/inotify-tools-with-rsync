#!/bin/sh
srcdir=/workspace
dstdir=~/workspace/backup

#excludedir=/usr/local/inotify/exclude.list

rsyncuser=$1
rsyncpassdir=/etc/passwd.txt
dstip=$2

for ip in $dstip
    do
    # rsync -avH --port=873 --progress --delete  --exclude-from=$excludedir  $srcdir $rsyncuser@$ip::$dstdir --password-file=$rsyncpassdir
    rsync -avH --port=873 --progress --delete  $srcdir $rsyncuser@$ip:$dstdir
    done

/usr/bin/inotifywait -mrq --timefmt '%d/%m/%y %H:%M' --format '%T %w%f%e' -e close_write,modify,delete,create,attrib,move $srcdir |  while read file
do
    for ip in $dstip
        do
        # rsync -avH --port=873 --progress --delete  --exclude-from=$excludedir  $srcdir $rsyncuser@$ip::$dstdir --password-file=$rsyncpassdir
        rsync -avH --port=873 --progress --delete  $srcdir $rsyncuser@$ip:$dstdir
        echo "  ${file} was rsynced" >> /tmp/rsync.log 2>&1
        done
done

