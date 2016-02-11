#!/bin/bash

cd /root 

if [ -z "${BAMBOO_SERVER}" ]; then
	echo "Bamboo server URL undefined!" >&2
	echo "Please set BAMBOO_SERVER environment variable to URL of your Bamboo instance." >&2
	exit 1
fi

BAMBOO_AGENT=atlassian-bamboo-agent-installer.jar

if [ -z "${BAMBOO_AGENT_HOME}" ]; then
	export BAMBOO_AGENT_HOME=/var/lib/bamboo
fi

if [ ! -f ${BAMBOO_AGENT} ]; then
	echo "Downloading agent JAR..."
	wget "-O${BAMBOO_AGENT}" "${BAMBOO_SERVER}/agentServer/agentInstaller/${BAMBOO_AGENT}"
fi

if [ ! -d ${BAMBOO_AGENT_HOME}/bin ]; then
	mkdir -p ${BAMBOO_AGENT_HOME}/bin
fi

if [ ! -f ${BAMBOO_AGENT_HOME}/bin/bamboo-capabilities.properties ]; then
	cp bamboo-capabilities.properties ${BAMBOO_AGENT_HOME}/bin/
fi

if [ ! -f ${BAMBOO_AGENT_HOME}/bamboo-agent.cfg.xml -a "${BAMBOO_AGENT_UUID}" != "" ]; then
	echo 'agentUuid='${BAMBOO_AGENT_UUID} >> ${BAMBOO_AGENT_HOME}/bin/bamboo-capabilities.properties
fi

if [ ! -f ${BAMBOO_AGENT_HOME}/bamboo-agent.cfg.xml -a "${BAMBOO_AGENT_CAPABILITY}" != "" ]; then
	echo ${BAMBOO_AGENT_CAPABILITY} >> ${BAMBOO_AGENT_HOME}/bin/bamboo-capabilities.properties
fi

echo "Setting up the environment..."
export LANG=en_US.UTF-8
export JAVA_TOOL_OPTIONS="-Dfile.encoding=utf-8 -Dsun.jnu.encoding=utf-8"

echo Starting Bamboo Agent...
java -Dbamboo.home=${BAMBOO_AGENT_HOME} -jar "${BAMBOO_AGENT}" "${BAMBOO_SERVER}/agentServer/"
