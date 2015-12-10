FROM phusion/baseimage:latest

MAINTAINER George Vagenas - gvagenas@telestax.com
MAINTAINER Jean Deruelle - jean.deruelle@telestax.com
MAINTAINER Elfetheris Banos - eleftheris.banos@telestax.com

ENV DEBIAN_FRONTEND noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales

RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-cache search mysql-client-core
RUN apt-get update && apt-get install -y screen wget ipcalc bsdtar oracle-java7-installer mysql-client-core-5.6 openssl unzip nfs-common tcpdump && apt-get autoremove && apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN wget -qc https://mobicents.ci.cloudbees.com/view/RestComm/job/RestComm/lastSuccessfulBuild/artifact/Mobicents-Restcomm-JBoss-AS7-`wget -qO- https://mobicents.ci.cloudbees.com/view/RestComm/job/RestComm/lastSuccessfulBuild/artifact/restcomm-version.txt | cat`.zip -O- | bsdtar -xvf - -C /opt/ && mv /opt/Mobicents-Restcomm-JBoss-AS7-*/ /opt/Mobicents-Restcomm-JBoss-AS7/

ADD ./populate-update-mysqldb.sh /opt/Mobicents-Restcomm-JBoss-AS7/bin/restcomm/populate-update-mysqldb.sh
ADD ./create-mysql-datasource.sh /opt/Mobicents-Restcomm-JBoss-AS7/bin/restcomm/autoconfig.d/create-mysql-datasource.sh
ADD ./reconfigure-mysqldb.sh /opt/Mobicents-Restcomm-JBoss-AS7/bin/restcomm/autoconfig.d/reconfigure-mysqldb.sh
ADD ./ca-startcom.der /opt/Mobicents-Restcomm-JBoss-AS7/ca-startcom.der

EXPOSE 5080/udp
EXPOSE 5080/tcp
EXPOSE 5081/tcp
EXPOSE 5082/tcp
EXPOSE 5083/tcp
EXPOSE 8080/tcp
EXPOSE 8443/tcp
EXPOSE 5060/udp
EXPOSE 5060/tcp
EXPOSE 5061/tcp
EXPOSE 5062/tcp
EXPOSE 5063/tcp
EXPOSE 80/tcp
EXPOSE 443/tcp
EXPOSE 9990/tcp
EXPOSE 65000-65535/udp

RUN mkdir /etc/service/restcomm
ADD ./restcomm_service.sh /etc/service/restcomm/run
