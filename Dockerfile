FROM jenkins:latest

MAINTAINER developers@synopsis.cz

ENV JENKINS_HOME /data/jenkins/home

USER root
RUN apt-get update && apt-get install -y apt-transport-https && apt-get clean
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

ADD docker.list /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y docker-engine npm nodejs-legacy php5-cli php5-cgi php5-curl php5-mcrypt php5-xdebug ant rsync && apt-get clean
RUN npm install --global gulp

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -L https://github.com/docker/compose/releases/download/1.5.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

VOLUME ["/root/.docker"]
