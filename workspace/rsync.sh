#!/bin/sh
srcdir=/workspace
dstdir=/backup
dstip='localhost'
#excludedir=/usr/local/inotify/exclude.list

rsyncpassdir=/etc/passwd.txt

for ip in $dstip
    do
    # rsync -avH --port=873 --progress --delete  --exclude-from=$excludedir  $srcdir $rsyncuser@$ip::$dstdir --password-file=$rsyncpassdir
    rsync -avzr --port=873 --progress $srcdir $dstdir
    done

/usr/bin/inotifywait -mrq --timefmt '%d/%m/%y %H:%M' --format '%T %w%f%e' -e close_write,modify,delete,create,attrib,move $srcdir |  while read file
do
    for ip in $dstip
        do
        # rsync -avH --port=873 --progress --delete  --exclude-from=$excludedir  $srcdir $rsyncuser@$ip::$dstdir --password-file=$rsyncpassdir
        rsync -avzr --port=873 --progress $srcdir $dstdir
        echo "  ${file} was rsynced" >> /backup/rsync.log 2>&1
        done
done

