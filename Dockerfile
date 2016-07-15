FROM ubuntu:14.04

RUN dpkg --add-architecture i386
RUN apt-get -y update
RUN echo "deb http://old-releases.ubuntu.com/ubuntu/ raring main restricted universe multiverse" > /etc/apt/sources.list.d/ia32-libs-raring.list
RUN apt-get -y update
RUN apt-get -y install ia32-libs

RUN apt-get -y install wget
RUN apt-get -y install monit
COPY monitrc /etc/monitrc
RUN chmod 0700 /etc/monitrc
RUN wget https://s3.amazonaws.com/vback/vserver.719.tar.gz
RUN tar -zxvf vserver.719.tar.gz
EXPOSE 690
CMD monit -d 10 -Ic /etc/monitrc
