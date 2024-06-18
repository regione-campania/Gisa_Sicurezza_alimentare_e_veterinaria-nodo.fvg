AMB=ufficiale
ENDP=bdu
FILE=/opt/tomcat/webapps/bdu/templates/avviso_messaggio_urgente.txt
psql -t -U bdu_owner -h dbBDUL bdu -c "select * from dblink_get_messaggio_home('$AMB','$ENDP')" >${FILE}
