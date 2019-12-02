FROM alpine:3.10

ENV JDK_VERSION=openjdk8

RUN apk add --update --no-cache $JDK_VERSION busybox-suid unzip shadow wget curl bash tzdata msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f

WORKDIR /opt

RUN  wget https://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.2.5%20GA6/liferay-portal-tomcat-6.2-ce-ga6-20160112152609836.zip

COPY run.sh /usr/bin/run.sh
COPY initdb.sh /usr/bin/initdb.sh
RUN unzip liferay-portal-tomcat-6.2-ce-ga6-20160112152609836.zip && \
rm -rf /opt/*.zip && \
mv liferay-portal* liferay && \
mkdir -p /opt/liferay/custom_config && rm -rf /etc/localtime  && touch /etc/timezone /etc/localtime && \
adduser -D -u 1001 -h /opt/liferay liferay && \
usermod -aG 0 liferay && \
chown 1001 -R /opt /usr/bin/run.sh /etc/timezone /etc/localtime  && \
chgrp -R 0 /opt /usr/bin/run.sh /etc/timezone /etc/localtime && \
chmod g=u -R /opt /usr/bin/run.sh /etc/timezone /etc/localtime && \
chmod +x /usr/bin/run.sh /opt/liferay/tomcat*/bin/* && \
rm -rf /var/cache/apk/*

WORKDIR /opt/liferay

ENV HOME /opt/liferay

EXPOSE 8080 8009

USER 1001:0

CMD ["/usr/bin/run.sh"]