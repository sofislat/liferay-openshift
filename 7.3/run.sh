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



if [ ! -z "$WAITFOR_HOST" ] && [ ! -z "$WAITFOR_PORT" ] ; then
	echo "···································································································"
	echo "---->  WAITFOR  ACTIVADO.."
    until nc -z -v -w5 $WAITFOR_HOST $WAITFOR_PORT &> /dev/null; do echo waiting for $WAITFOR_HOST; sleep 10; done;	
	echo "···································································································"
fi


echo "INICIANDO LIFERAY...."

if [ -f "/opt/liferay/custom_config/portal-setup-wizard.properties" ]; then

cat /opt/liferay/custom_config/portal-setup-wizard.properties > /opt/liferay/portal-setup-wizard.properties
echo "-----> ARCHIVO CONFIGURACION portal-setup-wizard.properties SETEADO"

fi

exec /opt/liferay/tomcat*/bin/catalina.sh run
