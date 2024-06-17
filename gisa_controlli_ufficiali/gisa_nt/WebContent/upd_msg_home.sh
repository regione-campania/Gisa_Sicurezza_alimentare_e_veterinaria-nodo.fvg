
AMB=ufficiale
ENDP=gisa
FILE=/usr/share/apache-tomcat-8.0.33/webapps/gisa_nt/templates/avviso_messaggio_urgente.txt
psql -t -U postgres -h dbGISAL gisa -c "select * from dblink_get_messaggio_home('$AMB','$ENDP')" >${FILE}

