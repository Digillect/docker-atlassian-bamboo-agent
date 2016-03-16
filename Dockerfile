FROM centos:7
MAINTAINER Gregory Nickonov <gregoryn@actis.ru>
LABEL com.aw.components.docker-engine.version="1.10.3" \
      com.aw.components.docker-compose.version="1.6.2"

# Docker Engine version to install
ENV DOCKER_ENGINE_VERSION 1.10.3
# Docker Compose version to install
ENV DOCKER_COMPOSE_VERSION 1.6.2

COPY docker.repo /etc/yum.repos.d/docker.repo

# Update system & install dependencies
RUN yum -y update \
	&& yum -q -y install git java-1.8.0-openjdk-devel openssl unzip wget which docker-engine-${DOCKER_ENGINE_VERSION} \
	&& yum -q -y clean all

# Installing docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Preparing agent environment
WORKDIR /root

COPY bamboo-agent.sh /root/bamboo-agent.sh
COPY bamboo-capabilities.properties /root/bamboo-capabilities.properties

#USER bamboo-agent
ENTRYPOINT ["/bin/bash", "-c", "/root/bamboo-agent.sh"]
