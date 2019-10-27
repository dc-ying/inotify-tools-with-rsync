# inotify-tools-with-rsync
a docker for inotify-tools with rsync 

## To build
```
sudo docker build -t rsync .
```

## To run
```
sudo docker run -d -p 23:23 -v ~/backup:/home/test/backup -it rsync:user
```
