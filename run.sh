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
cp -rf /opt/setenv.sh /opt/liferay/tomcat-*/bin/
cat /opt/liferay/custom_config/portal-setup-wizard.properties > /opt/liferay/portal-setup-wizard.properties
sleep 2s
exec /opt/liferay/tomcat*/bin/catalina.sh "$@"
