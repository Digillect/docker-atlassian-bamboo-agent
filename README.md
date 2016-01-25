# Atlassian Bamboo agent with ability to run docker commands on host
This installation allows to execute docker commands on container host. To properly
run this agent use the following command line:

```
docker run -d --restart=always -e HOME=/root/ -e BAMBOO_SERVER=http://your.bamboo.server/ -v /var/run/docker.sock:/var/run/docker.sock actis/atlassian-bamboo-agent
```

By default all agent-initiated docker commands are run on docker host. If you would like complete isolation from host then omit "-v /var/run/docker.sock:/var/run/docker.sock argument".
