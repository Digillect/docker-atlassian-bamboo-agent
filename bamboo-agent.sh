#!/bin/bash

cd /root 

if [ -z "${BAMBOO_SERVER}" ]; then
	echo "Bamboo server URL undefined!" >&2
	echo "Please set BAMBOO_SERVER environment variable to URL of your Bamboo instance." >&2
	exit 1
fi

BAMBOO_AGENT=atlassian-bamboo-agent-installer.jar

if [ ! -f ${BAMBOO_AGENT} ]; then
	echo "Downloading agent JAR..."
	wget "-O${BAMBOO_AGENT}" "${BAMBOO_SERVER}/agentServer/agentInstaller/${BAMBOO_AGENT}"
fi

if [ ! -f bamboo-agent-home/bamboo-agent.cfg.xml -a "${BAMBOO_AGENT_UUID}" != "" ]; then
	echo 'agentUuid='${BAMBOO_AGENT_UUID} >> bamboo-agent-home/bamboo-capabilities.properties
fi

echo "Setting up the environment..."
export LANG=en_US.UTF-8
export JAVA_TOOL_OPTIONS="-Dfile.encoding=utf-8 -Dsun.jnu.encoding=utf-8"

echo Starting Bamboo Agent...
java -jar "${BAMBOO_AGENT}" "${BAMBOO_SERVER}/agentServer/"
