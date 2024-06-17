select * from master_list_aggregazione where rev=11 and aggregazione ilike '%PRODUZIONE E TRASFORMAZIONE MATERIALI DESTINATI A VENIRE A CONTATTO CON GLI ALIMENTI%'

insert into master_list_aggregazione(id_macroarea, codice_attivita, aggregazione, rev, entered, enteredby)
values (100, 'MCAC','COMMERCIO ALL''INGROSSO DI MATERIALI E OGGETTI DESTINATI A VENIRE A CONTATTO CON ALIMENTI',11,now(),6567);
insert into master_list_aggregazione(id_macroarea, codice_attivita, aggregazione, rev, entered, enteredby)
values (100, 'MCAT','PRODUZIONE, TRASFORMAZIONE E COMMERCIO MATERIALI A CONTATTO CON GLI ALIMENTI',11,now(),6567);

select * from master_list_aggregazione where rev=11 and aggregazione ilike '%COMMERCIO ALL''INGROSSO DI MATERIALI E OGGETTI DESTINATI A VENIRE A CONTATTO CON ALIMENTI%'
-- MCAC
select * from master_list_linea_attivita where linea_attivita ilike 
'%OGGETTI DESTINATI A VENIRE A CONTATTO CON ALIMENTI IN LOCALI CON SUPERFICIE TOTALE LORDA COMPRENSIVA DI SERVIZI E DEPOSITI INFERIORE A 400 MQ%'
update master_list_linea_attivita set id_aggregazione=20518, codice_univoco='MS.M-MCAC-A07P3' where id=41219;
select * from master_list_linea_attivita where linea_attivita ilike 
'%OGGETTI DESTINATI A VENIRE A CONTATTO CON ALIMENTI IN LOCALI CON SUPERFICIE TOTALE LORDA COMPRENSIVA DI SERVIZI E DEPOSITI superiore A 400 MQ%'
update master_list_linea_attivita set id_aggregazione=20518, codice_univoco='MS.M-MCAC-A07P3' where id=41220;

-- MCAT
select * from master_list_linea_attivita where linea_attivita ilike 
'%INTERMEDIARIO SENZA DEPOSITO%' and rev=11
select * from master_list_aggregazione where rev=11 and aggregazione ilike '%PRODUZIONE, TRASFORMAZIONE E COMMERCIO MATERIALI A CONTATTO CON GLI ALIMENTI%'
--update master_list_linea_attivita set id_aggregazione=20519, codice_univoco='MS.M-MCAT-INT' where id=41232;

select * from master_list_flag_linee_attivita where rev=11 and id_linea=41232;
update master_list_flag_linee_attivita set codice_univoco='MS.M-MCAT-INT' where id_linea=41232;
select * from master_list_flag_linee_attivita where rev=11 and id_linea=41219;
update master_list_flag_linee_attivita set codice_univoco='MS.M-MCAC-A07P3' where id_linea=41219;
select * from master_list_flag_linee_attivita where rev=11 and id_linea=41220;
update master_list_flag_linee_attivita set  codice_univoco='MS.M-MCAC-A07P3' where id_linea=41220;

select * from refresh_ml_materializzata()
select * from ml8_linee_attivita_nuove_materializzata  where id_attivita in (41219,41220,41232);