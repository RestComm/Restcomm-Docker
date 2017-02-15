FROM phusion/baseimage:latest

MAINTAINER George Vagenas - gvagenas@telestax.com
MAINTAINER Jean Deruelle - jean.deruelle@telestax.com
MAINTAINER Lefteris Banos - liblefty@telestax.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true |  /usr/bin/debconf-set-selections && \
locale-gen en_US en_US.UTF-8 && \
dpkg-reconfigure locales

RUN add-apt-repository ppa:webupd8team/java -y && \
apt-cache search mysql-client-core && \
apt-get update && apt-get install -y screen wget ipcalc bsdtar oracle-java7-installer mysql-client-core-5.7 openssl unzip nfs-common tcpdump dnsutils net-tools xmlstarlet && \
apt-get autoremove && \
apt-get autoclean && \
rm -rf /var/lib/apt/lists/*

# download restcomm
ENV install_dir /opt/Restcomm-JBoss-AS7
RUN wget -qO- https://mobicents.ci.cloudbees.com/view/RestComm/job/RestComm/lastSuccessfulBuild/artifact/restcomm-version.txt -O version.txt && mv version.txt /tmp/version
RUN wget -qc https://mobicents.ci.cloudbees.com/view/RestComm/job/RestComm/lastSuccessfulBuild/artifact/Restcomm-JBoss-AS7-`cat /tmp/version`.zip -O Restcomm-JBoss-AS7.zip && \
unzip Restcomm-JBoss-AS7.zip -d /opt/ && mv /opt/Restcomm-JBoss-AS7-*/ ${install_dir} && \
rm Restcomm-JBoss-AS7.zip

RUN mkdir -p /opt/embed/

ADD ./ca-startcom.der /opt/Restcomm-JBoss-AS7/ca-startcom.der
ADD ./cron_files/tcpdump_crontab /etc/cron.d/restcommtcpdump-cron
ADD ./cron_files/core_crontab /etc/cron.d/restcommcore-cron
ADD ./cron_files/mediaserver_crontab /etc/cron.d/restcommmediaserver-cron
ADD ./scripts/dockercleanup.sh /opt/embed/dockercleanup.sh
ADD ./scripts/docker_do.sh   /opt/embed/restcomm_docker.sh

RUN mkdir -p /etc/my_init.d

ADD ./scripts/restcomm_autoconf.sh /etc/my_init.d/restcomm1.sh
ADD ./scripts/restcomm_conf.sh /etc/my_init.d/restcomm2.sh
ADD ./scripts/restcomm_sslconf.sh /etc/my_init.d/restcomm3.sh
ADD ./scripts/restcomm_extconf.sh /etc/my_init.d/restcomm4.sh
ADD ./scripts/restcomm_toolsconf.sh /etc/my_init.d/restcomm5.sh
ADD ./scripts/restcomm-runlevels.sh /etc/my_init.d/restcomm6.sh
ADD ./scripts/restcomm_tag.sh /etc/my_init.d/restcomm7.sh

ADD ./scripts/restcomm_setenv.sh /tmp/.restcommenv.sh
ADD ./scripts/restcomm_service.sh /tmp/restcomm_service.sh
ADD ./scripts/rms_service.sh /tmp/rms_service.sh
ADD ./scripts/start-mediaserver.sh /tmp/start-mediaserver.sh
ADD ./scripts/start-restcomm.sh /tmp/start-restcomm.sh
ADD ./scripts/restcomm-olympus.sh /tmp/config-olympus.sh
RUN chmod +x /etc/my_init.d/restcomm*.sh
RUN chmod +x /tmp/.restcommenv.sh

EXPOSE 5080/udp  5080/tcp 5081/tcp 5082/tcp 5083/tcp 8080/tcp 8443/tcp 5060/udp 5060/tcp 5061/tcp 5062/tcp 5063/tcp 80/tcp 443/tcp 9990/tcp 65000-65535/udp





