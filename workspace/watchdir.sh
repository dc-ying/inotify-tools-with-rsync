path=$1
log=$2
inotifywait -m -r --timefmt '%d%m%y %H:%M:%S' --format '%T %w %f %e' -e create,delete,modify,close_write $path -q >$log
