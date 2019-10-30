# inotify-tools-with-rsync
a docker for inotify-tools with rsync 

## To build
```
sudo docker build -t rsync .
```

## To run
```
sudo docker run -d -p 23:23 -v ~/backup:/backup -it rsync
```

By running with this command, you can get catched files in ~/backup
