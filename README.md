# Atlassian Bamboo agent with ability to run docker commands on host
This installation allows to execute docker commands on container host. To properly
run this agent use the following command line:

```
docker run -d --restart=always -e BAMBOO_SERVER=http://your.bamboo.server/ -v /var/run/docker.sock:/var/run/docker.sock actis/atlassian-bamboo-agent
```
