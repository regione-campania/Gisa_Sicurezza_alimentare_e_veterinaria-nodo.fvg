AMB=ufficiale
ENDP=vam
FILE=/opt/tomcat/webapps/vam/jsp/messaggi/messaggio.txt
psql -t -U vam_owner -h dbVAML vam -c "select regexp_replace((select * from dblink_get_messaggio_home('$AMB','$ENDP')),'(\<center\>)|(\<\/center\>)|(\<h1\>)|(\<\/h1\>)','','gi')" >${FILE}


