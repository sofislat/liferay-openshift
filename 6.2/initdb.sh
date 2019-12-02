#!/bin/sh
set -e

if [ -z "$TIMEZONE" ]; then
	echo "···································································································"
	echo "---->  VARIABLE TIMEZONE NO SETEADA - INICIANDO CON VALORES POR DEFECTO"
	echo "---->  POSIBLES VALORES: America/Montevideo | America/El_Salvador"
	echo "···································································································"
else
	echo "···································································································"
	echo "---->  TIMEZONE SETEADO ENCONTRADO: " $TIMEZONE
	echo "···································································································"
	cat /usr/share/zoneinfo/$TIMEZONE > /etc/localtime && \
	echo $TIMEZONE > /etc/timezone
fi




echo "INICIANDO LIFERAY...."


if [ -f "/opt/liferay/custom_config/portal-setup-wizard.properties" ]; then

cat /opt/liferay/custom_config/portal-setup-wizard.properties > /opt/liferay/portal-setup-wizard.properties
echo "-----> ARCHIVO CONFIGURACION portal-setup-wizard.properties SETEADO"
exit 1
fi


if [ ! -d "/opt/liferay/data/initdb" ]; then

echo "----> INICIALIZANDO DATABASE"
/opt/liferay/tomcat*/bin/startup.sh

until curl --max-time 2 http://localhost:8080 &> /dev/null; do echo waiting for liferay; sleep 10; done;

mkdir -p /opt/liferay/data/initdb

exit 0

else 

echo "-----> LIFERAY DB YA FUE INICIALIZADO"
fi





