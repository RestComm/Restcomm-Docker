#FROM ubuntu:14.04.2
FROM restcomm-base

MAINTAINER George Vagenas - gvagenas@telestax.com

RUN wget -c https://mobicents.ci.cloudbees.com/view/RestComm/job/RestComm/lastSuccessfulBuild/artifact/Mobicents-Restcomm-JBoss-AS7-7.2.2.617.zip -O /opt/Mobicents-Restcomm-JBoss-AS7.zip
RUN unzip /opt/Mobicents-Restcomm-JBoss-AS7.zip -d /opt
RUN ls -la /opt
RUN mv /opt/Mobicents-Restcomm-JBoss-AS7-*/ /opt/Mobicents-Restcomm-JBoss-AS7/
RUN rm -rf /opt/Mobicents-Restcomm-JBoss-AS7.zip
RUN mkdir /opt/restcomm_conf

EXPOSE 5080/udp
EXPOSE 5080/tcp
EXPOSE 8080/tcp
EXPOSE 64534-65535/udp

RUN mkdir /etc/service/restcomm
ADD ./restcomm_service.sh /etc/service/restcomm/run

RUN rm /opt/Mobicents-Restcomm-JBoss-AS7/bin/restcomm/start-restcomm.sh
ADD ./start-restcomm.sh /opt/Mobicents-Restcomm-JBoss-AS7/bin/restcomm/start-restcomm.sh
