# RestComm Docker image

RestComm is a next generation Cloud Communications Platform to rapidly build voice, video, and messaging applications, using mainstream development skills. Created by the people at Telestax.

Learn more at http://www.restcomm.com

Using the RestComm docker image you will be able to run RestComm with the minimum effort and no pain.

Please report any issues at https://github.com/mobicents/Restcomm-Docker/issues

***
### Prerequisites

1. The image has been tested with Docker __1.7__ && __1.9__.
2. Install docker on your sever : https://docs.docker.com/engine/installation/
3. Get a free API KEY VoiceRss account as explained  http://www.voicerss.org/
4. Ensure firewall is correctly configured (***Selinux can be a problem on some systems***)
***
### Supported Tags

* __latest:__ Using this tag you will get the latest Restcomm build. __mobicents/restcomm:latest__
* __7.4.0:__ Using this tag you will get the Restcomm 7.4.0.GA release. __mobicents/restcomm:7.4.0__
* __7.3.1:__ Using this tag you will get the Restcomm 7.3.1.GA release. __mobicents/restcomm:7.3.1__
* __7.3.0:__ Using this tag you will get the Restcomm 7.3.0.GA release. __mobicents/restcomm:7.3.0__
***
### Install and Run Restcomm Docker

1. Get your "ETHERNET_IP" by running ifconfig
2. Fill out the STATIC_ADDRESS variable as shown below
3. Start Restcomm as shown below:
4. This will start Restcomm in secure mode (https) 

docker run  -i -d --name=restcomm-myInstance -v /var/log/restcomm/:/var/log/restcomm/ -e STATIC_ADDRESS="YOUR_ETHERNET_IP" -e ENVCONFURL="https://raw.githubusercontent.com/RestComm/Restcomm-Docker/master/scripts/restcomm_env_locally.sh" -p 80:80 -p 443:443 -p 9990:9990 -p 5060:5060 -p 5061:5061 -p 5062:5062 -p 5063:5063 -p 5060:5060/udp -p 65000-65535:65000-65535/udp mobicents/restcomm:latest

***

### Text-to-Speech with VoiceRSS

* __ The above command comes with a community version of VoiceRSS key. This version has limited features. You may get a free VoiceRSS API key from http://www.voicerss.org/from __

* __ See the documentation about adding your own VoiceRSS API Key https://docs.telestax.com/restcomm-docker-advanced-configuration/ __

***

### Quick test

* __  Get the Docker IP address by running ifconfig command __
* __  docker0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500 inet 172.17.42.1  __


1. Go to ```https://DOCKER_IP_ADDRESS/olympus```
2. Press "Sign in" (username alice or bob and password 1234)
3. Your browser will ask for permission to share microphone and camera, press allow
4. Go to "Contact", click on the "+1234" and press the "Audio Call" button (phone icon)
5. You should hear the "Welcome to RestComm, a Telestax Sponsored project" announcement
6. You can also make a calll to the "+1235" to test your Text-to-Speech configuration

### Accessing the Admin UI :

1. Go to ```https://DOCKER_IP_ADDRESS```
2. Username = administrator@company.com
3. Password = RestCom
4. Change the default password

***
### Basic Docker commands

1. To Get a list of running containers: sudo docker ps
2. To stop container: sudo docker stop RESTCOMM_Container_ID
3. To start container: sudo docker start RESTCOMM_Container_ID
4. To remove container: sudo docker rm RESTCOMM_Container_ID

### To execute a command at the container
1. ```docker exec RESTCOMM_Container_ID [command]```
Example
1. ```docker exec RESTCOMM_Container_ID ps -ef | grep java```

***
### To get bash console (for debugging only)

You can start the container and get a bash console to manually setup Restcomm and test it using the following command:

```docker run --name=restcomm-myInstance --entrypoint=/bin/bash -it -p 8080:8080 -p 5080:5080 -p 5082:5082 -p 5080:5080/udp -p 65000-65535/udp mobicents/restcomm:latest```

***
### For Advanced Restcomm Features and Configuration

1. Go to http://docs.telestax.com/restcomm-pages/


***

### Important Notice for RestComm networking

When using a SIP client that is not running on the same local machine as the RestComm docker container, call-setup through SIP/SDP/RTP will fail as the docker container runs on a different network segment. You must set the STATIC_ADDRESS environment variable to address this issue as shown below:


``` docker run -e USE_STANDARD_PORTS="true" -e  VOICERSS_KEY="YOUR_VOICESS_KEY_HERE" -e HOSTNAME="YOUR_HOST_IP_ADDRESS_OR_DNS_HOSTNAME-HERE" -e STATIC_ADDRESS="YOUR_HOST_IP_ADDRESS_HERE" -e OUTBOUND_PROXY="YOUR_OUTBOUND_PROXY_HERE" --name=restcomm -d -p 80:80 -p 443:443 -p 9990:9990 -p 5060:5060 -p 5061:5061 -p 5062:5062 -p 5063:5063 -p 5060:5060/udp -p 65000-65535:65000-65535/udp mobicents/restcomm:latest```

***

### Known Issue on Firefox when running Restcomm Olympus 

It is possible that you will not be able to log in to olympus the first time that you will try to connect using Firefox.
To fix this problem please follow the solution provided by [__Faisal Mq__](http://stackoverflow.com/users/379916/faisal-mq) 
on [__http://stackoverflow.com/__](http://stackoverflow.com/questions/11542460/secure-websocket-wss-doesnt-work-on-firefox).
```When you would try to open up wss say using wss://IP:5063, Firefox will keep on giving you error until you open up a separate 
Firefox tab and do try hitting URL [https]://IP:5063 and Confirm Security Exception 
(like you do on Firefox normally for any https based connection). This only happens in Firefox.```

