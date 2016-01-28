# RestComm Docker image

RestComm is a next generation Cloud Communications Platform to rapidly build voice, video, and messaging applications, using mainstream development skills. Created by the people at Telestax.

Learn more at http://www.restcomm.com

Using the RestComm docker image you will be able to run RestComm with the minimum effort and no pain.

Please report any issues at https://github.com/mobicents/Restcomm-Docker/issues

### Prerequisites
The image has been tested with Docker __1.7__ && __1.9__.
Install docker on your server as explained __HERE https://docs.docker.com/engine/installation/
Get a free API KEY VoiceRss account as explained _HERE

### Supported Tags

* __latest:__ Using this tag you will get the latest Restcomm build. __mobicents/restcomm:latest__
* __7.4.0:__ Using this tag you will get the Restcomm 7.4.0.GA release. __mobicents/restcomm:7.4.0__
* __7.3.1:__ Using this tag you will get the Restcomm 7.3.1.GA release. __mobicents/restcomm:7.3.1__
* __7.3.0:__ Using this tag you will get the Restcomm 7.3.0.GA release. __mobicents/restcomm:7.3.0__

### Install and Run Restcomm Docker

sudo docker run -e USE_STANDARD_PORTS="true" -e VOICERSS_KEY="YOUR_API_KEY" --name=restcomm-myInstance -d -p 80:80 -p 443:443 -p 9990:9990 -p 5060:5060 -p 5061:5061 -p 5062:5062 -p 5063:5063 -p 5060:5060/udp -p 65000-65535:65000-65535/udp mobicents/restcomm:latest

***

__Quick test__

Get the Docker IP address by running ifconfig command

docker0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.17.42.1 

1. Go to ```http://DOCKER_IP_ADDRESS/olympus```
2. Press "Sign in" (username alice or bob and password 1234)
3. Your browser will ask for permission to share microphone and camera, press allow
4. Go to "Contact", click on the "+1234" and press the "Audio Call" button (phone icon)
5. You should hear the "Welcome to RestComm, a Telestax Sponsored project" announcement
6. You can also make a calll to the "+1235" to test your Text-to-Speech configuration

Accessing the Admin UI :

1. Go to ```http://DOCKER_IP_ADDRESS```
2. Username = administrator@company.com
3. Password = RestCom
4. Change the default password

***
## Basic Docker commands
To Get a list of running containers: sudo docker ps
To stop container: _docker stop RESTCOMM_Container_ID
To start container: _docker start RESTCOMM_Container_ID
To remove container: _docker rm RESTCOMM_Container_ID

### To execute a command at the container

```docker exec RESTCOMM_Container_ID [command]```
Example
```docker exec rc ps -ef | grep java```



### To get bash console (for debugging only)

You can start the container and get a bash console to manually setup Restcomm and test it using the following command:

```docker run --name=restcomm --entrypoint=/bin/bash -it -p 8080:8080 -p 5080:5080 -p 5082:5082 -p 5080:5080/udp -p 65000-65535/udp mobicents/restcomm:latest```




__Important Notice for RestComm networking__

When using a sip client that is not running on the same machine as the RestComm docker image, for example when calling from sip desk phone to Restcomm docker image, you won't be able to properly setup the call and receive any RTP traffic, because Restcomm docker image will be using the ip address of the container, that docker assigned to the container, thus all the SIP and SDP messages will be tagged with the container's ip address that can't be reached outside the local machine.

The fix for that is to provide the IP Address of the host machine using the STATIC_ADDRESS environment variable so RestComm will properly configured:

``` docker run -e USE_STANDARD_PORTS="true" -e  VOICERSS_KEY="YOUR_VOICESS_KEY_HERE" -e HOSTNAME="YOUR_HOST_IP_ADDRESS_OR_DNS_HOSTNAME-HERE" -e STATIC_ADDRESS="YOUR_HOST_IP_ADDRESS_HERE" -e OUTBOUND_PROXY="YOUR_OUTBOUND_PROXY_HERE" --name=restcomm -d -p 80:80 -p 443:443 -p 9990:9990 -p 5060:5060 -p 5061:5061 -p 5062:5062 -p 5063:5063 -p 5060:5060/udp -p 65000-65535:65000-65535/udp mobicents/restcomm:latest```

Using the STATIC_ADDRESS and given that the sip client can reach the host's ip address, you will be able now to properly setup a call and receive RTP traffic.


###Known Issue on Firefox###
It is possible that you will not be able to log in to olympus the first time that you will try to connect using Firefox.
To fix this problem please follow the solution provided by [__Faisal Mq__](http://stackoverflow.com/users/379916/faisal-mq) 
on [__http://stackoverflow.com/__](http://stackoverflow.com/questions/11542460/secure-websocket-wss-doesnt-work-on-firefox).
```When you would try to open up wss say using wss://IP:5063, Firefox will keep on giving you error until you open up a separate 
Firefox tab and do try hitting URL [https]://IP:5063 and Confirm Security Exception 
(like you do on Firefox normally for any https based connection). This only happens in Firefox.```

