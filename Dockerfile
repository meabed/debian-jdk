#
# Debian JDK with Dev tools
# FROM Debian:wheezy
# docker build -t meabed/debian-jdk:latest .
#

FROM debian:wheezy
MAINTAINER Mohamed Meabed "mo.meabed@gmail.com"

USER root
ENV DEBIAN_FRONTEND noninteractive

# Download and Install JDK
ENV JDK_VERSION 7

# install dev tools
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y apt-utils curl tar openssh-server openssh-client rsync vim lsof iptables telnet python-pip

# passwordless ssh
RUN rm /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_rsa_key

RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa

RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# java
RUN apt-get install -y openjdk-$JDK_VERSION-jdk

ENV JAVA_HOME /usr/lib/jvm/java-$JDK_VERSION-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin
