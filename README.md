# RestComm Docker image

RestComm is a next generation Cloud Communications Platform to rapidly build voice, video, and messaging applications, using mainstream development skills. Created by the people at Telestax.


Using the RestComm docker image makes running RestComm easy and intuitive.

1. See the Quick Start User Guide - http://docs.telestax.com/restcomm-pages/
2. Please report any issues at https://github.com/RestComm/Restcomm-Docker/issues

### Build

To build the image:

First git clone this repository and then:

```docker build -t restcomm/restcomm:latest -f Dockerfile .```

__Make sure you don't skip the dot (.) at the end of the command__

__-t Name and optionally a tag in the 'name:tag' format__

__-f Docker file to use for build the container__

Docker official links:
[Docker build manual](https://docs.docker.com/engine/reference/commandline/build/)