[![](https://images.microbadger.com/badges/image/actis/atlassian-bamboo-agent.svg)](https://microbadger.com/images/actis/atlassian-bamboo-agent "Get your own image badge on microbadger.com")

# Atlassian Bamboo agent with ability to run docker commands on host
This installation allows to execute docker commands on container host. To properly
run this agent use the following command line:

```
docker run -d --restart=always -e BAMBOO_SERVER=http://your.bamboo.server/ -v /var/run/docker.sock:/var/run/docker.sock actis/atlassian-bamboo-agent
```

You can also pass environment variable BAMBOO_AGENT_CAPABILITY with content formatted as JAVA property (property=value) which will be added to agent capabilities.
