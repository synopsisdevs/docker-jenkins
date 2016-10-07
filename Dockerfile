FROM jenkins:latest

MAINTAINER developers@synopsis.cz

ENV JENKINS_HOME /data/jenkins/home

ENV TZ Europe/Prague

ENV DOCKER_COMPOSE_VERSION 1.8.1

USER root

ENV BUILD_PACKAGES="apt-transport-https docker-engine npm nodejs-legacy ant rsync curl php7.0-cli php7.0-cgi php7.0-curl php7.0-mcrypt php7.0-mbstring php7.0-xml"

ADD docker.list /etc/apt/sources.list.d/docker.list

RUN apt-get clean \
    && apt-get update \
    && apt-get install -y apt-transport-https \
    && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && wget https://www.dotdeb.org/dotdeb.gpg \
    && apt-key add dotdeb.gpg \
    && apt-get update \
    && apt-get install -y $BUILD_PACKAGES \
    && apt-get clean

RUN npm install --global gulp

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

VOLUME ["/root/.docker"]
