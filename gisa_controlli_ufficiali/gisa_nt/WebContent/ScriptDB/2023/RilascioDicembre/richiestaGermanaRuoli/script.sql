update role set note=concat_ws('**03/04/2023**',note,'TT 026967, disabilito ruolo Izsm Campania Trasparente'), 
enabled=false where role_id = 3340; -- disabilito ruolo
--3376
INSERT INTO ROLE (role_id,role,description,enteredby,entered,modifiedby,modified,enabled,role_type,super_ruolo,descrizione_super_ruolo,in_access)
values((select max(role_id)+1 from role),'Dirigenti IZSM','UTENTI DIRIGENTI IZSM',291, current_timestamp,291,current_timestamp,true,0,1,'RUOLO GISA',true) RETURNING role_id;

select 'insert into role_permission (role_id, permission_id, role_view, role_add, role_edit, role_delete) values (3376, '||permission_id||',true, false, false, false);' 
from role_permission where role_id=3340;

-- modifica permessi
select permission_id from permission where permission ilike 'soa'
union
select permission_id from permission where permission ilike 'tamponi'
union
select permission_id from permission where permission ilike 'nonconformita'
union
select permission_id from permission where permission ilike 'laboratori'
union
select permission_id from permission where permission ilike 'sequestri'
union
select permission_id from permission where permission ilike 'stabilimenti'
union
select permission_id from permission where permission ilike 'osa'
union
select permission_id from permission where permission ilike 'osm-osm'
union
select permission_id from permission where permission ilike 'reati'
union
select permission_id from permission where permission ilike 'farmacosorveglianza'
union
select permission_id from permission where permission ilike 'myhomepage-scadenzario'
union
select permission_id from permission where permission ilike '%gestioneanagrafica-modifica-scheda%'
union
select * from permission where permission ilike '%gestioneanagrafica-gestioneanagrafica-datiaggiuntivi%'

update role_permission set role_view=false where role_id = 3376 and  permission_id in (
	368,
	77206,
	9924,
	9919,
	376,
	238,
	30014,
	2254487,
	89105,
    89118,
	9914,
	363,
	89105,
	69,
	653,
	760,
	773
)

--GISA
update access_ set note_hd=concat_ws('**31032023**',note_hd,'TT 026967: aggiornamento utente da ruolo IZSM-CAMPANIA TRASPARENTE a Dirigente IZSM autorizzato dall''ORSA'), 
role_id= 3376 where role_id=3340 and data_scadenza is null;

--GUC
update guc_ruoli set 
note=concat_ws('**03/04/2023**', note, 'TT 026967: aggiornamento ruolo da IZSM-Campania Trasparente a Statistiche autorizzato da ORSA a mezzo mail del 03/04/2023'),
ruolo_integer=99,
ruolo_string='Statistiche'
where ruolo_integer=100 
and endpoint ilike 'Digemon' 
and id_utente in 
(11150,
11133);

-- RUOLO COOPERAZIONE APPLICATIVA
INSERT INTO ROLE (role_id,role,description,enteredby,entered,modifiedby,modified,enabled,role_type,super_ruolo,descrizione_super_ruolo,in_access)
values((select max(role_id)+1 from role),'COOPERAZIONE APPLICATIVA','COOPERAZIONE APPLICATIVA',291, current_timestamp,291,current_timestamp,true,0,1,'RUOLO GISA',true) RETURNING role_id;
update access_ set role_id=3377 where username='arpac_001';
update access_ set role_id=3377 where username='izsm_006.sigla';

