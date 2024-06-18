
AMB=ufficiale
ENDP=gisa
FILE=/opt/tomcat/webapps/gisa_nt/templates/avviso_messaggio_urgente.txt
psql -t -U gisa_owner -h dbGISAL gisa -c "select * from dblink_get_messaggio_home('$AMB','$ENDP')" >${FILE}

