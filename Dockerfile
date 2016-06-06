FROM centos:7
MAINTAINER Gregory Nickonov <gregoryn@actis.ru>

# Set Engine/Compose versions to be used
ENV DOCKER_ENGINE_VERSION 1.11.1
ENV DOCKER_COMPOSE_VERSION 1.7.1

LABEL com.aw.components.docker-engine.version="${DOCKER_ENGINE_VERSION}" \
      com.aw.components.docker-compose.version="${DOCKER_COMPOSE_VERSION}"

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
