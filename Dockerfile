FROM centos:7
MAINTAINER Gregory Nickonov <gregoryn@actis.ru>
LABEL com.aw.components.docker-engine.version="1.9.1" \
      com.aw.components.docker-compose.version="1.5.2"

# Maven version to install
ENV MAVEN_INSTALL_VERSION 3.3.9
# Gradle version to install
ENV GRADLE_INSTALL_VERSION 2.9
# Docker Engine version to install
ENV DOCKER_ENGINE_VERSION 1.9.1-1
# Docker Compose version to install
ENV DOCKER_COMPOSE_VERSION 1.5.2

COPY docker.repo /etc/yum.repos.d/docker.repo

# Update system & install dependencies
RUN yum -y update \
	&& yum -q -y install cvs subversion git mercurial java-1.7.0-openjdk-devel java-1.8.0-openjdk-devel ant unzip wget which xorg-x11-server-Xvfb docker-engine-${DOCKER_ENGINE_VERSION} \
	&& yum -q -y clean all

# Installing docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Install maven (see https://jira.atlassian.com/browse/BAM-16043)
RUN cd /tmp \
	&& wget ftp://mirror.reverse.net/pub/apache/maven/maven-3/${MAVEN_INSTALL_VERSION}/binaries/apache-maven-${MAVEN_INSTALL_VERSION}-bin.tar.gz \
	&& tar xf apache-maven-${MAVEN_INSTALL_VERSION}-bin.tar.gz -C /opt \
	&& rm -f apache-maven-${MAVEN_INSTALL_VERSION}-bin.tar.gz \
	&& ln -s /opt/apache-maven-${MAVEN_INSTALL_VERSION} /opt/apache-maven

# Install gradle
RUN cd /tmp \
	&& wget -q "https://services.gradle.org/distributions/gradle-${GRADLE_INSTALL_VERSION}-bin.zip" \
	&& unzip gradle-${GRADLE_INSTALL_VERSION}-bin.zip -d /opt \
	&& rm gradle-${GRADLE_INSTALL_VERSION}-bin.zip \
	&& ln -s /opt/gradle-${GRADLE_INSTALL_VERSION} /opt/gradle

# Create user and group for Bamboo
#RUN groupadd -r -g 900 bamboo-agent \
#	&& useradd -r -m -u 900 -g 900 bamboo-agent

# Preparing agent environment
WORKDIR /root

COPY bamboo-agent.sh /root/bamboo-agent.sh
COPY bamboo-capabilities.properties /root/bamboo-agent-home/bin/

#USER bamboo-agent
ENTRYPOINT ["/bin/bash", "-c", "/root/bamboo-agent.sh"]
