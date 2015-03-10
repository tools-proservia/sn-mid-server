# docker ServiceNow MID Server

This is a Dockerfile to set up "ServiceNow MID Server" - (http://wiki.servicenow.com/index.php?title=MID_Server_Installation)

## Build from docker file

```
git clone https://github.com/tools-proservia/sn-mid-server.git
cd sn-mid-server
docker build -t sn-mid-server .
```

## How to use this image

### start a MID Server instance

This image includes EXPOSE 80 (the web services port)

```
docker run -d --name demonightlyeureka \
  -e 'SN_URL=demonightlyeureka' \
  -e 'SN_USER=admin' \
  -e 'SN_PASSWD=admin' \
  -e 'SN_MID_NAME=my_mid' \
  toolsproservia/sn-mid-server
```

### generate config.xml file

```
docker run --rm \
  -e 'SN_URL=demonightlyeureka' \
  -e 'SN_USER=admin' \
  -e 'SN_PASSWD=admin' \
  -e 'SN_MID_NAME=my_personnal_mid' \
  toolsproservia/sn-mid-server mid:setup > /my_directory/demonightlyeureka/config.xml
```

### start with persistent storage

```
docker run -d --name demonightlyeureka \
  -v /my_directory/demonightlyeureka/logs:/opt/agent/logs \
  -v /my_directory/demonightlyeureka/config.xml:/opt/agent/config.xml \
  toolsproservia/sn-mid-server
```

## Help

    Available options:
     mid:start          - Starts the mid server (default)
     mid:setup          - Generate config.xml
     mid:help           - Displays the help
     [command]          - Execute the specified linux command eg. bash.
