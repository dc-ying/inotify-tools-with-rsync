FROM     ubuntu:16.04
MAINTAINER Zhengtang Yang "yangzhengtang@sjtu.edu.cn"

WORKDIR /usr/src/app

COPY . .

RUN apt-get update && \ 
    DEBIAN_FRONTEND=noninteractive apt-get -y install telnetd xinetd tcpdump net-tools&& \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* && \
    echo root:malware | chpasswd && \
		cp ./telnet /etc/xinetd.d/telnet && \
    rm -f /etc/securetty

ENTRYPOINT ["bash"]
CMD ["-c","./dumpfile.sh eth0 23"]
