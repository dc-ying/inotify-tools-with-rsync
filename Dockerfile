FROM ubuntu:16.04

MAINTAINER ying_dc@sjtu.edu.cn

COPY workspace /workspace
COPY rsyncd.conf /etc/rsyncd.conf
COPY Telnet /usr/src/telnet

RUN  sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list

#	apt-get install
RUN echo "[log] start apt-get install ..."
RUN apt-get update -q &&\
	apt-get install -y -q 	build-essential \
							make \
							inotify-tools \
							rsync \
							openssh-server \
							telnetd xinetd tcpdump net-tools && \
			apt-get autoremove -y && \
			apt-get autoclean -y && \
			rm -rf /var/lib/apt/lists/*			  

#	setup rsync
RUN  sed -ie 's/false/true/g' /etc/default/rsync
COPY  rsyncd.secrets /etc/rsyncd.secrets
RUN /etc/init.d/rsync start

#	add user: test/123
RUN useradd --create-home --no-log-init --shell /bin/bash test
RUN echo 'test:123' | chpasswd
RUN mkdir /home/test/backup
RUN mkdir /home/test/workspace

#	setup telnet
RUN cp /usr/src/telnet/telnet /etc/xinetd.d/telnet && \
	rm -f /etc/securetty

CMD /workspace/rsync.sh
WORKDIR /home/test/workspace
ENTRYPOINT ["bash"]
CMD ["-c","/usr/src/telnet/dumpfile.sh eth0 23 /home/test/workspace"]
