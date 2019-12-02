FROM alpine:3.10

ENV JDK_VERSION=openjdk8

RUN apk add --update --no-cache $JDK_VERSION busybox-suid shadow wget curl bash unzip tzdata msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f

WORKDIR /opt

RUN  wget https://github.com/liferay/liferay-portal/releases/download/7.2.0-ga1/liferay-ce-portal-tomcat-7.2.0-ga1-20190531153709761.tar.gz

COPY run.sh /usr/bin/run.sh

COPY setenv.sh /opt/setenv.sh

RUN mkdir -p /opt/liferay && tar zxvf liferay*.tar.gz -C /opt/liferay --strip-components 1 && rm -rf /opt/*.tar.gz && \
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

USER 1001

CMD ["/usr/bin/run.sh"]