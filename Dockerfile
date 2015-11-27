FROM atlassian/bamboo-java-agent
MAINTAINER Gregory Nickonov, gregoryn@actis.ru

RUN apt-get update \
    && apt-get install -y curl lxc ssh --no-install-recommends \
    && curl -L https://github.com/docker/compose/releases/download/1.5.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && rm -rf /var/lib/apt/lists/*

RUN /root/bamboo-update-capability.sh system.docker.executable /usr/bin/docker
RUN /root/bamboo-update-capability.sh system.builder.docker-compose.Docker\ Compose /usr/local/bin/docker-compose

ENTRYPOINT ["/bin/sh", "-c", "/root/run-agent.sh"]
