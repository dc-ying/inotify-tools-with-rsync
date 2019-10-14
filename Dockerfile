FROM ubuntu:16.04

MAINTAINER ying_dc@sjtu.edu.cn

COPY workspace /workspace
COPY rsyncd.conf /etc/rsyncd.conf

RUN  sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list

################################# apt install depends ########################

RUN echo "[log] start apt-get install ..."

RUN apt-get update -q 
RUN apt-get install -y -q build-essential \
			  make \
                          inotify-tools \
			  rsync \
			  openssh-server \
			  vim

RUN  sed -ie 's/false/true/g' /etc/default/rsync
COPY  rsyncd.secrets /etc/rsyncd.secrets
RUN /etc/init.d/rsync start
