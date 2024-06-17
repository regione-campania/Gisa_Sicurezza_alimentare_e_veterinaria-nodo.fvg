-- PER FAR PUNTARE COLLAUDO AI SERVIZI DI TEST

select * from ws_endpoint_info where id in (13,15,17);

update ws_endpoint_info set url = 'https://bdrtest.izs.it/wsBDNInterrogazioni/wsAziendeQry.asmx', password = 'Na!izs34' where id in (13,15,17);

--https://bdrizsam.izs.it/wsBDNInterrogazioni/wsAziendeQry.asmx
--na.izs34