# Atlassian Bamboo agent with ability to run docker commands on host
This installation allows to execute docker commands on container host. To properly
run this agent use the following command line:

docker -e HOME=/root/ -e BAMBOO_SERVER=http://your.bamboo.server/ -v /usr/bin/docker:/usr/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -d actis/atlassian-bamboo-agent
