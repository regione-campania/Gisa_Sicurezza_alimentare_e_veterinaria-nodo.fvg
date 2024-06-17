--ATTENZIONE: NESSUN RECORD DI VALUE E' STATO INSERITO
--select * from master_list_linea_attivita where linea_attivita ilike'recapiti'

-- RQ1. LINEA RECAPITI 
select * from linee_mobili_html_fields where id_linea=40989 and enabled
-- disabilita campi
update linee_mobili_html_fields set enabled=false where nome_campo = 'sesso' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'recapiti' and rev=11);
update linee_mobili_html_fields set enabled=false where nome_campo = 'data_nascita' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'recapiti' and rev=11);
update linee_mobili_html_fields set enabled=false where nome_campo = 'nazione_nascita' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'recapiti' and rev=11);
update linee_mobili_html_fields set enabled=false where nome_campo = 'comune_nascita' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'recapiti' and rev=11);
update linee_mobili_html_fields set enabled=false where nome_campo = 'indirizzo_res_direttore'and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'recapiti' and rev=11);
update linee_mobili_html_fields set enabled=false where nome_campo = 'comune_res_direttore' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'recapiti' and rev=11);
update linee_mobili_html_fields set enabled=false where nome_campo = 'provincia_res_direttore'and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'recapiti' and rev=11);
update linee_mobili_html_fields set enabled=false where nome_campo = 'codice_iscrizione_elenco_regionale' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'recapiti' and rev=11);
-- rinomina campi
update linee_mobili_html_fields set label_campo='Nome' where label_campo = 'Nome direttore' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'recapiti' and rev=11);
update linee_mobili_html_fields set label_campo='Cognome' where label_campo = 'Cognome direttore' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'recapiti' and rev=11);
update linee_mobili_html_fields set label_campo='Codice fiscale' where label_campo = 'Codice Fiscale direttore' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'recapiti' and rev=11);
update linee_mobili_html_fields set label_campo='Codice stazione' where nome_campo = 'codice_recapito' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'recapiti' and rev=11);
-- aggiunto campo nuovo
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo,label_campo,only_hd, obbligatorio, ordine, gestione_interna, enabled, readonly, codice_raggruppamento,notes_hd) 
values ((select id from master_list_linea_attivita  where linea_attivita ilike'recapiti' and rev=11),'titolo_studio','text','Titolo di studio (D.M. 403/2000 art.15 comma 1, lett.a)',0,true,4,true,true,false,'TITSTUSTU','Flusso 360: nuovo campo previsto per linea RECAPITI');
-- ordine rivisto
update linee_mobili_html_fields set ordine=3 where nome_campo='codice_fiscale' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'recapiti' and rev=11);
update linee_mobili_html_fields set label_link='', tabella_lookup='', javascript_function='', javascript_function_evento='', link_value='', dbi_generazione='' where id=1177
-- aggiunto campo nuovo
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo,label_campo,only_hd, obbligatorio, ordine, javascript_function_evento, gestione_interna, enabled, readonly, codice_raggruppamento,notes_hd) 
values ((select id from master_list_linea_attivita  where linea_attivita ilike 'RECAPITI' and rev=11),'dir_recapito','label','Direttore del recapito',0,false,0, 'disabled style="display:none"',true,true,true,'DIRRECREC','Flusso 360: nuovo campo previsto per linea RECAPITI');

/*insert into linee_mobili_fields_value (id_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, id_opu_rel_stab_linea, riferimento_org_id, note_hd)
(select id_rel_stab_linea, (select id from linee_mobili_html_fields where nome_campo='dir_recapito'), '', indice, enabled, 6567, now(), id_opu_rel_stab_linea, riferimento_org_id, 
 'Direttore del recapito: recupero campo aggiunto per Flusso 360'
	from linee_mobili_fields_value where id_linee_mobili_html_fields=(select id from linee_mobili_html_fields  where nome_campo='nome' and id_linea=
																	  (select id from master_list_linea_attivita  where linea_attivita ilike 'RECAPITI' and rev=11))
 limit 1
);*/
insert into linee_mobili_fields_value(id_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, id_opu_rel_stab_linea, riferimento_org_id, note_hd)
values (40989, (select id from linee_mobili_html_fields where nome_campo='titolo_studio'),'',1,true,6567,now(),434793, 361360,'Titolo di studio: recupero campo aggiunto per Flusso 360')

--RQ1.CENTRO PRODUZIONE MATERIALE SEMINALE
-- disabilita
update linee_mobili_html_fields set enabled=false where label_campo = 'Sesso' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'CENTRO PRODUZIONE MATERIALE SEMINALE' and rev=11);
-- rinomina campi
update linee_mobili_html_fields set label_campo='Indirizzo residenza' where label_campo = 'Indirizzo' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'CENTRO PRODUZIONE MATERIALE SEMINALE' and rev=11);
update linee_mobili_html_fields set label_campo='Comune residenza' where label_campo = 'Comune' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'CENTRO PRODUZIONE MATERIALE SEMINALE' and rev=11);
update linee_mobili_html_fields set label_campo='Provincia residenza' where label_campo = 'Provincia' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'CENTRO PRODUZIONE MATERIALE SEMINALE' and rev=11);
update linee_mobili_html_fields set label_campo='Codice centro' where label_campo = 'Codice Stazione' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'CENTRO PRODUZIONE MATERIALE SEMINALE' and rev=11);
-- ordine rivisto
update linee_mobili_html_fields set ordine=12 where label_campo='Provincia residenza' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'CENTRO PRODUZIONE MATERIALE SEMINALE' and rev=11);
update linee_mobili_html_fields set ordine=11 where label_campo='Comune residenza' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'CENTRO PRODUZIONE MATERIALE SEMINALE' and rev=11);
-- aggiunto campo nuovo
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo,label_campo,only_hd, obbligatorio, ordine, javascript_function_evento, gestione_interna, enabled, readonly, codice_raggruppamento,notes_hd) 
values ((select id from master_list_linea_attivita  where linea_attivita ilike 'CENTRO PRODUZIONE MATERIALE SEMINALE' and rev=11),'veterinario_responsabile','label','VETERINARIO RESPONSABILE',0,false,0, 'disabled style="display:none"',true,true,true,'VETRESRES','Flusso 360: nuovo campo previsto per linea CENTRO PRODUZIONE MATERIALE SEMINALE')
RETURNING ID;
/*insert into linee_mobili_fields_value (id_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, id_opu_rel_stab_linea, riferimento_org_id, note_hd)
(select id_rel_stab_linea, 1190, '', indice, enabled, 6567, now(), id_opu_rel_stab_linea, riferimento_org_id, 
 'Veterinario responsabile: recupero campo aggiunto per Flusso 360'
	from linee_mobili_fields_value where id_linee_mobili_html_fields=
 		(select id from linee_mobili_html_fields  where nome_campo='nome' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'CENTRO PRODUZIONE MATERIALE SEMINALE' and rev=11))
 LIMIT 1
);*/
--RQ1. CENTRO DI PRODUZIONE EMBRIONI
-- disabilita
update linee_mobili_html_fields set enabled=false where label_campo = 'Sesso' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'CENTRO DI PRODUZIONE EMBRIONI' and rev=11);
-- rinomina campi
update linee_mobili_html_fields set label_campo='Indirizzo residenza' where label_campo = 'Indirizzo' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'CENTRO DI PRODUZIONE EMBRIONI' and rev=11);
update linee_mobili_html_fields set label_campo='Comune residenza' where label_campo = 'Comune' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'CENTRO DI PRODUZIONE EMBRIONI' and rev=11);
update linee_mobili_html_fields set label_campo='Provincia residenza' where label_campo = 'Provincia' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'CENTRO DI PRODUZIONE EMBRIONI' and rev=11);
update linee_mobili_html_fields set label_campo='Codice centro' where label_campo = 'Codice Stazione' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'CENTRO DI PRODUZIONE EMBRIONI' and rev=11);
-- ordine rivisto
update linee_mobili_html_fields set ordine=12 where label_campo='Provincia residenza' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'CENTRO DI PRODUZIONE EMBRIONI' and rev=11);
update linee_mobili_html_fields set ordine=11 where label_campo='Comune residenza' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'CENTRO DI PRODUZIONE EMBRIONI' and rev=11);
-- aggiunto campo nuovo
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo,label_campo,only_hd, obbligatorio, ordine, javascript_function_evento, gestione_interna, enabled, readonly, codice_raggruppamento,notes_hd) 
values ((select id from master_list_linea_attivita  where linea_attivita ilike 'CENTRO DI PRODUZIONE EMBRIONI' and rev=11),'veterinario_direttore_sanitario','label','Veterinario Direttore Sanitario',0,false,0, 'disabled style="display:none"',true,true,true,'VETDIRSAN','Flusso 360: nuovo campo previsto per linea CENTRO DI PRODUZIONE EMBRIONI');
/*insert into linee_mobili_fields_value (id_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, id_opu_rel_stab_linea, riferimento_org_id, note_hd)
(select id_rel_stab_linea, (select id from linee_mobili_html_fields where nome_campo='veterinario_direttore_sanitario'), '', indice, enabled, 6567, now(), id_opu_rel_stab_linea, riferimento_org_id, 
 'Veterinario direttore sanitario: recupero campo aggiunto per Flusso 360'
	from linee_mobili_fields_value where id_linee_mobili_html_fields=(select id from linee_mobili_html_fields  where nome_campo='nome' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'CENTRO DI PRODUZIONE EMBRIONI' and rev=11) limit 1)
);*/


--RQ1.STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA
-- disabilita
update linee_mobili_html_fields set enabled=false where label_campo = 'Sesso' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11);
-- rinomina campi
update linee_mobili_html_fields set label_campo='Indirizzo residenza' where label_campo = 'Indirizzo' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11);
update linee_mobili_html_fields set label_campo='Comune residenza' where label_campo = 'Comune' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11);
update linee_mobili_html_fields set label_campo='Provincia residenza' where label_campo = 'Provincia' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11);
-- ordine rivisto
update linee_mobili_html_fields set ordine=12 where label_campo='Provincia residenza' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11);
update linee_mobili_html_fields set ordine=11 where label_campo='Comune residenza' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11);
-- aggiunto campo nuovo
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo,label_campo,only_hd, obbligatorio, ordine, javascript_function_evento, gestione_interna, enabled, readonly, codice_raggruppamento,notes_hd) 
values ((select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11),'veterinario_responsabile','label','Veterinario Responsabile',0,false,0, 'disabled style="display:none"',true,true,true,'VETRESRES','Flusso 360: nuovo campo previsto per linea STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA');

-- inserimento del campo fittizio (trovare gli stabilimenti e aggiungere i record)
/*insert into linee_mobili_fields_value(id_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, id_opu_rel_stab_linea, riferimento_org_id, note_hd)
values (434853, (select id from linee_mobili_html_fields where nome_campo='veterinario_responsabile'),'',1,true,6567,now(),434853, 361361,'Veterinario Responsabile: recupero campo aggiunto per Flusso 360')
*/

-- GESTORE (ordine 20)
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo,label_campo,only_hd, obbligatorio, ordine, javascript_function_evento, gestione_interna, enabled, readonly, codice_raggruppamento,notes_hd) 
values ((select id from master_list_linea_attivita where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11),'gestore','text','Gestore',0,false,20,'disabled style="display:none"', true,true,true,'GESGESGES','Flusso 360: nuovo campo previsto per linea STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA');

-- aggiungiamo nome, cognome, codice fiscale, titolo di studio (* D.M. 403/2000 art.3 comma1, lett.c), codice stazione
insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo,label_campo,tabella_lookup, javascript_function, javascript_function_evento, link_value, 
									  only_hd, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, codice_raggruppamento, notes_hd)
(select id_linea, 'nome_gestore', tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
									  only_hd, obbligatorio, gestione_interna, 21, enabled, readonly, dbi_generazione, 'NOMNOMGES', 'Flusso 360: nuovo campo previsto per linea STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' 
from linee_mobili_html_fields where id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11)
and nome_campo='nome');
insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo,label_campo,tabella_lookup, javascript_function, javascript_function_evento, link_value, 
									  only_hd, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, codice_raggruppamento, notes_hd)
(select id_linea, 'cognome_gestore', tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
									  only_hd, obbligatorio, gestione_interna, 22, enabled, readonly, dbi_generazione, 'COGCOGGES', 'Flusso 360: nuovo campo previsto per linea STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' 
from linee_mobili_html_fields where id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11)
and nome_campo='cognome');
insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo,label_campo,tabella_lookup, javascript_function, javascript_function_evento, link_value, 
									  only_hd, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, codice_raggruppamento, notes_hd)
(select id_linea, 'codice_fiscale_gestore', tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
									  only_hd, obbligatorio, gestione_interna, 23, enabled, readonly, dbi_generazione, 'CODFISGES', 'Flusso 360: nuovo campo previsto per linea STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' 
from linee_mobili_html_fields where id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11)
and nome_campo='codice_fiscale');
insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo,label_campo,tabella_lookup, javascript_function, javascript_function_evento, link_value, 
									  only_hd, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, codice_raggruppamento, notes_hd)
(select (select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11), 'titolo_studio_gestore', tipo_campo, 'Titolo di studio (* D.M. 403/2000 art.3 comma1, lett.c)', tabella_lookup, javascript_function, javascript_function_evento, link_value, 
									  only_hd, obbligatorio, gestione_interna, 24, enabled, readonly, dbi_generazione, 'TITSTUSTU', 'Flusso 360: nuovo campo previsto per linea STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' 
from linee_mobili_html_fields where id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'RECAPITI' and rev=11)
and nome_campo='titolo_studio');
-- inserire nei values i nuovi campi
/*insert into linee_mobili_fields_value(id_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, id_opu_rel_stab_linea, riferimento_org_id, note_hd)
values (434853, (select id from linee_mobili_html_fields where nome_campo='gestore'),'',1,true,6567,now(),434853, 361361,'Gestore: recupero campo aggiunto per Flusso 360')

insert into linee_mobili_fields_value (id_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, id_opu_rel_stab_linea, riferimento_org_id, note_hd)
(select id_rel_stab_linea, (select id from linee_mobili_html_fields where nome_campo='nome_gestore'), '', indice, enabled, 6567, now(), id_opu_rel_stab_linea, riferimento_org_id, 
 'Nome Gestore: recupero campo aggiunto per Flusso 360'
	from linee_mobili_fields_value where id_linee_mobili_html_fields=(select id from linee_mobili_html_fields  where nome_campo='nome' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11))
);
insert into linee_mobili_fields_value (id_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, id_opu_rel_stab_linea, riferimento_org_id, note_hd)
(select id_rel_stab_linea, (select id from linee_mobili_html_fields where nome_campo='cognome_gestore'), '', indice, enabled, 6567, now(), id_opu_rel_stab_linea, riferimento_org_id, 
 'Cognome Gestore: recupero campo aggiunto per Flusso 360'
	from linee_mobili_fields_value where id_linee_mobili_html_fields=(select id from linee_mobili_html_fields  where nome_campo='nome' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11))
);
insert into linee_mobili_fields_value (id_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, id_opu_rel_stab_linea, riferimento_org_id, note_hd)
(select id_rel_stab_linea, (select id from linee_mobili_html_fields where nome_campo='codice_fiscale_gestore'), '', indice, enabled, 6567, now(), id_opu_rel_stab_linea, riferimento_org_id, 
 'Codice Fiscale Gestore: recupero campo aggiunto per Flusso 360'
	from linee_mobili_fields_value where id_linee_mobili_html_fields=(select id from linee_mobili_html_fields  where nome_campo='nome' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11))
);
insert into linee_mobili_fields_value (id_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, id_opu_rel_stab_linea, riferimento_org_id, note_hd)
(select id_rel_stab_linea, (select id from linee_mobili_html_fields where nome_campo='titolo_studio_gestore'), '', indice, enabled, 6567, now(), id_opu_rel_stab_linea, riferimento_org_id, 
 'Titolo Studio Gestore: recupero campo aggiunto per Flusso 360'
	from linee_mobili_fields_value where id_linee_mobili_html_fields=(select id from linee_mobili_html_fields  where nome_campo='nome' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11))
);*/

-- svuotare se necessario i campi 
update linee_mobili_html_fields set label_link='', tabella_lookup='', javascript_function='', link_value='', dbi_generazione='' where id=?

-- aggiornare le label chiave
update linee_mobili_html_fields set label_campo='Nome Gestore' where nome_campo='nome_gestore' and id_linea= (select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11);
update linee_mobili_html_fields set label_campo='Cognome Gestore' where nome_campo='cognome_gestore' and id_linea= (select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11);
update linee_mobili_html_fields set label_campo='Codice fiscale Gestore' where nome_campo='codice_fiscale_gestore' and id_linea= (select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA' and rev=11);

-- RQ1. LINEA STAZIONE MONTA NATURALE EQUINA PUBBLICA
-- disabilita campi
update linee_mobili_html_fields set enabled=false where nome_campo = 'sesso' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11);
update linee_mobili_html_fields set enabled=false where nome_campo = 'data_nascita' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11);
update linee_mobili_html_fields set enabled=false where nome_campo = 'nazione_nascita' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11);
update linee_mobili_html_fields set enabled=false where nome_campo = 'comune_nascita' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE MONTA NATURALE EQUINA PUBBLICA'and rev=11);
update linee_mobili_html_fields set enabled=false where nome_campo = 'indirizzo_res_medico'and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11);
update linee_mobili_html_fields set enabled=false where nome_campo = 'comune_res_medico' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11);
update linee_mobili_html_fields set enabled=false where nome_campo = 'provincia_res_medico'and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11);
update linee_mobili_html_fields set enabled=false where nome_campo = 'codice_iscrizione_elenco_regionale' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11);
-- rinomina label
update linee_mobili_html_fields set label_campo='Nome' where nome_campo='nome' and id_linea= (select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11);
update linee_mobili_html_fields set label_campo='Cognome' where nome_campo='cognome' and id_linea= (select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11);
update linee_mobili_html_fields set label_campo='Codice fiscale' where nome_campo='codice_fiscale' and id_linea= (select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11);

-- aggiunto campo nuovo titolo
insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo,label_campo,tabella_lookup, javascript_function, javascript_function_evento, link_value, 
									  only_hd, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, codice_raggruppamento, notes_hd)
(select (select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11), 'titolo_studio', tipo_campo, 'Titolo di studio D.M. 403/2000 art.3 comma1, lett.c', tabella_lookup, javascript_function, javascript_function_evento, link_value, 
									  only_hd, obbligatorio, gestione_interna, 15, enabled, readonly, dbi_generazione, 'TITSTUSTU', 'Flusso 360: nuovo campo previsto per linea STAZIONE MONTA NATURALE EQUINA PUBBLICA' 
from linee_mobili_html_fields where id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'RECAPITI' and rev=11)
and nome_campo='titolo_studio');

/*insert into linee_mobili_fields_value (id_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, id_opu_rel_stab_linea, riferimento_org_id, note_hd)
(select id_rel_stab_linea, (select id from linee_mobili_html_fields where nome_campo='titolo_studio' and codice_raggruppamento='TITSTUSTU' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11)), '', indice, enabled, 6567, now(), id_opu_rel_stab_linea, riferimento_org_id, 
 'Titolo Studio Gestore: recupero campo aggiunto per Flusso 360'
	from linee_mobili_fields_value where id_linee_mobili_html_fields=? limit 1
);*/
-- aggiunta label gestore intestazione
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo,label_campo,only_hd, obbligatorio, ordine, javascript_function_evento, gestione_interna, enabled, readonly, codice_raggruppamento,notes_hd) 
values ((select id from master_list_linea_attivita where linea_attivita ilike 'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11),'gestore','text','Gestore',0,false,20,'disabled style="display:none"', true,true,true,'GESGESGES','Flusso 360: nuovo campo previsto per linea STAZIONE MONTA NATURALE EQUINA PUBBLICA');

/*insert into linee_mobili_fields_value (id_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, id_opu_rel_stab_linea, riferimento_org_id, note_hd)
(select id_rel_stab_linea, (select id from linee_mobili_html_fields where nome_campo='gestore' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11)), '', indice, enabled, 6567, now(), id_opu_rel_stab_linea, riferimento_org_id, 
 'Gestore: recupero campo aggiunto per Flusso 360'
	from linee_mobili_fields_value where id_linee_mobili_html_fields=? limit 1
);*/

-- ordine campi
update linee_mobili_html_fields set ordine=0 where  nome_campo='gestore' and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike 'STAZIONE MONTA NATURALE EQUINA PUBBLICA' and rev=11);


-- RQ1. LINEA PERSONALE LAICO CHE EFFETTUA LA FECONDAZIONE ARTIFICIALE SOLO NEL PROPRIO ALLEVAMENTO
update linee_mobili_html_fields set messaggio_se_invalid='INSERIRE CODICE ISCRIZIONE ALBO PROVINCIALE DEL PERSONALE LAICO, SEGUITO DALLA LETTERA L' where nome_Campo='codice_iscrizione_elenco_regionale' 
and id_linea=(select id from master_list_linea_attivita  where linea_attivita ilike  'PERSONALE LAICO CHE EFFETTUA LA FECONDAZIONE ARTIFICIALE SOLO NEL PROPRIO ALLEVAMENTO' and rev=11);

-- AGGIORNAMENTO PREGRESSO  (verranno eseguiti gli update solo per rev.8)
-- TUTTI I CUN DEVONO ESSERE SVUOTATI E DEVONO DIVENTARI VALORI DEL CAMPO ESTESO CODICE ISCRIZIONE ALL'ALBO.
select * from master_list_linea_attivita where linea_attivita ilike 'PERSONALE LAICO CHE EFFETTUA LA FECONDAZIONE ARTIFICIALE SOLO NEL PROPRIO ALLEVAMENTO'
-- IL CONTROLLO VA FATTO SU TUTTE LE VERSIONI DI LINEA, 8,10,11

--133 record rev.8 
--132 valorizzati cun
select  rel.id, rel.id_linea_produttiva, 'insert into linee_mobili_fields_value (id_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, 
		data_inserimento, id_opu_rel_stab_linea, riferimento_org_id, note_hd)
		values('||rel.id||',(select id from linee_mobili_html_fields where id_linea='||rel.id_linea_produttiva||' and nome_campo=''codice_iscrizione_elenco_regionale''),'''||rel.codice_nazionale||''',1,true,6567,now(),'||rel.id||','||rel.id_stabilimento||',''Flusso 360: aggiornamento Codice iscrizione all''''albo regionale per PERSONALE LAICO CHE EFFETTUA LA FECONDAZIONE ARTIFICIALE SOLO NEL PROPRIO ALLEVAMENTO'');',
		'update opu_relazione_Stabilimento_linee_produttive set codice_nazionale=null, note_internal_use_hd_only=concat_ws(''-'',note_internal_use_hd_only,''Flusso 360 (ex valore cun:'||rel.codice_nazionale||')'') where id='||rel.id||';',
		codice_nazionale, os.numero_registrazione, rel.numero_registrazione, rel.id_stabilimento 
from opu_relazione_Stabilimento_linee_produttive rel
join opu_stabilimento os on os.id = rel.id_stabilimento
where id_linea_produttiva =40083 and rel.enabled
and os.trashed_date is null and codice_nazionale ~ '([a-zA-Z]+[0-9]{4}[fFlL]{1})*$'
and length(trim(codice_nazionale)) > 0
order by codice_nazionale


select * from master_list_linea_attivita where linea_attivita ilike 'MEDICO VETERINARIO CHE EFFETTUA FECONDAZIONE ARTIFICIALE ED IMPIANTI EMBRIONALI'

select  rel.id, rel.id_linea_produttiva, 'insert into linee_mobili_fields_value (id_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, 
		data_inserimento, id_opu_rel_stab_linea, riferimento_org_id, note_hd)
		values('||rel.id||',(select id from linee_mobili_html_fields where id_linea='||rel.id_linea_produttiva||' and nome_campo=''codice_iscrizione_elenco_regionale''),'''||rel.codice_nazionale||''',1,true,6567,now(),'||rel.id||','||rel.id_stabilimento||',''Flusso 360: aggiornamento Codice iscrizione all''''albo regionale per MEDICO VETERINARIO CHE EFFETTUA FECONDAZIONE ARTIFICIALE ED IMPIANTI EMBRIONALI'');',
		'update opu_relazione_Stabilimento_linee_produttive set codice_nazionale=null, note_internal_use_hd_only=concat_ws(''-'',note_internal_use_hd_only,''Flusso 360 (ex valore cun:'||rel.codice_nazionale||')'') where id='||rel.id||';',
		codice_nazionale, os.numero_registrazione, rel.numero_registrazione, rel.id_stabilimento 
from opu_relazione_Stabilimento_linee_produttive rel
join opu_stabilimento os on os.id = rel.id_stabilimento
where id_linea_produttiva =40082 and rel.enabled
and os.trashed_date is null --and codice_nazionale ~ '([a-zA-Z]+[0-9]{4}[fFlL]{1})*$'
and length(trim(codice_nazionale)) > 0
order by codice_nazionale

--  MEDICO VETERINARIO CHE EFFETTUA FECONDAZIONE ARTIFICIALE ED IMPIANTI EMBRIONALI
select 
ml.attivita,
ml.rev,
rel.id_stabilimento,
rel.codice_nazionale,
f.label_campo,
v.valore_campo

from opu_relazione_stabilimento_linee_produttive rel
join ml8_linee_attivita_nuove_materializzata ml on ml.id_nuova_linea_attivita = rel.id_linea_produttiva
left join linee_mobili_fields_value v on v.id_opu_rel_stab_linea = rel.id 
left join linee_mobili_html_fields f on f.id = v.id_linee_mobili_html_fields 

where 
--ml.attivita = 'PERSONALE LAICO CHE EFFETTUA LA FECONDAZIONE ARTIFICIALE SOLO NEL PROPRIO ALLEVAMENTO' 
ml.attivita = 'MEDICO VETERINARIO CHE EFFETTUA FECONDAZIONE ARTIFICIALE ED IMPIANTI EMBRIONALI'
and ml.livello = 3 and rel.enabled and f.label_campo ilike '%codice%iscrizione%'
--and v.valore_campo = ''
order by ml.rev asc


