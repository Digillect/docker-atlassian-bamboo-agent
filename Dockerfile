FROM atlassian/bamboo-java-agent
MAINTAINER Gregory Nickonov, gregoryn@actis.ru
LABEL com.aw.components.docker-engine.version="1.9.1" \
      com.aw.components.docker-compose.version="1.5.2"

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
	&& apt-get update \
	&& apt-get install -qqy apt-transport-https --no-install-recommends \
	&& echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list \
	&& apt-get update \
    && apt-get install -qqy curl lxc ssh --no-install-recommends \
    && apt-get install -qqy docker-engine=1.9.1-0~trusty --no-install-recommends \
    && curl -L https://github.com/docker/compose/releases/download/1.5.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && rm -rf /var/lib/apt/lists/*

RUN /root/bamboo-update-capability.sh system.docker.executable /usr/bin/docker \
    && /root/bamboo-update-capability.sh system.builder.docker-compose.Docker\ Compose /usr/local/bin/docker-compose \
    && /root/bamboo-update-capability.sh docker-engine.version 1.9.1 \
    && /root/bamboo-update-capability.sh docker-compose.version 1.5.2
ENTRYPOINT ["/bin/sh", "-c", "/root/run-agent.sh"]
