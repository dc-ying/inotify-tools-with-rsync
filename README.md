# inotify-tools-with-rsync
a docker for inotify-tools with rsync 

## To build
```
sudo docker build -t rsync .
```

## To run
```
sudo docker run -v <path/to/backup>:/backup -it rsync
```
