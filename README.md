# Restcomm Docker image

Restcomm is a next generation Cloud Communications Platform to rapidly build voice, video, and messaging applications, using mainstream development skills. Created by the people at Telestax.

Learn more at http://www.restcomm.com

Using the Restcomm docker image you will be able to run Restcomm with the minimum effort and no pain.

Restcomm binds to the ip address of the host and following ports:
- __http__: 8080
- __sip/udp__: 5080
- __sip/tcp__: 5080
- __rtp/udp__: 65000 - 65535

Please report any issues at https://github.com/gvagenas/Restcomm-Docker/issues

### Prerequisites
The image has been tested with Docker __1.6__.

### Supported Tags

* __latest:__ Using this tag you will get the latest Restcomm build
* __7.3.0:__ Using this tag you will get the Restcomm 7.3.0.GA release

### Running the image


* __Using the default values__ ```docker run --name=restcomm -d -p 8080:8080 -p 5080:5080 -p 5080:5080/udp -p 65000-65535/udp docker pull gvagenas/restcomm:7.3.0```
* __Provide your VoiceRSS key for Text-To-Speech by setting enviroment variable VOICERSS_KEY__ ```docker run -e  VOICERSS_KEY="YOUR_VOICESS_KEY_HERE" --name=restcomm -d -p 8080:8080 -p 5080:5080 -p 5080:5080/udp -p 65000-65535/udp docker pull gvagenas/restcomm:7.3.0```
* __To automatically restart the container in case of a failure or host restart, you have to use the --restart-always flag__  ```docker run -e VOICERSS_KEY="YOUR_VOICESS_KEY_HERE" --name=restcomm --restart=always -d -p 8080:8080 -p 5080:5080 -p 5080:5080/udp -p 65000-65535/udp docker pull gvagenas/restcomm:7.3.0```

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
