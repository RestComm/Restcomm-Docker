FROM phusion/baseimage:latest

MAINTAINER George Vagenas - gvagenas@telestax.com
MAINTAINER Jean Deruelle - jean.deruelle@telestax.com
MAINTAINER Lefteris Banos - liblefty@telestax.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales

RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-cache search mysql-client-core
RUN apt-get update && apt-get install -y screen wget ipcalc bsdtar oracle-java7-installer mysql-client-core-5.6 openssl unzip nfs-common tcpdump && apt-get autoremove && apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN wget -qc https://mobicents.ci.cloudbees.com/view/RestComm/job/RestComm/lastSuccessfulBuild/artifact/Mobicents-Restcomm-JBoss-AS7-`wget -qO- https://mobicents.ci.cloudbees.com/view/RestComm/job/RestComm/lastSuccessfulBuild/artifact/restcomm-version.txt | cat`.zip -O- | bsdtar -xvf - -C /opt/ && mv /opt/Mobicents-Restcomm-JBoss-AS7-*/ /opt/Mobicents-Restcomm-JBoss-AS7/

RUN mkdir -p /var/log/restcomm
RUN mkdir -p /opt/embed/
RUN mkdir -p var/log/restcomm/opt/

ADD ./scripts/populate-update-mysqldb.sh /opt/Mobicents-Restcomm-JBoss-AS7/bin/restcomm/populate-update-mysqldb.sh
ADD ./scripts/create-mysql-datasource.sh /opt/Mobicents-Restcomm-JBoss-AS7/bin/restcomm/autoconfig.d/create-mysql-datasource.sh
ADD ./scripts/reconfigure-mysqldb.sh /opt/Mobicents-Restcomm-JBoss-AS7/bin/restcomm/autoconfig.d/reconfigure-mysqldb.sh
ADD ./ca-startcom.der /opt/Mobicents-Restcomm-JBoss-AS7/ca-startcom.der
ADD ./scripts/tcpdump_crontab /etc/cron.d/restcommtcpdump-cron
ADD ./scripts/core_crontab /etc/cron.d/restcommcore-cron
ADD ./scripts/mediaserver_crontab /etc/cron.d/restcommmediaserver-cron
ADD ./scripts/logs_collect.sh /opt/embed/logs_collect.sh
ADD ./scripts/docker_do.sh   /opt/embed/restcomm_docker.sh


RUN touch /var/log/cron.log

RUN mkdir -p /etc/my_init.d

ADD ./scripts/automate_conf.sh /etc/my_init.d/restcommautomate.sh
ADD ./scripts/restcomm_setenv.sh /etc/my_init.d/restcommbenv.sh
ADD ./scripts/restcomm_conf.sh /etc/my_init.d/restcommconf.sh
ADD ./scripts/restcomm_sslconf.sh /etc/my_init.d/restcommsslconf.sh
ADD ./scripts/restcomm_toolsconf.sh /etc/my_init.d/restcommtoolsconf.sh
RUN chmod +x /etc/my_init.d/restcomm*.sh

RUN chmod +x /opt/embed/*.sh
#RUN /bin/bash -c "source /opt/embed/restcommenv.sh"

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
ADD ./scripts/restcomm_service.sh /etc/service/restcomm/run


