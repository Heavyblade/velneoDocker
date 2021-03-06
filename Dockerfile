FROM ubuntu:14.04

# Configuración para correr apps de 32bits
RUN dpkg --add-architecture i386
RUN apt-get -y update
RUN echo "deb http://old-releases.ubuntu.com/ubuntu/ raring main restricted universe multiverse" > /etc/apt/sources.list.d/ia32-libs-raring.list
RUN apt-get -y update
RUN apt-get -y install ia32-libs

# Herramienta de monitorización para que arranque el vserver
RUN apt-get -y install monit
COPY monitrc /etc/monitrc
RUN chmod 0700 /etc/monitrc
EXPOSE 2812

RUN mkdir /home/data
VOLUME ["/Velneo"]
