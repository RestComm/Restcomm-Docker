Restcomm Docker image
=====================

Maintainer George Vagenas - gvagenas@telestax.com

Restcomm is binds to the ip address of the host and following ports:
- http: 8080
- sip/udp: 5080
- sip/tcp: 5080
- rtp/udp: 65000 - 65535

### Prerequisites
Docker 1.6


### Build

To build the image:

First git clone this repository and then:

docker build -t restcomm -f Dockerfile .

*** Make sure you don't skip the dot (.) at the end

### Run

docker run --name=rc -d -p 8080:8080 -p 5080:5080 -p 5080:5080/udp -p 65000-65535/udp restcomm

### If you want to automatically restart the container in case of a failure or host reboot you need to add the --restart=always flag:

docker run --name=rc --restart=always -d -p 8080:8080 -p 5080:5080 -p 5080:5080/udp -p 65000-65535/udp restcomm

# To get bash console (for debugging only)
docker run --name=rc --entrypoint=/bin/bash -it -p 8080:8080 -p 5080:5080 -p 5080:5080/udp restcomm

# To get logs
docker logs rc

# To execute a command at the container
docker exec rc [command]
e.g. docker exec rc ps -ef | grep java
