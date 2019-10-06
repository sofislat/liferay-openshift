#!/bin/sh
set -e

if [ -z "$TIMEZONE" ]; then
echo "···································································································"
echo "VARIABLE TIMEZONE NO SETEADA - INICIANDO CON VALORES POR DEFECTO"
echo "POSIBLES VALORES: America/Montevideo | America/El_Salvador"
echo "···································································································"
else
echo "···································································································"
echo "TIMEZONE SETEADO ENCONTRADO: " $TIMEZONE
echo "···································································································"
cat /usr/share/zoneinfo/$TIMEZONE >> /etc/localtime && \
echo $TIMEZONE >> /etc/timezone
fi

echo "INICIANDO LIFERAY...."
echo "CATALINA_OPTS='$CATALINA_OPTS -XX:MaxRAMFraction=1 -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Dfile.encoding=UTF8 -XX:+ExitOnOutOfMemoryError -Djava.net.preferIPv4Stack=true -Djava.locale.providers=JRE,COMPAT,CLDR -Duser.timezone=$TIMEZONE'" > /opt/liferay/tomcat*/bin/setenv.sh
sleep 2s
exec /opt/liferay/tomcat*/bin/catalina.sh "$@"
