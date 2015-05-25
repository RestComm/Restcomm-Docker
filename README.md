# Restcomm Docker image

Restcomm is a next generation Cloud Communications Platform to rapidly build voice, video, and messaging applications, using mainstream development skills. Created by the people at Telestax.

Learn more at http://www.restcomm.com

Using the Restcomm docker image you will be able to run Restcomm with the minimum effort and no pain.

Restcomm binds to the ip address of the host and following ports:
- __http__: 8080
- __sip/udp__: 5080
- __sip/tcp__: 5080
- __sip/ws__: 5082 (Used for WebRTC)
- __rtp/udp__: 65000 - 65535

Please report any issues at https://github.com/gvagenas/Restcomm-Docker/issues

### Prerequisites
The image has been tested with Docker __1.6__.

### Supported Tags

* __latest:__ Using this tag you will get the latest Restcomm build
* __7.3.0:__ Using this tag you will get the Restcomm 7.3.0.GA release

### Environment variables

The Restcomm docker image supports a set of environment variables to configure the application.

* __STATIC_ADDRESS__ Set the public ip address that Restcomm should use
* __OUTBOUND_PROXY__ Set the SIP Outbound proxy
* __OUTBOUND_PROXY_USERNAME__ Set the SIP Outbound proxy username
* __OUTBOUND_PROXY_PASSWORD__ Set the SIP Outbound proxy password
* __MEDIASERVER_LOWEST_PORT__ Set the Media Server lowest RTP port
* __MEDIASERVER_HIGHEST_PORT__ Set the Media Server highest RTP port
* __PROVISION_PROVIDER__ Set the Provision Provider, choose one of the following: VI (VoipInnovation), BW (Bandwidth), NX (Nexmo), VB (Voxbone)
* __DID_LOGIN__ Set the DID Provider username
* __DID_PASSWORD__ Set the DID Provider password
* __DID_ENDPOINT__ Set the Endpoint ID for VoipInnovation Provision Provider
* __DID_SITEID__ Set the Site Id for Bandwidth Provision Provider
* __DID_ACCOUNTID__ Set the Account Id for Bandwidth Provision Provider
* __INTERFAX_USER__ Set the Interfax username
* __INTERFAX_PASSWORD__ Set the Interfax password
* __ISPEECH_KEY__ Set the iSpeech speech recognition key
* __VOICERSS_KEY__ Set the VoiceRss Text-To-Speech key
* __ACAPELA_APPLICATION__ Set the Acapela Text-To-Speech application key
* __ACAPELA_LOGIN__ Set the Acapela Text-To-Speech username
* __ACAPELA_PASSWORD__ Set the Acapela Text-To-Speech password


### Running the image

* __Using the default values__ ```docker run --name=restcomm -d -p 8080:8080 -p 5080:5080 -p 5082:5082 -p 5080:5080/udp -p 65000-65535:65000-65535/udp gvagenas/restcomm:7.3.0```
* __Provide your VoiceRSS key for Text-To-Speech by setting environment variable VOICERSS_KEY__ ```docker run -e  VOICERSS_KEY="YOUR_VOICESS_KEY_HERE" --name=restcomm -d -p 8080:8080 -p 5080:5080 -p 5082:5082 -p 5080:5080/udp -p 65000-65535:65000-65535/udp gvagenas/restcomm:7.3.0```
* __Provide your VoiceRSS key for Text-To-Speech and Outbound proxy by setting environment variable VOICERSS_KEY and OUTBOUND_PROXY__ ```docker run -e  VOICERSS_KEY="YOUR_VOICESS_KEY_HERE" -e OUTBOUND_PROXY="YOUR_OUTBOUND_PROXY_HERE" --name=restcomm -d -p 8080:8080 -p 5080:5080 -p 5082:5082 -p 5080:5080/udp -p 65000-65535:65000-65535/udp gvagenas/restcomm:7.3.0```
* __To automatically restart the container in case of a failure or host restart, you have to use the --restart-always flag__  ```docker run -e VOICERSS_KEY="YOUR_VOICESS_KEY_HERE" --name=restcomm --restart=always -d -p 8080:8080 -p 5080:5080 -p 5082:5082 -p 5080:5080/udp -p 65000-65535:65000-65535/udp gvagenas/restcomm:7.3.0```

***
__Important Notice for Restcomm networking__

When using a sip client that is not running on the same machine as the Restcomm docker image, for example when calling from sip desk phone to Restcomm docker image, you won't be able to properly setup the call and receive any RTP traffic, because Restcomm docker image will be using the ip address of the container, that docker assigned to the container, thus all the SIP and SDP messages will be tagged with the container's ip address that can't be reached outside the local machine.

The fix for that is to provide the IP Address of the host machine using the STATIC_ADDRESS environment variable so Restcomm will properly configured:

``` docker run -e  VOICERSS_KEY="YOUR_VOICESS_KEY_HERE" -e STATIC_ADDRESS="YOUR_HOST_IP_ADDRESS_HERE" -e OUTBOUND_PROXY="YOUR_OUTBOUND_PROXY_HERE" --name=restcomm -d -p 8080:8080 -p 5080:5080 -p 5082:5082  -p 5080:5080/udp -p 65000-65535:65000-65535/udp gvagenas/restcomm:7.3.0```

Using the STATIC_ADDRESS and given that the sip client can reach the host's ip address, you will be able now to properly setup a call and receive RTP traffic.
***

To stop container: _docker stop restcomm_

To start container: _docker start restcomm_

To remove container: _docker rm restcomm_

### Persist your work using shared filesystem

You can persist the logs, database, recordings, text-to-speech cache and RVD workspace using shared filesystem, so even if you stop and remove your container, your work won't be lost.

Download the [__restcomm_workspace__](https://github.com/gvagenas/Restcomm-Docker/blob/master/restcomm_workspace.zip?raw=true) that contains the default database, default RVD workspace and the required folders and unzip it to a folder in your filesystem.

Next run Restcomm image using the following volume arguments:

* Restcomm logs ```-v $YOUR_FOLDER/restcomm_workspace/restcomm/log:/opt/Mobicents-Restcomm-JBoss-AS7/standalone/log ```
* Restcomm recordings ```-v $YOUR_FOLDER/restcomm_workspace/restcomm/recordings:/opt/Mobicents-Restcomm-JBoss-AS7/standalone/deployments/restcomm.war/recordings```
* Restcomm tts cache ```-v $YOUR_FOLDER/restcomm_workspace/restcomm/cache:/opt/Mobicents-Restcomm-JBoss-AS7/standalone/deployments/restcomm.war/cache```
* Restcomm HSQL database ```-v $YOUR_FOLDER/restcomm_workspace/restcomm/data:/opt/Mobicents-Restcomm-JBoss-AS7/standalone/deployments/restcomm.war/WEB-INF/data/hsql```
* Media Server logs  
```-v $YOUR_FOLDER/restcomm_workspace/mms/log:/opt/Mobicents-Restcomm-JBoss-AS7/mediaserver/log```
* Restcomm Visual Designer workspace  ```-v $YOUR_FOLDER/restcomm_workspace/rvd/workspace:/opt/Mobicents-Restcomm-JBoss-AS7/standalone/deployments/restcomm-rvd.war/workspace```

For example if you unzip the _restcomm_workspace.zip_ to /opt/restcomm_workspace/ then the docker run command will be:
```docker run --name=restcomm --restart=always -d -e VOICERSS_KEY="YOUR_VOICERSS_KEY" -p 8080:8080 -p 5080:5080 -p 5080:5080/udp -p 65000-65535/udp -v /opt/restcomm_workspace/restcomm/log:/opt/Mobicents-Restcomm-JBoss-AS7/standalone/log -v /opt/restcomm_workspace/restcomm/recordings:/opt/Mobicents-Restcomm-JBoss-AS7/standalone/deployments/restcomm.war/recordings -v /opt/restcomm_workspace/restcomm/cache:/opt/Mobicents-Restcomm-JBoss-AS7/standalone/deployments/restcomm.war/cache -v /opt/restcomm_workspace/restcomm/data:/opt/Mobicents-Restcomm-JBoss-AS7/standalone/deployments/restcomm.war/WEB-INF/data/hsql -v /opt/restcomm_workspace/mms/log:/opt/Mobicents-Restcomm-JBoss-AS7/mediaserver/log -v /opt/restcomm_workspace/rvd/workspace:/opt/Mobicents-Restcomm-JBoss-AS7/standalone/deployments/restcomm-rvd.war/workspace gvagenas/restcomm:7.3.0```



### To get bash console (for debugging only)

You can start the container and get a bash console to manually setup Restcomm and test it using the following command:

```docker run --name=restcomm --entrypoint=/bin/bash -it -p 8080:8080 -p 5080:5080 -p 5080:5080/udp -p 65000-65535/udp gvagenas/restcomm:7.3.0```

### To execute a command at the container

```docker exec rc [command]```

For example

```docker exec rc ps -ef | grep java```
