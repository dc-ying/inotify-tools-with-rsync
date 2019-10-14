FROM ubuntu:16.04

MAINTAINER ying_dc@sjtu.edu.cn

COPY workspace /workspace
RUN  sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list

################################# apt install depends ########################

RUN echo "[log] start apt-get install ..."	&&\

apt-get update	-q 	&&\
apt-get install -y -q build-essential \
                      make \
                      inotify-tools \
