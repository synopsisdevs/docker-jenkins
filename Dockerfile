FROM jenkins:latest

MAINTAINER developers@synopsis.cz

ENV JENKINS_HOME /data/jenkins/home

USER root
RUN apt-get update && apt-get install -y apt-transport-https && apt-get clean
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

ADD docker.list /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y docker-engine npm nodejs-legacy ant rsync && apt-get clean
RUN npm install --global gulp

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -L https://github.com/docker/compose/releases/download/1.5.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN deb http://packages.dotdeb.org <distribution> all \
    && deb-src http://packages.dotdeb.org <distribution> all \
    && wget https://www.dotdeb.org/dotdeb.gpg \
    && apt-key add dotdeb.gpg \
    && apt-get update \
    && apt-get install -y php7.0-cli php7.0-cgi php7.0-curl php7.0-mcrypt  \
    && apt-get clean

VOLUME ["/root/.docker"]
