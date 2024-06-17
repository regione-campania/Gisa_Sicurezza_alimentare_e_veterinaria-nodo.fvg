DROP SCHEMA IF EXISTS conf CASCADE;

create schema conf;

create table conf.ambiente(
	ambiente text
);

create table conf.pg_conf(
	connection text primary key,
	dbhost text,
	dbname text,
	dbuser text,
	port text,
	modified timestamp,
	trashed boolean,
	trashed_date timestamp
);

--creare file su dbserver con <ambiente>

insert into conf.pg_conf(connection, dbhost, dbname, dbuser) values
('SVILUPPO_GISA','dbGISAL','gisa','postgres'),
('SVILUPPO_GUC','dbGUCL','guc','postgres'),
('SVILUPPO_BDU','dbBDUL','bdu','postgres'),
('SVILUPPO_VAM','dbVAML','vam','postgres'),
('SVILUPPO_STORICO','dbSTORICOL','storico','postgres'),
('SVILUPPO_DIGEMON','report.gisacampania.it','digemon_u','postgres'),
('SVILUPPO_DOCUMENTALE','dbDOCUMENTALEL','documentale','postgres'),
('SVILUPPO_AUTOVALUTAZIONE','dbAUTOVALUTAZIONEL','autovalutazione','postgres'),
('SVILUPPO_MDGM','dbMDGML','mdgm','postgres'),
('SVILUPPO_RTJWT','dbRTJWTL','rtjwt','postgres'),
('SVILUPPO_SICLAV','dbSICLAVL','siclav','postgres'),
('COLLAUDO_GISA','dbGISAL','gisa','postgres'),
('COLLAUDO_GUC','dbGUCL','guc','postgres'),
('COLLAUDO_BDU','dbBDUL','bdu','postgres'),
('COLLAUDO_VAM','dbVAML','vam','postgres'),
('COLLAUDO_STORICO','dbSTORICOL','storico','postgres'),
('COLLAUDO_DIGEMON','report.gisacampania.it','digemon_u','postgres'),
('COLLAUDO_DOCUMENTALE','dbDOCUMENTALEL','documentale','postgres'),
('COLLAUDO_AUTOVALUTAZIONE','dbAUTOVALUTAZIONEL','autovalutazione','postgres'),
('COLLAUDO_MDGM','dbMDGML','mdgm','postgres'),
('COLLAUDO_RTJWT','dbRTJWTL','rtjwt','postgres'),
('COLLAUDO_SICLAV','dbSICLAVL','siclav','postgres'),
('COLLAUDOCRED_GISA','dbGISAL','gisa','gisa_owner'),
('COLLAUDOCRED_GUC','dbGUCL','guc','guc_owner'),
('COLLAUDOCRED_BDU','dbBDUL','bdu','bdu_owner'),
('COLLAUDOCRED_VAM','dbVAML','vam','vam_owner'),
('COLLAUDOCRED_STORICO','dbSTORICOL','storico','storico_owner'),
('COLLAUDOCRED_DIGEMON','report.gisacampania.it','digemon_u','digemon_u_owner'),
('COLLAUDOCRED_DOCUMENTALE','dbDOCUMENTALEL','documentale','documentale_owner'),
('COLLAUDOCRED_AUTOVALUTAZIONE','dbAUTOVALUTAZIONEL','autovalutazione','autovalutazione_owner'),
('COLLAUDOCRED_MDGM','dbMDGML','mdgm','mdgm_owner'),
('COLLAUDOCRED_RTJWT','dbRTJWTL','rtjwt','rtjwt_owner'),
('COLLAUDOCRED_SICLAV','dbSICLAVL','siclav','siclav'),
('DEMO_GISA','dbGISAL','gisa','postgres'),
('DEMO_GUC','dbGUCL','guc','postgres'),
('DEMO_BDU','dbBDUL','bdu','postgres'),
('DEMO_VAM','dbVAML','vam','postgres'),
('DEMO_STORICO','dbSTORICOL','storico','postgres'),
('DEMO_DIGEMON','report.gisacampania.it','digemon_u','postgres'),
('DEMO_DOCUMENTALE','dbDOCUMENTALEL','documentale','postgres'),
('DEMO_AUTOVALUTAZIONE','dbAUTOVALUTAZIONEL','autovalutazione','postgres'),
('DEMO_MDGM','dbMDGML','mdgm','postgres'),
('DEMO_RTJWT','dbRTJWTL','rtjwt','postgres'),
('DEMO_SICLAV','dbSICLAVL','siclav','postgres'),
('UFFICIALE_GISA','dbGISAL','gisa','postgres'),
('UFFICIALE_GUC','dbGUCL','guc','postgres'),
('UFFICIALE_BDU','dbBDUL','bdu','postgres'),
('UFFICIALE_VAM','dbVAML','vam','postgres'),
('UFFICIALE_STORICO','dbSTORICOL','storico','postgres'),
('UFFICIALE_DIGEMON','report.gisacampania.it','digemon_u','postgres'),
('UFFICIALE_DOCUMENTALE','dbDOCUMENTALEL','documentale','postgres'),
('UFFICIALE_AUTOVALUTAZIONE','dbAUTOVALUTAZIONEL','autovalutazione','postgres'),
('UFFICIALE_MDGM','dbMDGML','mdgm','postgres'),
('UFFICIALE_RTJWT','dbRTJWTL','rtjwt','postgres'),
('UFFICIALE_SICLAV','dbSICLAVL','siclav','postgres');
create or replace function conf.get_pg_conf(connection_ text)
returns text
LANGUAGE 'plpgsql'
COST 100
VOLATILE PARALLEL UNSAFE
as $BODY$
DECLARE
host_ text;
dbname_ text;
user_ text;
port_ text;
ambiente_ text;
BEGIN

	delete from conf.ambiente ;
	copy conf.ambiente (ambiente) from '/opt/pg_ambiente/config' ;
	select * from conf.ambiente into ambiente_;
	
	select dbhost, dbname, dbuser, coalesce(port,'5432')
	from conf.pg_conf
	where connection = ambiente_||'_'||connection_
	and trashed is not true and trashed_date is null
	into host_, dbname_, user_, port_;
	
RETURN 'host='|| host_ ||' dbname='|| dbname_ ||' user='|| user_ ||' port='|| port_;
END;
$BODY$;

-- dbi aggiornata x cred

CREATE OR REPLACE FUNCTION public.anagrafa_componente_nucleo(
	_gisaext boolean,
	_nome text,
	_cognome text,
	_idqualifica integer,
	_nomeruolo text,
	_userid integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$

DECLARE

_note text;
_username text;	
_cf text;
_result text;	

_password text;
_dbi_guc text;
_dbi_guc_conf text;
_dbi_guc_opt text;
_dbi_guc_opt_conf text;
_dbi_gisa text;

_output_dbi_guc text;
_output_dbi_guc_opt text;
_output_dbi_gisa text;

_id_utente_guc integer;

_esito_dbi_guc text;
_esito_dbi_gisa text;

BEGIN

_esito_dbi_gisa := '';
_username := '';

SELECT concat('Utente creato per inserimento in Nucleo Ispettivo da ', _userid) into _note;

SELECT concat('_cni_',(select REGEXP_REPLACE((EXTRACT(EPOCH FROM now()) * 1000)::text, '[^A-Za-z0-9]', ''))) into _username;

SELECT md5(_username) into _password;

SELECT concat('_cni_', _nome, _cognome) into _cf;

RAISE INFO '[ANAGRAFA COMPONENTE NUCLEO] username %', _username;
RAISE INFO '[ANAGRAFA COMPONENTE NUCLEO] cf %', _cf;

-- COSTRUISCO DBI DI GUC. SE GISAEXT=TRUE, POPOLO I CAMPI DI EXT, ALTRIMENTI DI GISA

select concat(concat('select * from dbi_insert_utente_guc(',
'''', replace(_cf,'''', ''''''), '''', ', ',
'''', replace(_cognome,'''', ''''''), '''', ', ',
'''', '', '''', ', ',
'''', '1', '''', ', ',
_userid, ', ',
'NULL::timestamp without time zone', ', ', 
_userid, ', ',
'''', _note, '''', ', ',
'''', replace(_nome,'''', ''''''), '''', ', ',
'''', _password, '''', ', ', 
'''', _username, '''', ', ', 
-1, ', ',
'''', null::character varying, '''', ', ', 
-1, ', ',
'''', '', '''', ', '), 
concat('''', '', '''', ', ',
'''', '', '''', ', ', 
-1, ', ',
-1, ', ',
'''', '', '''', ', ',
'''', '', '''', ', ',
-1, ', ',
'''', '', '''', ', ',
0, ', ',
'''', '', '''', ', ',
'''', '', '''', ', ',
'''', '', '''', ', ',
'''', '', '''', ', ',
'''', '', '''', ', ',
'''', '', '''', ', ',
'''', '', '''', ', ', --31simo parametro numero stab
0, ', '), 
concat('''', null::character varying, '''', ', ', 
'''', '', '''', ', ', 
case when _gisaext is not true then _idqualifica else -1 end, ', ',
'''', (case when _gisaext is not true then _nomeruolo else '' end), '''', ', ',
case when _gisaext is true then _idqualifica else -1 end, ', ',
'''', (case when _gisaext is true then _nomeruolo else '' end), '''', ', ',
-1, ', ',
'''', '', '''', ', ',
-1, ', ',
'''', '', '''', ', ',
-1, ', ',
'''', '', '''', ', ',
-1, ', ',
'''', '', '''', ', ',
'''', '-1', '''', ', ',
-1, ', ',
'''', null::character varying, '''', ', ', 
-1, ', ',
-1, ', ',
'''', '', '''', ', ',
'''', null::character varying, '''', ', ', 
-1, ', ',
'''', '', '''', ', ',
'''', '', '''', ', ',
-1, ', ',
'''', '', '''', ', ',
'''', '', '''', '); ')) into _dbi_guc;

RAISE INFO '[ANAGRAFA COMPONENTE NUCLEO] DBI GUC %', _dbi_guc;

-- modifica x cred
select * from conf.get_pg_conf('GUC') into _dbi_guc_conf;

SELECT t1.output into _output_dbi_guc FROM dblink(_dbi_guc_conf, _dbi_guc) as t1(output text);

RAISE INFO '[ANAGRAFA COMPONENTE NUCLEO] OUTPUT DBI GUC %', _output_dbi_guc;

SELECT split_part(_output_dbi_guc,';;','1') into _esito_dbi_guc;
SELECT split_part(_output_dbi_guc,';;','2')::integer into _id_utente_guc;

RAISE INFO '[ANAGRAFA COMPONENTE NUCLEO] ESITO DBI GUC %', _esito_dbi_guc;

IF _esito_dbi_guc ='OK' THEN

select concat(concat('select * from dbi_insert_utente_extended_opt(',
			'''', _id_utente_guc, '''', ', ',
			'''', true, '''', ', ',
			'''', 'false', '''', ', ',
			'''', 'false', '''', ', ',
			'''', 'false', '''', ', ',
			'''', 'false', 
			'''', '); ')) into _dbi_guc_opt;

RAISE INFO '[ANAGRAFA COMPONENTE NUCLEO] DBI GUC OPT %', _dbi_guc_opt;

-- modifica x cred
select * from conf.get_pg_conf('GUC') into _dbi_guc_opt_conf;

-- CHIAMO DBI DI GUC CON DBLINK

SELECT t1.output into _output_dbi_guc_opt FROM dblink(_dbi_guc_opt_conf, _dbi_guc_opt) as t1(output text);

RAISE INFO '[ANAGRAFA COMPONENTE NUCLEO] OUTPUT DBI GUC OPT %', _output_dbi_guc_opt;

-- RECUPERO OUTPUT DELLA DBI DI GUC (STATO E USERNAME)

-- IF STATO OK

--IF GISAEXT=TRUE COSTRUISCO DBI DI GISA EXT

IF _gisaext is true THEN

select concat(
'select * from dbi_insert_utente_ext(', 
'''', _username, '''', ', ',
'''', _password, '''', ', ',
_idqualifica, ', ',
_userid, ', ',
_userid, ', ',
'''', 'true', '''', ', ',
-1, ', ',
'''', replace(_nome,'''', ''''''), '''',  ', ',
'''', replace(_cognome,'''', ''''''), '''', ', ',
'''', replace(_cf,'''', ''''''), '''', ', ',
'''', _note, '''', ', ',
'''', '', '''', ', ',
'''', null::character varying, '''', ', ', 
'''', '', '''', ', ',
'NULL::timestamp with time zone', ', ', 
'''', 'false', '''', ', ',
'''', 'true', '''', ', ',
'''', '', '''', ', ',
-1, ', ',
'''', '', '''', ', ',
'''', '', '''', ', ',
-1, ', ', 
'''', '', '''', ', ',
'''', '', '''', ', ',
-1, ', ', 
'''', '', '''', ', ',
'''', '', '''', ', ',
'''', '', '''', '); ') into _dbi_gisa;

RAISE INFO '[ANAGRAFA COMPONENTE NUCLEO] DBI GISA %', _dbi_gisa;

ELSIF _gisaext is not true THEN

select concat(
'select * from dbi_insert_utente(',
'''', _username, '''', ', ',
'''', _password, '''', ', ',
_idqualifica, ', ',
_userid, ', ',
_userid, ', ',
'''', 'true', '''', ', ',
-1, ', ',
'''', replace(_nome,'''', ''''''), '''',  ', ',
'''', replace(_cognome,'''', ''''''), '''', ', ',
'''', replace(_cf,'''', ''''''), '''', ', ',
'''', _note, '''', ', ',
'''', '', '''', ', ',
'''', null::character varying, '''', ', ', 
'''', '', '''', ', ',
'NULL::timestamp with time zone', ', ', 
-1, ', ',
'''', 'false', '''', ', ',
'''', 'false', '''', ', ',
'''', 'true', '''', ', ',
'''', '', '''', '); ') into _dbi_gisa;

RAISE INFO '[ANAGRAFA COMPONENTE NUCLEO] DBI GISA %', _dbi_gisa;

END IF;

EXECUTE FORMAT(_dbi_gisa) INTO _output_dbi_gisa;

RAISE INFO '[ANAGRAFA COMPONENTE NUCLEO] OUTPUT DBI GISA %', _output_dbi_gisa;

SELECT _output_dbi_gisa INTO _esito_dbi_gisa;

END IF;

return concat(_esito_dbi_gisa,';;',_username);

 END;
$BODY$;

------------

CREATE or replace FUNCTION public.allinea_matrix(id_asl integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
   DECLARE
   conf_dblink text;
tot int;
res int;
BEGIN
tot:= 0;

select * from conf.get_pg_conf('MATRIX') into conf_dblink;
 
 res:= (SELECT * FROM  dblink(conf_dblink,
                'select * from "Analisi_dev".allinea(''istantaneo'', ''asl'','||id_asl||')') as p(res bigint));

RETURN res;
    
 END;
$$;

--------------

CREATE or replace FUNCTION public.dblink_get_messaggio_home(ambiente_ text, endpoint_ text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	conf_dblink text;
	header_ text;
	body_ text;
	footer_ text;
	msg text;
BEGIN
	
	msg := '<center><font color=''red''><h1>';
	select * from conf.get_pg_conf('GUC') into conf_dblink;

	select r.header, r.body, r.footer from dblink(conf_dblink,'select header, body, footer from get_messaggio_home('''|| endpoint_ ||''')')
	as r(header text, body text, footer text) into header_, body_, footer_;

	if(header_ is not null and header_ != '') then
		msg := msg || header_ || '<br>';
	end if;
	
	if(body_ is not null and body_ != '') then
		msg := msg || body_ || '<br>';
	end if;
	
	if(footer_ is not null and footer_ != '') then
		msg := msg || footer_;
	end if;
	
		msg := msg || '</h1></font></center>';
	return msg;
END;
$$;

---------------

CREATE or replace FUNCTION public.dblink_insert_messaggio_home(ambiente_ text, messaggio_ text, id_utente_ integer, endpoint_ text) RETURNS TABLE(result text)
    LANGUAGE plpgsql
    AS $$
DECLARE
	conf_dblink text;
BEGIN

	select * from conf.get_pg_conf('GUC') into conf_dblink;
	
	return query 
	select * from dblink(conf_dblink::text,'select insert_messaggio_home('''||messaggio_||''','''||id_utente_||''','''||endpoint_||''')')
	as r(result text);
END;
$$;

--------------

CREATE or replace FUNCTION public.get_errata_corrige_generate_riepilogo(date_1 timestamp without time zone, date_2 timestamp without time zone) RETURNS TABLE(applicativo text, asl text, id_1 text, id_2 text, motivo text, data text, utente text, contesto text, header_documento text)
    LANGUAGE plpgsql STRICT
    AS $$
DECLARE
	conf_dblink text;
BEGIN
		select * from conf.get_pg_conf('BDU') into conf_dblink;
	
	FOR applicativo, asl, id_1 , id_2 , motivo , data , utente, contesto, header_documento 
	in

	select 'GISA', * FROM get_errata_corrige_generate(date_1, date_2)

UNION

select 'BDU', t1.* FROM dblink(conf_dblink, 'select * from get_errata_corrige_generate('''||date_1||''', '''||date_2||''')') as t1(asl text, microchip1 text, microchip2 text, motivo text, data text, utente text, contesto text, header_documento text)

order by 1 desc, 2 asc, 3 asc, 6 asc

LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$$;

-------------

CREATE or replace FUNCTION public.obs_dbi_allineamento_gisa_con_gisa_ext() RETURNS void
    LANGUAGE plpgsql STRICT
    AS $$
DECLARE
		conf_dblink text;

BEGIN
	select * from conf.get_pg_conf('GISA') into conf_dblink;

raise info 'INIZIO ALLINEAMENTO GISA CON GISA_EXT';
raise info 'ALLINEAMENTO GISA: TABELLA permission_category_ext NUOVI INSERIMENTI';
--ALLINEAMENTO PERMISSION CATEGORY EXT
insert into permission_category_ext
(category_id,category,description,level,enabled,active,folders,lookups,viewpoints,categories,scheduled_events,reports,webdav,logos,constant,action_plans,custom_list_views)
(
select ext_permission_category_ext.* from 
 dblink('dbname=gisa_ext port=5432 host=10.1.15.100 
                user=postgres password=postgres'::text, 'SELECT  category_id,category,description,level,enabled,active,folders,lookups,viewpoints,categories,scheduled_events,reports,webdav,logos,constant,action_plans,custom_list_views from permission_category_ext '::text)
                 ext_permission_category_ext(
		category_id integer,category text,description text,level integer,enabled boolean,active boolean,folders boolean,lookups boolean,viewpoints boolean,categories boolean,scheduled_events boolean,reports boolean,webdav boolean,logos boolean,constant integer,action_plans boolean,custom_list_views boolean
                 ) left join permission_category_ext gisa_category on  ext_permission_category_ext.category_id = gisa_category.category_id
                 where gisa_category.category_id is null
 );


raise info 'ALLINEAMENTO GISA: TABELLA permission_category_ext MODIFICHE';

update permission_category_ext
set category = ext_permission_category_ext.category ,
description = ext_permission_category_ext.description ,
level = ext_permission_category_ext.level,
enabled = ext_permission_category_ext.enabled 
from 
 dblink(conf_dblink::text, 'SELECT  category_id,category,description,level,enabled,active,folders,lookups,viewpoints,categories,scheduled_events,reports,webdav,logos,constant,action_plans,custom_list_views from permission_category_ext '::text)
                 ext_permission_category_ext(
		category_id integer,category text,description text,level integer,enabled boolean,active boolean,folders boolean,lookups boolean,viewpoints boolean,categories boolean,scheduled_events boolean,reports boolean,webdav boolean,logos boolean,constant integer,action_plans boolean,custom_list_views boolean
                 )   
                 where ext_permission_category_ext.category_id = permission_category_ext.category_id;



--ALLINEAMENTO PERMISSION EXT


raise info 'ALLINEAMENTO GISA: TABELLA permission_ext NUOVI INSERIMENTI';

insert into permission_ext
(
select ext_permission_ext.* from 
 dblink(conf_dblink::text, 'SELECT  permission_id,category_id,permission,permission_view,permission_add,permission_edit,permission_delete,description,level,enabled,active,viewpoints from permission_ext '::text)
                 ext_permission_ext(
		permission_id integer ,category_id integer ,permission text ,permission_view boolean,permission_add boolean,permission_edit boolean,permission_delete boolean,description text ,level integer ,enabled boolean,active boolean,viewpoints boolean
                 ) left join permission_ext gisa_permission on  ext_permission_ext.permission_id = gisa_permission.permission_id
                 where gisa_permission.permission_id is null
 );


raise info 'ALLINEAMENTO GISA: TABELLA permission_ext MODIFICHE';

update permission_ext
set category_id = ext_permission_ext.category_id ,
description = ext_permission_ext.description ,
level = ext_permission_ext.level,
enabled = ext_permission_ext.enabled ,
permission = ext_permission_ext.permission,
permission_view = ext_permission_ext.permission_view,
permission_add = ext_permission_ext.permission_add,
permission_edit=ext_permission_ext.permission_edit,
permission_delete=ext_permission_ext.permission_delete
from 
dblink(conf_dblink::text, 'SELECT  permission_id,category_id,permission,permission_view,permission_add,permission_edit,permission_delete,description,level,enabled,active,viewpoints from permission_ext '::text)
                 ext_permission_ext(
		permission_id integer ,category_id integer ,permission text ,permission_view boolean,permission_add boolean,permission_edit boolean,permission_delete boolean,description text ,level integer ,enabled boolean,active boolean,viewpoints boolean
                 )  
                 where ext_permission_ext.permission_id = permission_ext.permission_id ;



--ALLINEAMENTO ROOLE PERMISSION EXT
raise info 'ALLINEAMENTO GISA: TABELLA role_ext NUOVI INSERIMENTI';


insert into role_ext
(
select ext_role_ext.* from 
 dblink(conf_dblink::text, 'SELECT  role_id,role,description,enteredby,entered,modifiedby,modified,enabled,role_type,role_old,admin,note,super_ruolo,descrizione_super_ruolo,in_access,in_dpat,in_nucleo_ispettivo,carico_default,peso_per_somma_ui,id_lookup_qualifica_old,livello_qualifiche_dpat,enabled_as_qualifica from role_ext'::text)
                 ext_role_ext(
role_id integer ,role text ,description text ,enteredby integer,entered timestamp,modifiedby integer ,modified timestamp ,enabled boolean,role_type integer ,role_old text ,admin boolean,note text,super_ruolo integer ,descrizione_super_ruolo text,in_access boolean,in_dpat boolean,in_nucleo_ispettivo boolean,carico_default integer,peso_per_somma_ui integer ,id_lookup_qualifica_old integer ,livello_qualifiche_dpat integer ,enabled_as_qualifica boolean
                 ) left join role_ext gisa_role_ext on  ext_role_ext.role_id = gisa_role_ext.role_id
                 where gisa_role_ext.role_id is null
 );


raise info 'ALLINEAMENTO GISA: TABELLA role_ext MODIFICHE';

update role_ext set
role = ext_role_ext.role ,
enabled = ext_role_ext.enabled,
super_ruolo = ext_role_ext.super_ruolo,
descrizione_super_ruolo = ext_role_ext.descrizione_super_ruolo ,
in_access = ext_role_ext.in_access ,
in_dpat = ext_role_ext.in_dpat,
in_nucleo_ispettivo =ext_role_ext.in_nucleo_ispettivo = ext_role_ext.in_nucleo_ispettivo
from 
 dblink(conf_dblink::text, 'SELECT  role_id,role,description,enteredby,entered,modifiedby,modified,enabled,role_type,role_old,admin,note,super_ruolo,descrizione_super_ruolo,in_access,in_dpat,in_nucleo_ispettivo,carico_default,peso_per_somma_ui,id_lookup_qualifica_old,livello_qualifiche_dpat,enabled_as_qualifica from role_ext'::text)
                 ext_role_ext(
role_id integer ,role text ,description text ,enteredby integer,entered timestamp,modifiedby integer ,modified timestamp ,enabled boolean,role_type integer ,role_old text ,admin boolean,note text,super_ruolo integer ,descrizione_super_ruolo text,in_access boolean,in_dpat boolean,in_nucleo_ispettivo boolean,carico_default integer,peso_per_somma_ui integer ,id_lookup_qualifica_old integer ,livello_qualifiche_dpat integer ,enabled_as_qualifica boolean
                 ) 
                 where    ext_role_ext.role_id = role_ext.role_id;



--ALLINEAMENTO ROLE PERMISSION EXT
raise info 'ALLINEAMENTO GISA: TABELLA role_permission_ext NUOVI INSERIMENTI';

insert into role_permission_ext
(
select ext_role_perm_ext.* from 
 dblink(conf_dblink::text, 'SELECT  id,role_id,permission_id,role_view,role_add,role_edit,role_delete from role_permission_ext'::text)
                 ext_role_perm_ext(
id integer ,role_id integer ,permission_id integer ,role_view boolean ,role_add boolean,role_edit boolean,role_delete boolean
                 ) left join role_permission_ext gisa_role_per_ext on  ext_role_perm_ext.id = gisa_role_per_ext.id
                 where gisa_role_per_ext.id is null
 );


raise info 'ALLINEAMENTO GISA: TABELLA role_permission_ext MODIFICHE';

 update role_permission_ext set
 permission_id = ext_role_perm_ext.permission_id,
 role_view = ext_role_perm_ext.role_view,
 role_add = ext_role_perm_ext.role_add,
 role_edit = ext_role_perm_ext.role_edit , 
 role_delete = ext_role_perm_ext.role_delete
 from 
  dblink(conf_dblink::text, 'SELECT  id,role_id,permission_id,role_view,role_add,role_edit,role_delete from role_permission_ext'::text)
                 ext_role_perm_ext(
id integer ,role_id integer ,permission_id integer ,role_view boolean ,role_add boolean,role_edit boolean,role_delete boolean
                 ) 
                 where  ext_role_perm_ext.id = role_permission_ext.id ;



--ALLINEAMENTO CONTACT EXT

raise info 'ALLINEAMENTO GISA: TABELLA contact_ext  NUOVI INSERIMENTI';

insert into contact_ext
(
select ext_contact_ext.* from 
 dblink(conf_dblink::text, 'SELECT contact_id, user_id, org_id, company, title, department, super, namesalutation, namelast, namefirst, namemiddle, namesuffix, assistant, birthdate, notes, site, locale, employee_id, employmenttype, startofday, endofday, entered, enteredby, modified, modifiedby, enabled, owner, custom1, url, primary_contact, employee, org_name, access_type, status_id, import_id, information_update_date, lead, lead_status, source, rating, comments, conversion_date, additional_names, nickname, role, trashed_date, secret_word, account_number, revenue, industry_temp_code, potential, no_email, no_mail, no_phone, no_textmessage, no_im, no_fax, site_id, assigned_date, lead_trashed_date, employees, duns_type, duns_number, business_name_two, sic_code, year_started, sic_description, site_id_old, codice_fiscale, luogo FROM contact_ext;'::text)
                 ext_contact_ext(
contact_id integer ,user_id integer,org_id integer,company character varying(255),title character varying(80),department integer,super integer,namesalutation character varying(80),namelast character varying(80) ,namefirst character varying(80) ,namemiddle character varying(80),namesuffix character varying(80),assistant integer,birthdate date,notes text,site integer,locale integer,employee_id character varying(80),employmenttype integer,startofday character varying(10),endofday character varying(10),entered timestamp(3) without time zone  ,enteredby integer ,modified timestamp(3) without time zone  ,modifiedby integer ,enabled boolean ,owner integer,custom1 integer ,url character varying(100),primary_contact boolean ,employee boolean  ,org_name character varying(255),access_type integer,status_id integer,import_id integer,information_update_date timestamp(3) without time zone ,lead boolean ,lead_status integer,source integer,rating integer,comments character varying(255),conversion_date timestamp(3) without time zone,additional_names character varying(255),nickname character varying(80),role character varying(255),trashed_date timestamp(3) without time zone,secret_word character varying(255),account_number character varying(50),revenue double precision,industry_temp_code integer,potential double precision,no_email boolean ,no_mail boolean ,no_phone boolean ,no_textmessage boolean ,no_im boolean ,no_fax boolean ,site_id integer,assigned_date timestamp(3) without time zone,lead_trashed_date timestamp(3) without time zone,employees integer,duns_type character varying(300),duns_number character varying(30),business_name_two character varying(300),sic_code integer,year_started integer,sic_description character varying(300),site_id_old integer,codice_fiscale character varying(60),luogo text

                 )
                  left join contact_ext gisa_contact_ext on  ext_contact_ext.contact_id = gisa_contact_ext.contact_id
                 where gisa_contact_ext.contact_id is null and (ext_contact_ext.contact_id >10000000 or ext_contact_ext.contact_id = 10000000)
);


raise info 'ALLINEAMENTO GISA: TABELLA contact_ext  MODIFICHE';

update contact_ext set 
namelast = ext_contact_ext.namelast ,
namefirst = ext_contact_ext.namefirst ,
codice_fiscale = ext_contact_ext.codice_fiscale,
luogo = ext_contact_ext.luogo
from
dblink(conf_dblink::text, 'SELECT contact_id, user_id, org_id, company, title, department, super, namesalutation, namelast, namefirst, namemiddle, namesuffix, assistant, birthdate, notes, site, locale, employee_id, employmenttype, startofday, endofday, entered, enteredby, modified, modifiedby, enabled, owner, custom1, url, primary_contact, employee, org_name, access_type, status_id, import_id, information_update_date, lead, lead_status, source, rating, comments, conversion_date, additional_names, nickname, role, trashed_date, secret_word, account_number, revenue, industry_temp_code, potential, no_email, no_mail, no_phone, no_textmessage, no_im, no_fax, site_id, assigned_date, lead_trashed_date, employees, duns_type, duns_number, business_name_two, sic_code, year_started, sic_description, site_id_old, codice_fiscale, luogo FROM contact_ext;'::text)
                 ext_contact_ext(
contact_id integer ,user_id integer,org_id integer,company character varying(255),title character varying(80),department integer,super integer,namesalutation character varying(80),namelast character varying(80) ,namefirst character varying(80) ,namemiddle character varying(80),namesuffix character varying(80),assistant integer,birthdate date,notes text,site integer,locale integer,employee_id character varying(80),employmenttype integer,startofday character varying(10),endofday character varying(10),entered timestamp(3) without time zone  ,enteredby integer ,modified timestamp(3) without time zone  ,modifiedby integer ,enabled boolean ,owner integer,custom1 integer ,url character varying(100),primary_contact boolean ,employee boolean  ,org_name character varying(255),access_type integer,status_id integer,import_id integer,information_update_date timestamp(3) without time zone ,lead boolean ,lead_status integer,source integer,rating integer,comments character varying(255),conversion_date timestamp(3) without time zone,additional_names character varying(255),nickname character varying(80),role character varying(255),trashed_date timestamp(3) without time zone,secret_word character varying(255),account_number character varying(50),revenue double precision,industry_temp_code integer,potential double precision,no_email boolean ,no_mail boolean ,no_phone boolean ,no_textmessage boolean ,no_im boolean ,no_fax boolean ,site_id integer,assigned_date timestamp(3) without time zone,lead_trashed_date timestamp(3) without time zone,employees integer,duns_type character varying(300),duns_number character varying(30),business_name_two character varying(300),sic_code integer,year_started integer,sic_description character varying(300),site_id_old integer,codice_fiscale character varying(60),luogo text

                 )
                  
                 where ext_contact_ext.contact_id = contact_ext.contact_id and (ext_contact_ext.contact_id >10000000 or ext_contact_ext.contact_id = 10000000) ;


--ALLINEAMENTO ACCESS EXT 

raise info 'ALLINEAMENTO GISA: TABELLA access_ext  NUOVI INSERIMENTI';

insert into access_ext
(
select ext_access_ext.* from 
 dblink(conf_dblink::text, 'SELECT user_id, username, password, contact_id, role_id, manager_id, startofday, endofday, locale, timezone, last_ip, last_login, enteredby, entered, modifiedby, modified, expires, alias, assistant, enabled, currency, language, webdav_password, hidden, site_id, allow_webdav_access, allow_httpapi_access, role_id_old, roleid_old, last_interaction_time, action, command, object_id, table_name, asl_old, access_position_lat, access_position_lon, access_position_err, trashed_date, codice_suap, in_access, in_dpat, in_nucleo_ispettivo FROM access_ext;'::text)
                 ext_access_ext(
user_id integer  ,username character varying(80) ,password character varying(80),contact_id integer ,role_id integer ,manager_id integer ,startofday integer ,endofday integer ,locale character varying(255),timezone character varying(255) ,last_ip character varying(15),last_login timestamp(3) without time zone  ,enteredby integer ,entered timestamp(3) without time zone  ,modifiedby integer ,modified timestamp(3) without time zone  ,expires timestamp(3) without time zone,alias integer ,assistant integer ,enabled boolean  ,currency character varying(5),language character varying(20),webdav_password character varying(80),hidden boolean ,site_id integer,allow_webdav_access boolean  ,allow_httpapi_access boolean  ,role_id_old text,roleid_old integer,last_interaction_time timestamp(3) without time zone  ,action character varying(255),command character varying(255),object_id integer,table_name character varying(255),asl_old integer,access_position_lat double precision,access_position_lon double precision,access_position_err text,trashed_date timestamp without time zone,codice_suap text,in_access boolean ,in_dpat boolean ,in_nucleo_ispettivo boolean 

                 )
                  left join access_ext gisa_access_ext on  ext_access_ext.user_id = gisa_access_ext.user_id
                 where gisa_access_ext.user_id is null and (ext_access_ext.user_id >10000000 or ext_access_ext.user_id = 10000000)
);

raise info 'ALLINEAMENTO GISA: TABELLA access_ext  MODIFICHE';

update access_ext set 
password = ext_access_ext.password , 
role_id = ext_access_ext.role_id ,
last_ip = ext_access_ext.last_ip,
last_interaction_time = ext_access_ext.last_interaction_time,
action = ext_access_ext.action , 
command = ext_access_ext.command , 
site_id = ext_access_ext.site_id , 
trashed_date = ext_access_ext.trashed_date ,
in_access = ext_access_ext.in_access,

in_dpat = ext_access_ext.in_dpat ,
in_nucleo_ispettivo = ext_access_ext.in_nucleo_ispettivo
from 
dblink(conf_dblink::text, 'SELECT user_id, username, password, contact_id, role_id, manager_id, startofday, endofday, locale, timezone, last_ip, last_login, enteredby, entered, modifiedby, modified, expires, alias, assistant, enabled, currency, language, webdav_password, hidden, site_id, allow_webdav_access, allow_httpapi_access, role_id_old, roleid_old, last_interaction_time, action, command, object_id, table_name, asl_old, access_position_lat, access_position_lon, access_position_err, trashed_date, codice_suap, in_access, in_dpat, in_nucleo_ispettivo FROM access_ext;'::text)
                 ext_access_ext(
user_id integer  ,username character varying(80) ,password character varying(80),contact_id integer ,role_id integer ,manager_id integer ,startofday integer ,endofday integer ,locale character varying(255),timezone character varying(255) ,last_ip character varying(15),last_login timestamp(3) without time zone  ,enteredby integer ,entered timestamp(3) without time zone  ,modifiedby integer ,modified timestamp(3) without time zone  ,expires timestamp(3) without time zone,alias integer ,assistant integer ,enabled boolean  ,currency character varying(5),language character varying(20),webdav_password character varying(80),hidden boolean ,site_id integer,allow_webdav_access boolean  ,allow_httpapi_access boolean  ,role_id_old text,roleid_old integer,last_interaction_time timestamp(3) without time zone  ,action character varying(255),command character varying(255),object_id integer,table_name character varying(255),asl_old integer,access_position_lat double precision,access_position_lon double precision,access_position_err text,trashed_date timestamp without time zone,codice_suap text,in_access boolean ,in_dpat boolean ,in_nucleo_ispettivo boolean 

                 )
                 
                 where ext_access_ext.user_id = access_ext.user_id and (ext_access_ext.user_id >10000000 or ext_access_ext.user_id = 10000000);




raise info 'ALLINEAMENTO GISA: TABELLA organization (VALE PER I CANIPADRONALI)  NUOVI INSERIMENTI';


--ALLINEAMENTP ANAGRAFICHE CANI PADRONALI PER AGGIUNTA CONTROLLI INDIRIZZI E CANI
insert into organization ( org_id,name,nome_rappresentante,cognome_rappresentante,codice_fiscale_rappresentante ,data_nascita_rappresentante,luogo_nascita_rappresentante,documento,site_id,entered,modified,modifiedby,enteredby,tipologia,tipo_proprietario)
(
select organization_ext.*
from
dblink(conf_dblink::text, 'SELECT org_id,name,nome_rappresentante,cognome_rappresentante,codice_fiscale_rappresentante ,data_nascita_rappresentante,luogo_nascita_rappresentante,documento,site_id,entered,modified,modifiedby,enteredby,tipologia,tipo_proprietario FROM organization where org_id > 1000000 or org_id = 10000000;'::text)
                 organization_ext(
org_id integer ,name text ,nome_rappresentante text,cognome_rappresentante text,codice_fiscale_rappresentante text ,data_nascita_rappresentante timestamp ,luogo_nascita_rappresentante text,documento text,site_id integer ,entered timestamp ,modified timestamp ,modifiedby integer ,enteredby integer,tipologia integer,tipo_proprietario text

                 )
 left join organization organization_gisa on  organization_ext.org_id = organization_gisa.org_id
                 where organization_gisa.org_id is null and (organization_ext.org_id >10000000 or organization_ext.org_id = 10000000)
                 );


raise info 'ALLINEAMENTO GISA: TABELLA organization_address (VALE PER I CANIPADRONALI)  NUOVI INSERIMENTI';

insert into organization_address (org_id , city,addrline1,state ,postalcode,entered,modified,enteredby,modifiedby,address_id )
(
select organization_address_ext.*
from
dblink(conf_dblink::text, 'SELECT org_id , city,addrline1,state ,postalcode,entered,modified,enteredby,modifiedby,address_id FROM organization_address where org_id >0 and (address_id > 1000000 or address_id = 10000000)'::text)
                 organization_address_ext(

org_id integer, city text ,addrline1 text ,state text  ,postalcode text ,entered timestamp ,modified timestamp ,enteredby integer ,modifiedby integer,address_id integer
                 )
 left join organization_address organization_address_gisa on  organization_address_ext.org_id = organization_address_gisa.org_id
                 where organization_address_gisa.address_id is null and (organization_address_ext.address_id >10000000 or organization_address_ext.address_id = 10000000)
);

raise info 'ALLINEAMENTO GISA: TABELLA asset (VALE PER I CANIPADRONALI)  NUOVI INSERIMENTI';


insert into asset (asset_id,serial_number,account_id,site_id,data_nascita,razza,sesso,enteredby,modifiedby,entered,modified,taglia,mantello)
(
select asset_ext.*
from
dblink(conf_dblink::text, 'SELECT asset_id,serial_number,account_id,site_id,data_nascita,razza,sesso,enteredby,modifiedby,entered,modified,taglia,mantello FROM asset where  (asset_id > 1000000 or asset_id = 10000000)'::text)
                 asset_ext(

asset_id integer ,serial_number text ,account_id integer ,site_id integer ,data_nascita timestamp ,razza text ,sesso text ,enteredby integer ,modifiedby integer,entered timestamp ,modified timestamp ,taglia text ,mantello text 
                 )
 left join asset asset_gisa on  asset_ext.asset_id = asset_gisa.asset_id
                 where asset_gisa.asset_id is null and (asset_ext.asset_id >10000000 or asset_ext.asset_id = 10000000)

);


raise info 'ALLINEAMENTO GISA: TABELLA ticket  NUOVI INSERIMENTI';



raise info 'ALLINEAMENTO GISA: TABELLA ticket  MODIFICHE';

update ticket set 
org_id = ticket_ext.org_id,
id_stabilimento = ticket_ext.id_stabilimento ,
modifiedby = ticket_ext.modifiedby ,
modified = ticket_ext.modified , 
closed = ticket_ext.closed , 
assigned_date = ticket_ext.assigned_date ,
site_id = ticket_ext.site_id ,
provvedimenti_prescrittivi = ticket_ext.provvedimenti_prescrittivi ,
nucleo_ispettivo = ticket_ext.nucleo_ispettivo ,
componente_nucleo = ticket_ext.componente_nucleo ,
id_controllo_ufficiale = ticket_ext.id_controllo_ufficiale ,
data_fine_controllo = ticket_ext.data_fine_controllo ,
ncrilevate = ticket_ext.ncrilevate , 
isaggiornata_categoria = ticket_ext.isaggiornata_categoria , 
ip_entered = ticket_ext.ip_entered ,
ip_modified =ticket_ext.ip_modified,
flag_mod5 = ticket_ext.flag_mod5,
tipo_controllo = ticket_ext.tipo_controllo ,
chiusura_attesa_esito = ticket_ext.chiusura_attesa_esito ,
num_specie1 = ticket_ext.num_specie1,
num_specie2 = ticket_ext.num_specie2,
num_specie3 = ticket_ext.num_specie3,
num_specie4 = ticket_ext.num_specie4,
num_specie5 = ticket_ext.num_specie5,
num_specie6 = ticket_ext.num_specie6,
num_specie7 = ticket_ext.num_specie7,
num_specie8 = ticket_ext.num_specie8,
num_specie9 = ticket_ext.num_specie9,
num_specie10 = ticket_ext.num_specie10,
num_specie11= ticket_ext.num_specie11,
num_specie12 = ticket_ext.num_specie12,
num_specie13 = ticket_ext.num_specie13,
num_specie14 = ticket_ext.num_specie13,
num_specie15 = ticket_ext.num_specie15,
componentenucleoid_uno = ticket_ext.componentenucleoid_uno ,
componentenucleoid_due = ticket_ext.componentenucleoid_due ,
componentenucleoid_tre = ticket_ext.componentenucleoid_tre ,
componentenucleoid_quattro = ticket_ext.componentenucleoid_quattro ,
componentenucleoid_cinque = ticket_ext.componentenucleoid_cinque ,
componentenucleoid_sei = ticket_ext.componentenucleoid_sei ,
componentenucleoid_sette = ticket_ext.componentenucleoid_sette ,
nucleo_ispettivo_due = ticket_ext.nucleo_ispettivo_due,
nucleo_ispettivo_tre = ticket_ext.nucleo_ispettivo_tre, 
nucleo_ispettivo_quattro = ticket_ext.nucleo_ispettivo_quattro, 
nucleo_ispettivo_cinque = ticket_ext.nucleo_ispettivo_cinque,
nucleo_ispettivo_sei = ticket_ext.nucleo_ispettivo_sei,
nucleo_ispettivo_sette = ticket_ext.nucleo_ispettivo_sette ,
componente_nucleo_due = ticket_ext.componente_nucleo_due ,
componente_nucleo_tre = ticket_ext.componente_nucleo_tre ,
componente_nucleo_quattro = ticket_ext.componente_nucleo_quattro ,
componente_nucleo_cinque = ticket_ext.componente_nucleo_cinque ,
componente_nucleo_sei = ticket_ext.componente_nucleo_sei ,
componente_nucleo_sette = ticket_ext.componente_nucleo_sette ,
num_specie23 = ticket_ext.num_specie23 ,
num_specie24 = ticket_ext.num_specie24 ,
num_specie25 = ticket_ext.num_specie25 ,
num_specie26 = ticket_ext.num_specie26 
from 
dblink(conf_dblink::text, 'SELECT * FROM ticket where ticketid >10000000;'::text)
                 ticket_ext(

ticketid integer  ,org_id integer,contact_id integer,problem text ,entered timestamp(3) without time zone  ,enteredby integer ,modified timestamp(3) without time zone  ,modifiedby integer ,closed timestamp without time zone,pri_code integer,level_code integer,department_code integer,source_code integer,cat_code integer,subcat_code1 integer,subcat_code2 integer,subcat_code3 integer,assigned_to integer,comment text,solution text,scode integer,critical timestamp without time zone,notified timestamp without time zone,custom_data text,location character varying(256),assigned_date timestamp(3) without time zone,est_resolution_date timestamp(3) without time zone,resolution_date timestamp(3) without time zone,cause text,link_contract_id integer,link_asset_id integer,product_id integer,customer_product_id integer,expectation integer,key_count integer,est_resolution_date_timezone character varying(255),assigned_date_timezone character varying(255),resolution_date_timezone character varying(255),status_id integer,trashed_date timestamp(3) without time zone,user_group_id integer,cause_id integer,resolution_id integer,defect_id integer,escalation_level integer,resolvable boolean ,resolvedby integer,resolvedby_department_code integer,state_id integer,site_id integer,tipo_richiesta character varying(60),tipologia integer,provvedimenti_prescrittivi integer,sanzioni_amministrative integer,sanzioni_penali integer,sequestri integer,descrizione1 character varying(200),descrizione2 character varying(200),descrizione3 character varying(200),data_accettazione timestamp(3) without time zone,data_accettazione_timezone character varying(255),alimenti_origine_animale boolean,alimenti_origine_vegetale boolean,alimenti_composti boolean,alimenti_origine_animale_non_trasformati integer,alimenti_origine_animale_trasformati integer,alimenti_origine_vegetale_valori integer,alimenti_origine_animale_non_trasformati_valori integer,allerta boolean,non_conformita boolean,conseguenze_positivita integer,responsabilita_positivita integer,note_esito character varying(200),nucleo_ispettivo integer,nucleo_ispettivo_due integer,nucleo_ispettivo_tre integer,componente_nucleo text,componente_nucleo_due text,componente_nucleo_tre text,tipo_sequestro boolean,tipo_sequestro_due boolean,tipo_sequestro_tre boolean,tipo_sequestro_quattro boolean,testo_alimento_composto text,nucleo_ispettivo_quattro integer,nucleo_ispettivo_cinque integer,nucleo_ispettivo_sei integer,nucleo_ispettivo_sette integer,nucleo_ispettivo_otto integer,nucleo_ispettivo_nove integer,nucleo_ispettivo_dieci integer,componente_nucleo_quattro text,componente_nucleo_cinque text,componente_nucleo_sei text,componente_nucleo_sette text,componente_nucleo_otto text,componente_nucleo_nove text,componente_nucleo_dieci text,data_apertura timestamp without time zone,data_eventuale_revoca timestamp without time zone,data_chiusura timestamp without time zone,progressivo_allerta integer,tipo_alimento integer,origine integer,alimento_interessato integer,non_conformita_alimento integer,altre_irregolarita integer,inserisci_continua boolean,id_controllo_ufficiale character varying,identificativo character varying,punteggio integer,nonconformitaformali text,nonconformitagravi text,nonconformitasignificative text,puntigravi text,puntisignificativi text,puntiformali text,data_fine_controllo timestamp(3) without time zone,codice_articolo integer,notesequestro text,trasgressore text,obbligatoinsolido text,pagamento double precision,esito text,segnalazione boolean,follow_up text,sequestrodi integer,id_allerta character varying,codice_allerta text,descrizioneesitosequestro text,normaviolata text,obbligatoinsolido3 text,obbligatoinsolido2 text,followupdate timestamp with time zone,quantita double precision,ncrilevate boolean,followupdate_timezone text,identificativonc text,specie_uova integer,id_nonconformita integer,specie_latte integer,contributi double precision,lista_commercializzazione integer,notesequestridi text,note_analisi text,tipo_acqua integer,alimenti_acqua boolean,alimenti_bevande boolean,alimenti_additivi boolean,alimenti_materiali_alimenti boolean,alimenti_dolciumi boolean,alimenti_gelati boolean,isvegetaletrasformato integer,altrialimentinonanimali integer,altrialimenti_nonanimali boolean,descrizione text,luogocontrollo text,animali integer,mezziispezionati integer,numeromezzi integer,tipoispezione integer,articoloviolato text,sanzione text,illecitopenalereati boolean,sequestrotrasporti boolean,notefollowup text,esito_sequestri integer,specietrasportata integer,animalitrasportati integer,descrizionebreveallerta text,origine_allerta integer,descrizioneanimali text,isaggiornata_categoria boolean,id_macchinetta integer,note_altro text,followup boolean,motivazione text,note_motivazione text,ragionesocialevoltura text,denonimazionevoltura text,fax text,telefono_rappresentante text,chiusura_ufficio boolean,ispregresso text,data_apertura_timezone character varying(255),partitavoltura text,latitudine double precision,longitudine double precision,data_prossimo_controllo timestamp(3) without time zone,alimenti_mangimi boolean,specie_alimento_zootecnico integer,tipologia_alimento_zootecnico integer,prossimo_controllo timestamp without time zone,categoria_rischio integer,stato_esito_camp_tamp integer,distribuzione_partita integer,destinazione_distribuzione integer,comunicazione_rischio boolean,note_rischio text,procedura_ritiro boolean,procedura_richiamo integer,esito_controllo integer,data_ddt timestamp without time zone,num_ddt text,quantita_partita text,quantita_partita_bloccata text,id_file_allegato integer,articolo_azioni integer,unita_misura integer,unita_misura_text text,codiceateco text,txt_desc_non_accettato text,id_farmacia integer,descrizione_codice text,ip_entered text,ip_modified text,alimenti_sospetti text,ispezioni_desc1 text,ispezioni_desc2 text,ispezioni_desc3 text,ispezioni_desc4 text,ispezioni_desc5 text,ispezioni_desc6 text,ispezioni_desc7 text,esito_declassamento text,declassamento integer,ricoverati text,soggetti_coinvolti text,data_pasto timestamp without time zone,data_sintomi timestamp without time zone,data_pasto_timezone text,data_sintomi_timezone text,azione_followup_descrizione text,azione_followup boolean,id_concessionario integer,denominazione_prodotto text,numero_lotto text,fabbricante_produttore text,data_scadenza_allerta timestamp without time zone,flag_mod5 text,nc_formali_valutazione text,nc_significative_valutazione text,city_legale_rapp text,address_legale_rapp text,prov_legale_rapp text,sanzione_campioni text,tipo_nc integer,motivo_cancellazione_allerta text,id_imprese_linee_attivita integer,operazione text,motivo_chiusura text,flag_ripianificazione boolean,tipo_controllo text,asl_old integer,tipo_matrici_canili integer,check_matrici_canili boolean,chiusura_attesa_esito boolean ,data_chiusura_attesa_esito timestamp without time zone,microchip character varying(15),nome_conducente text,cognome_conducente text,documento_conducente text,tipologia_controllo_cani integer,motivo_intervento_hd text,data_intervento_hd timestamp without time zone,operatore_hd text,tipo_intervento_hd text,ispezioni_desc8 text,ispezione_altro text,codice_azienda text,id_allevamento integer,data_nascita_conducente text,luogo_nascita_conducente text,citta_conducente text,via_conducente text,prov_conducente text,via_connducente text,cap_conducente text,ragione_sociale_allevamento text,num_specie1 integer,num_specie2 integer,num_specie3 integer,num_specie4 integer,num_specie5 integer,num_specie6 integer,num_specie7 integer,num_specie8 integer,num_specie9 integer,num_specie10 integer,num_specie11 integer,num_specie12 integer,num_specie13 integer,num_specie14 integer,num_specie15 integer,animali_non_alimentari_flag boolean,animali_non_alimentare integer,flag_sorveglianza boolean,data_preavviso timestamp without time zone,data_comunicazione_svincolo timestamp without time zone,protocollo_preavviso text,protocollo_svincolo text,tipologia_sottoprodotto text,peso double precision,motivazione_campione integer,motivazione_piano_campione integer,contributi_campioni_tamponi double precision,contributi_allarme_rapido double precision,contributi_verifica_risoluzione_nc double precision,contributi_macellazione double precision,contributi_rilascio_certificazione double precision,parent_ticket_id integer ,contributi_importazione_scambio double precision,contributi_risol_nc double precision,intera_asl boolean,contributi_macellazione_urgenza double precision,flag_pubblicazione_allerte boolean,data_fine_pubblicazione_allerte timestamp without time zone,data_inizio_pubblicazione_allerte timestamp without time zone,tipo_rischio_allerte text,provvedimenti_esito_allerte text,stato_voltura integer,id_matrice integer,cammino text,box text,trasgressore2 text,trasgressore3 text,data_estrazione timestamp without time zone,data_import timestamp without time zone,descrizione_errore text,esito_import text,id_bdn integer,tipologiasequestro integer,nc_gravi_valutazione text,quantitativo integer,quintali double precision,supervisionato_da integer,supervisionato_in_data timestamp without time zone,tipo_sospetto text,codice_buffer text,supervisione_flag_congruo boolean,supervisione_note text,componentenucleoid_uno integer,componentenucleoid_due integer,componentenucleoid_tre integer,componentenucleoid_quattro integer,componentenucleoid_cinque integer,componentenucleoid_sei integer,componentenucleoid_sette integer,componentenucleoid_otto integer,componentenucleoid_nove integer,componentenucleoid_dieci integer,check_specie_mangimi boolean,check_circuito_ogm text,gestione_esito_campione_pregresso boolean,id_stabilimento integer,id_soggetto_fisico_operatore_storico integer,id_soggetto_fisico_stabilimento_storico integer,flag_tipo_allerta boolean,header_allegato_documentale text,flag_preavviso text,data_preavviso_ba timestamp without time zone,closed_nolista boolean,flag_checklist character varying(5),esito_import_b11 text,data_import_b11 timestamp without time zone,descrizione_errore_b11 text,id_bdn_b11 integer,data_estrazione_b11 timestamp without time zone,location_new text,note_esito_esame text,data_risultato timestamp without time zone,esito_campione_chiuso boolean,num_specie22 integer,num_specie23 integer,num_specie24 integer,num_specie25 integer,num_specie26 integer,esito_informazioni_laboratorio_chiuso boolean
                 )
                 
                 where ticket_ext.ticketid = ticket.ticketid and ticket.ticketid >10000000 and (ticket_ext.ticketid >10000000 or ticket_ext.ticketid = 10000000);
                 
--ALLINEAMENTO ATTIVITA SVOLTE SULL'IMPRESA

insert into ticket
(
select ticket_ext.* from 
 dblink(conf_dblink::text, 'SELECT * FROM ticket;'::text)
                 ticket_ext(

ticketid integer  ,org_id integer,contact_id integer,problem text ,entered timestamp(3) without time zone  ,enteredby integer ,modified timestamp(3) without time zone  ,modifiedby integer ,closed timestamp without time zone,pri_code integer,level_code integer,department_code integer,source_code integer,cat_code integer,subcat_code1 integer,subcat_code2 integer,subcat_code3 integer,assigned_to integer,comment text,solution text,scode integer,critical timestamp without time zone,notified timestamp without time zone,custom_data text,location character varying(256),assigned_date timestamp(3) without time zone,est_resolution_date timestamp(3) without time zone,resolution_date timestamp(3) without time zone,cause text,link_contract_id integer,link_asset_id integer,product_id integer,customer_product_id integer,expectation integer,key_count integer,est_resolution_date_timezone character varying(255),assigned_date_timezone character varying(255),resolution_date_timezone character varying(255),status_id integer,trashed_date timestamp(3) without time zone,user_group_id integer,cause_id integer,resolution_id integer,defect_id integer,escalation_level integer,resolvable boolean ,resolvedby integer,resolvedby_department_code integer,state_id integer,site_id integer,tipo_richiesta character varying(60),tipologia integer,provvedimenti_prescrittivi integer,sanzioni_amministrative integer,sanzioni_penali integer,sequestri integer,descrizione1 character varying(200),descrizione2 character varying(200),descrizione3 character varying(200),data_accettazione timestamp(3) without time zone,data_accettazione_timezone character varying(255),alimenti_origine_animale boolean,alimenti_origine_vegetale boolean,alimenti_composti boolean,alimenti_origine_animale_non_trasformati integer,alimenti_origine_animale_trasformati integer,alimenti_origine_vegetale_valori integer,alimenti_origine_animale_non_trasformati_valori integer,allerta boolean,non_conformita boolean,conseguenze_positivita integer,responsabilita_positivita integer,note_esito character varying(200),nucleo_ispettivo integer,nucleo_ispettivo_due integer,nucleo_ispettivo_tre integer,componente_nucleo text,componente_nucleo_due text,componente_nucleo_tre text,tipo_sequestro boolean,tipo_sequestro_due boolean,tipo_sequestro_tre boolean,tipo_sequestro_quattro boolean,testo_alimento_composto text,nucleo_ispettivo_quattro integer,nucleo_ispettivo_cinque integer,nucleo_ispettivo_sei integer,nucleo_ispettivo_sette integer,nucleo_ispettivo_otto integer,nucleo_ispettivo_nove integer,nucleo_ispettivo_dieci integer,componente_nucleo_quattro text,componente_nucleo_cinque text,componente_nucleo_sei text,componente_nucleo_sette text,componente_nucleo_otto text,componente_nucleo_nove text,componente_nucleo_dieci text,data_apertura timestamp without time zone,data_eventuale_revoca timestamp without time zone,data_chiusura timestamp without time zone,progressivo_allerta integer,tipo_alimento integer,origine integer,alimento_interessato integer,non_conformita_alimento integer,altre_irregolarita integer,inserisci_continua boolean,id_controllo_ufficiale character varying,identificativo character varying,punteggio integer,nonconformitaformali text,nonconformitagravi text,nonconformitasignificative text,puntigravi text,puntisignificativi text,puntiformali text,data_fine_controllo timestamp(3) without time zone,codice_articolo integer,notesequestro text,trasgressore text,obbligatoinsolido text,pagamento double precision,esito text,segnalazione boolean,follow_up text,sequestrodi integer,id_allerta character varying,codice_allerta text,descrizioneesitosequestro text,normaviolata text,obbligatoinsolido3 text,obbligatoinsolido2 text,followupdate timestamp with time zone,quantita double precision,ncrilevate boolean,followupdate_timezone text,identificativonc text,specie_uova integer,id_nonconformita integer,specie_latte integer,contributi double precision,lista_commercializzazione integer,notesequestridi text,note_analisi text,tipo_acqua integer,alimenti_acqua boolean,alimenti_bevande boolean,alimenti_additivi boolean,alimenti_materiali_alimenti boolean,alimenti_dolciumi boolean,alimenti_gelati boolean,isvegetaletrasformato integer,altrialimentinonanimali integer,altrialimenti_nonanimali boolean,descrizione text,luogocontrollo text,animali integer,mezziispezionati integer,numeromezzi integer,tipoispezione integer,articoloviolato text,sanzione text,illecitopenalereati boolean,sequestrotrasporti boolean,notefollowup text,esito_sequestri integer,specietrasportata integer,animalitrasportati integer,descrizionebreveallerta text,origine_allerta integer,descrizioneanimali text,isaggiornata_categoria boolean,id_macchinetta integer,note_altro text,followup boolean,motivazione text,note_motivazione text,ragionesocialevoltura text,denonimazionevoltura text,fax text,telefono_rappresentante text,chiusura_ufficio boolean,ispregresso text,data_apertura_timezone character varying(255),partitavoltura text,latitudine double precision,longitudine double precision,data_prossimo_controllo timestamp(3) without time zone,alimenti_mangimi boolean,specie_alimento_zootecnico integer,tipologia_alimento_zootecnico integer,prossimo_controllo timestamp without time zone,categoria_rischio integer,stato_esito_camp_tamp integer,distribuzione_partita integer,destinazione_distribuzione integer,comunicazione_rischio boolean,note_rischio text,procedura_ritiro boolean,procedura_richiamo integer,esito_controllo integer,data_ddt timestamp without time zone,num_ddt text,quantita_partita text,quantita_partita_bloccata text,id_file_allegato integer,articolo_azioni integer,unita_misura integer,unita_misura_text text,codiceateco text,txt_desc_non_accettato text,id_farmacia integer,descrizione_codice text,ip_entered text,ip_modified text,alimenti_sospetti text,ispezioni_desc1 text,ispezioni_desc2 text,ispezioni_desc3 text,ispezioni_desc4 text,ispezioni_desc5 text,ispezioni_desc6 text,ispezioni_desc7 text,esito_declassamento text,declassamento integer,ricoverati text,soggetti_coinvolti text,data_pasto timestamp without time zone,data_sintomi timestamp without time zone,data_pasto_timezone text,data_sintomi_timezone text,azione_followup_descrizione text,azione_followup boolean,id_concessionario integer,denominazione_prodotto text,numero_lotto text,fabbricante_produttore text,data_scadenza_allerta timestamp without time zone,flag_mod5 text,nc_formali_valutazione text,nc_significative_valutazione text,city_legale_rapp text,address_legale_rapp text,prov_legale_rapp text,sanzione_campioni text,tipo_nc integer,motivo_cancellazione_allerta text,id_imprese_linee_attivita integer,operazione text,motivo_chiusura text,flag_ripianificazione boolean,tipo_controllo text,asl_old integer,tipo_matrici_canili integer,check_matrici_canili boolean,chiusura_attesa_esito boolean ,data_chiusura_attesa_esito timestamp without time zone,microchip character varying(15),nome_conducente text,cognome_conducente text,documento_conducente text,tipologia_controllo_cani integer,motivo_intervento_hd text,data_intervento_hd timestamp without time zone,operatore_hd text,tipo_intervento_hd text,ispezioni_desc8 text,ispezione_altro text,codice_azienda text,id_allevamento integer,data_nascita_conducente text,luogo_nascita_conducente text,citta_conducente text,via_conducente text,prov_conducente text,via_connducente text,cap_conducente text,ragione_sociale_allevamento text,num_specie1 integer,num_specie2 integer,num_specie3 integer,num_specie4 integer,num_specie5 integer,num_specie6 integer,num_specie7 integer,num_specie8 integer,num_specie9 integer,num_specie10 integer,num_specie11 integer,num_specie12 integer,num_specie13 integer,num_specie14 integer,num_specie15 integer,animali_non_alimentari_flag boolean,animali_non_alimentare integer,flag_sorveglianza boolean,data_preavviso timestamp without time zone,data_comunicazione_svincolo timestamp without time zone,protocollo_preavviso text,protocollo_svincolo text,tipologia_sottoprodotto text,peso double precision,motivazione_campione integer,motivazione_piano_campione integer,contributi_campioni_tamponi double precision,contributi_allarme_rapido double precision,contributi_verifica_risoluzione_nc double precision,contributi_macellazione double precision,contributi_rilascio_certificazione double precision,parent_ticket_id integer ,contributi_importazione_scambio double precision,contributi_risol_nc double precision,intera_asl boolean,contributi_macellazione_urgenza double precision,flag_pubblicazione_allerte boolean,data_fine_pubblicazione_allerte timestamp without time zone,data_inizio_pubblicazione_allerte timestamp without time zone,tipo_rischio_allerte text,provvedimenti_esito_allerte text,stato_voltura integer,id_matrice integer,cammino text,box text,trasgressore2 text,trasgressore3 text,data_estrazione timestamp without time zone,data_import timestamp without time zone,descrizione_errore text,esito_import text,id_bdn integer,tipologiasequestro integer,nc_gravi_valutazione text,quantitativo integer,quintali double precision,supervisionato_da integer,supervisionato_in_data timestamp without time zone,tipo_sospetto text,codice_buffer text,supervisione_flag_congruo boolean,supervisione_note text,componentenucleoid_uno integer,componentenucleoid_due integer,componentenucleoid_tre integer,componentenucleoid_quattro integer,componentenucleoid_cinque integer,componentenucleoid_sei integer,componentenucleoid_sette integer,componentenucleoid_otto integer,componentenucleoid_nove integer,componentenucleoid_dieci integer,check_specie_mangimi boolean,check_circuito_ogm text,gestione_esito_campione_pregresso boolean,id_stabilimento integer,id_soggetto_fisico_operatore_storico integer,id_soggetto_fisico_stabilimento_storico integer,flag_tipo_allerta boolean,header_allegato_documentale text,flag_preavviso text,data_preavviso_ba timestamp without time zone,closed_nolista boolean,flag_checklist character varying(5),esito_import_b11 text,data_import_b11 timestamp without time zone,descrizione_errore_b11 text,id_bdn_b11 integer,data_estrazione_b11 timestamp without time zone,location_new text,note_esito_esame text,data_risultato timestamp without time zone,esito_campione_chiuso boolean,num_specie22 integer,num_specie23 integer,num_specie24 integer,num_specie25 integer,num_specie26 integer,esito_informazioni_laboratorio_chiuso boolean
                 )
                  left join ticket ticket_gisa  on  ticket_ext.ticketid = ticket_gisa.ticketid
                 where ticket_gisa.ticketid is null and (ticket_ext.ticketid >10000000 or ticket_ext.ticketid = 10000000)
);




--ALLINEAMENTO TIPOCONTROLLOUFFICIALEIMPRE
raise info 'ALLINEAMENTO GISA: TABELLA tipocontrolloufficialeimprese  NUOVI INSERIMENTI';

insert into tipocontrolloufficialeimprese ( idcontrollo ,tipo_audit ,bpi ,haccp ,tipoispezione ,pianomonitoraggio ,ispezione ,audit_tipo ,id_unita_operativa ,oggetto_audit ,enabled  ,modified ,modifiedby ,id_lookup_condizionalita  ,audit_di_followup,id_tipocontrollo_ufficiale_imprese_ext)
(


select tipi_controlli_ext.* from 
 dblink(conf_dblink::text, 'SELECT idcontrollo ,tipo_audit ,bpi ,haccp ,tipoispezione ,pianomonitoraggio ,ispezione ,audit_tipo ,id_unita_operativa ,oggetto_audit ,enabled  ,modified ,modifiedby ,id_lookup_condizionalita  ,audit_di_followup,id FROM tipocontrolloufficialeimprese;'::text)
                 tipi_controlli_ext(

 idcontrollo integer,tipo_audit integer,bpi integer,haccp integer,tipoispezione integer,pianomonitoraggio integer,ispezione integer,audit_tipo integer,id_unita_operativa integer,oggetto_audit integer,enabled boolean ,modified timestamp without time zone,modifiedby integer,id_lookup_condizionalita integer ,audit_di_followup boolean ,id integer )
                  left join tipocontrolloufficialeimprese tipi_gisa  on  tipi_controlli_ext.id = tipi_gisa.id_tipocontrollo_ufficiale_imprese_ext
                 where tipi_gisa.id_tipocontrollo_ufficiale_imprese_ext is null and (tipi_controlli_ext.idcontrollo >10000000 or tipi_controlli_ext.idcontrollo = 10000000)
);

raise info 'ALLINEAMENTO GISA: TABELLA tipocontrolloufficialeimprese  MODIFICHE';

UPDATE tipocontrolloufficialeimprese set 
ispezione = tipi_controlli_ext.ispezione , 
id_unita_operativa = tipi_controlli_ext.id_unita_operativa ,
enabled = tipi_controlli_ext.enabled 
from 
dblink(conf_dblink::text, 'SELECT idcontrollo ,tipo_audit ,bpi ,haccp ,tipoispezione ,pianomonitoraggio ,ispezione ,audit_tipo ,id_unita_operativa ,oggetto_audit ,enabled  ,modified ,modifiedby ,id_lookup_condizionalita  ,audit_di_followup,id FROM tipocontrolloufficialeimprese where idcontrollo>10000000;'::text)
                 tipi_controlli_ext(

 idcontrollo integer,tipo_audit integer,bpi integer,haccp integer,tipoispezione integer,pianomonitoraggio integer,ispezione integer,audit_tipo integer,id_unita_operativa integer,oggetto_audit integer,enabled boolean ,modified timestamp without time zone,modifiedby integer,id_lookup_condizionalita integer ,audit_di_followup boolean ,id integer )
              
                 where tipi_controlli_ext.id = tipocontrolloufficialeimprese.id_tipocontrollo_ufficiale_imprese_ext and tipocontrolloufficialeimprese.id_tipocontrollo_ufficiale_imprese_ext >0 and (tipi_controlli_ext.idcontrollo >10000000 or tipi_controlli_ext.idcontrollo = 10000000);

raise info 'ALLINEAMENTO GISA: TABELLA linee_attivita_controlli_ufficiali_stab_soa  NUOVI INSERIMENTI';


insert into linee_attivita_controlli_ufficiali_stab_soa 
(
select ext.* from 
 dblink(conf_dblink::text, 'SELECT id_controllo_ufficiale,linea_attivita_stabilimenti_soa,descrizione_codice,linea_attivita_stabilimenti_soa_desc FROM linee_attivita_controlli_ufficiali_stab_soa where id_controllo_ufficiale >= 10000000;'::text)
                 ext (
id_controllo_ufficiale int ,linea_attivita_stabilimenti_soa text ,descrizione_codice text ,linea_attivita_stabilimenti_soa_desc  text

)
left join linee_attivita_controlli_ufficiali_stab_soa gisa on  ext.id_controllo_ufficiale = gisa.id_controllo_ufficiale and ext.linea_attivita_stabilimenti_soa = gisa.linea_attivita_stabilimenti_soa
 where gisa.id_controllo_ufficiale is null and gisa.linea_attivita_stabilimenti_soa is null  
 and (ext.id_controllo_ufficiale >10000000 or ext.id_controllo_ufficiale = 10000000)
);


raise info 'ALLINEAMENTO GISA: TABELLA opu_linee_attivita_controlli_ufficiali  NUOVI INSERIMENTI';

insert into opu_linee_attivita_controlli_ufficiali 
(
select ext.* from 
 dblink(conf_dblink::text, 'SELECT id_controllo_ufficiale,id_linea_attivita FROM opu_linee_attivita_controlli_ufficiali where id_controllo_ufficiale >= 10000000;'::text)
                 ext (
id_controllo_ufficiale integer ,id_linea_attivita integer
)
left join opu_linee_attivita_controlli_ufficiali gisa on  ext.id_controllo_ufficiale = gisa.id_controllo_ufficiale and ext.id_linea_attivita = gisa.id_linea_attivita
 where gisa.id_controllo_ufficiale is null and gisa.id_linea_attivita is null  
 and (ext.id_controllo_ufficiale >10000000 or ext.id_controllo_ufficiale = 10000000)
);



raise info 'ALLINEAMENTO GISA: TABELLA linee_attivita_controlli_ufficiali  NUOVI INSERIMENTI';

insert into linee_attivita_controlli_ufficiali 
(
select ext.* from 
 dblink(conf_dblink::text, 'SELECT id_controllo_ufficiale,id_linea_attivita FROM linee_attivita_controlli_ufficiali where id_controllo_ufficiale >= 10000000;'::text)
                 ext (
id_controllo_ufficiale integer ,id_linea_attivita integer
)
left join linee_attivita_controlli_ufficiali gisa on  ext.id_controllo_ufficiale = gisa.id_controllo_ufficiale and ext.id_linea_attivita = gisa.id_linea_attivita
 where gisa.id_controllo_ufficiale is null and gisa.id_linea_attivita is null  
 and (ext.id_controllo_ufficiale >10000000 or ext.id_controllo_ufficiale = 10000000)
);

--ALLINEAMENTO NON CONFORMITA
raise info 'ALLINEAMENTO GISA: TABELLA salvataggio_nc_note  NUOVI INSERIMENTI';

insert into salvataggio_nc_note (idticket,note,tipologia,id_non_conformita,id_riferimento_ext)
(

select salvataggio_nc_note_ext.* from 
 dblink(conf_dblink::text, 'SELECT idticket,note,tipologia,id_non_conformita,id FROM salvataggio_nc_note where idticket >= 10000000;'::text)
                 salvataggio_nc_note_ext(
idticket integer ,note text ,tipologia integer ,id_non_conformita integer ,id_riferimento_ext integer
)
left join salvataggio_nc_note salvataggio_nc_note_gisa   on  salvataggio_nc_note_ext.id_riferimento_ext = salvataggio_nc_note_gisa.id_riferimento_ext
                  
                 where salvataggio_nc_note_gisa.id_riferimento_ext is null and (salvataggio_nc_note_ext.idticket >10000000 or salvataggio_nc_note_ext.idticket = 10000000)

);

raise info 'ALLINEAMENTO GISA: TABELLA salvataggio_nc_note  MODIFICHE';

update salvataggio_nc_note set 
note = salvataggio_nc_note_ext.note,
id_non_conformita = salvataggio_nc_note_ext.id_non_conformita
from 
dblink(conf_dblink::text, 'SELECT idticket,note,tipologia,id_non_conformita,id FROM salvataggio_nc_note where idticket >= 10000000;'::text)
                 salvataggio_nc_note_ext(
idticket integer ,note text ,tipologia integer ,id_non_conformita integer ,id_riferimento_ext integer
)

where salvataggio_nc_note_ext.id_riferimento_ext = salvataggio_nc_note.id_riferimento_ext and
salvataggio_nc_note.id_riferimento_ext >0 and (salvataggio_nc_note_ext.idticket >10000000 or salvataggio_nc_note_ext.idticket = 10000000);


--ALLINEAMENTO SANZIONI
raise info 'ALLINEAMENTO GISA: TABELLA norme_violate_sanzioni  NUOVI INSERIMENTI';

insert into norme_violate_sanzioni (idticket,id_norma,org_id,stato_diffida)
(
select norme_sanzioni_ext.* from 
 dblink(conf_dblink::text, 'SELECT idticket,id_norma,org_id,stato_diffida FROM norme_violate_sanzioni where idticket >= 10000000;'::text)
                 norme_sanzioni_ext(
idticket integer ,id_norma integer , org_id integer , stato_diffida integer 

)
left join norme_violate_sanzioni norme_gisa   on  norme_sanzioni_ext.idticket = norme_gisa.idticket and norme_sanzioni_ext.id_norma = norme_gisa.id_norma
 where norme_gisa.idticket is null and norme_gisa.id_norma is null  and (norme_sanzioni_ext.idticket >10000000 or norme_sanzioni_ext.idticket = 10000000
 )

);

raise info 'ALLINEAMENTO GISA: TABELLA oggettisequestrati_azioninonconformi  NUOVI INSERIMENTI';

insert into oggettisequestrati_azioninonconformi (idticket,sequestro_di,azione_nonconforme,tipo)
(
select azioni_sanzioni_ext.* from 
 dblink(conf_dblink::text, 'SELECT idticket,sequestro_di,azione_nonconforme,tipo FROM oggettisequestrati_azioninonconformi where idticket >= 10000000;'::text)
                 azioni_sanzioni_ext(
idticket integer ,sequestro_di integer ,azione_nonconforme integer ,tipo integer 

)
left join oggettisequestrati_azioninonconformi azioni_sanzioni_gisa   on  azioni_sanzioni_ext.idticket = azioni_sanzioni_gisa.idticket and azioni_sanzioni_ext.azione_nonconforme = azioni_sanzioni_gisa.azione_nonconforme
 where azioni_sanzioni_gisa.idticket is null and azioni_sanzioni_gisa.azione_nonconforme is null  and (azioni_sanzioni_ext.idticket >10000000 or azioni_sanzioni_ext.idticket = 10000000)

);

raise info 'ALLINEAMENTO GISA: TABELLA limitazioni_followup  NUOVI INSERIMENTI';

insert into limitazioni_followup (idticket,idlimitazione)
(
select limitazioni_followup_ext.* from 
 dblink(conf_dblink::text, 'SELECT idticket,idlimitazione FROM limitazioni_followup where idticket >= 10000000;'::text)
                 limitazioni_followup_ext(
idticket integer ,idlimitazione integer

)
left join limitazioni_followup limitazioni_followup_gisa   on  limitazioni_followup_ext.idticket = limitazioni_followup_gisa.idticket and limitazioni_followup_ext.idlimitazione = limitazioni_followup_gisa.idlimitazione
 where limitazioni_followup_gisa.idticket is null and limitazioni_followup_gisa.idlimitazione is null  and (limitazioni_followup_ext.idticket >10000000 or limitazioni_followup_ext.idticket = 10000000)

);


raise info 'ALLINEAMENTO GISA: TERMINATO CON SUCCESSO';


 END;
$$;

---------------

CREATE or replace FUNCTION public.ws_salva_storico_chiamate(_url text, _request text, _response text, _idutente integer) RETURNS json
    LANGUAGE plpgsql
    AS $$
   DECLARE
   	conf_dblink text;
_id integer;
_output json;
BEGIN

	select * from conf.get_pg_conf('STORICO') into conf_dblink;


SELECT COALESCE(_url, '') into _url;
SELECT COALESCE(_request, '') into _request;
SELECT COALESCE(_response, '') into _response;
SELECT COALESCE(_idutente, -1) into _idutente;

SELECT replace(_request, '''', '''''') into _request;
SELECT replace(_response, '''', '''''') into _response;

_id := (select * FROM dblink(conf_dblink::text, 
'insert into gisa_ws_storico_chiamate(url, request, response, id_utente) values ('''||_url||''', '''||_request||''', 
'''||_response||''', '||_idutente||') returning id;')  as t1(output integer));

_output:= (select * FROM dblink(conf_dblink::text, 
'SELECT row_to_json (gisa_ws_storico_chiamate) from gisa_ws_storico_chiamate where id = '||_id||';') as t1(output json));

return _output;
END
$$;

--------------

CREATE or replace FUNCTION public_functions.dbi_get_osm_inviati_sinvsa() RETURNS text
    LANGUAGE plpgsql STRICT
    AS $$
	DECLARE
			conf_dblink text;
	BEGIN
		
		select * from conf.get_pg_conf('DIGEMON') into conf_dblink;
		-- 1 step
		delete from sinvsa_osm_inviati;
		-- 2 step
		insert into sinvsa_osm_inviati  (
		SELECT * FROM dblink(conf_dblink, 'select entered,numreg,cun from sinvsa_oklog')
		AS t1( entered timestamp, numreg text, cun text));
	
	return 'ok';	

	END;
	$$;

-------------

CREATE or replace FUNCTION public_functions.qualita_dati_get_cu_aperti(idasl integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
   DECLARE
numCu integer;
	conf_dblink text;

BEGIN
	select * from conf.get_pg_conf('GWH') into conf_dblink;

numCu := 0;

numCu:= ( SELECT *  FROM   dblink(conf_dblink,
                'SELECT count(*) FROM qualita_dati_cu_aperti where id_asl ='||idAsl||';') as p(conta int));

	RETURN numCu;

END
$$;

--------------

CREATE or replace FUNCTION public_functions.qualita_dati_get_cu_aperti_lista(idasl integer) RETURNS TABLE(ticketid integer, ragione_sociale text, tecnica_controllo text, data_controllo timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
   DECLARE
   	conf_dblink text;

BEGIN
		select * from conf.get_pg_conf('GWH') into conf_dblink;

FOR 

ticketid, ragione_sociale, tecnica_controllo, data_controllo
in
SELECT *  FROM   dblink(conf_dblink,
                'SELECT ticketid, ragione_sociale, tecnica_controllo, data_controllo FROM qualita_dati_cu_aperti where id_asl ='||idAsl||' order by data_controllo desc;') as p(ticketid int, ragione_sociale text, tecnica_controllo text, data_controllo timestamp without time zone)
LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
 
$$;

------------

CREATE or replace FUNCTION public_functions.qualita_dati_get_cu_sorveglianza_senza_checklist(idasl integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
   DECLARE
numCu integer;
	conf_dblink text;


BEGIN

	select * from conf.get_pg_conf('GWH') into conf_dblink;

numCu := 0;

numCu:= ( SELECT *  FROM   dblink(conf_dblink,
                'SELECT count(*) FROM qualita_dati_cu_sorveglianza_senza_checklist where id_asl ='||idAsl||';') as p(conta int));

	RETURN numCu;

END
$$;

--------------

CREATE or replace FUNCTION public_functions.qualita_dati_get_cu_sorveglianza_senza_checklist_lista(idasl integer) RETURNS TABLE(ticketid integer, ragione_sociale text, tecnica_controllo text, data_controllo timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
   DECLARE
		conf_dblink text;

BEGIN
	select * from conf.get_pg_conf('GWH') into conf_dblink;

FOR 

ticketid, ragione_sociale, tecnica_controllo, data_controllo
in
SELECT *  FROM   dblink(conf_dblink,
                'SELECT ticketid, ragione_sociale, tecnica_controllo, data_controllo FROM qualita_dati_cu_sorveglianza_senza_checklist where id_asl ='||idAsl||' order by data_controllo desc;') as p(ticketid int, ragione_sociale text, tecnica_controllo text, data_controllo timestamp without time zone)
LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$$;
------------

CREATE or replace FUNCTION public_functions.qualita_dati_get_errata_corrige(idasl integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
   DECLARE
numEc integer;
	conf_dblink text;


BEGIN
	select * from conf.get_pg_conf('GWH') into conf_dblink;

numEc := 0;

numEc:= ( SELECT *  FROM   dblink(conf_dblink,
                'SELECT count(*) FROM qualita_dati_errata_corrige where id_asl ='||idAsl||';') as p(conta int));

	RETURN numEc;

END
$$;

-------------------

CREATE or replace FUNCTION public_functions.qualita_dati_get_errata_corrige_art17(idasl integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
   DECLARE
numEc integer;
	conf_dblink text;


BEGIN
	select * from conf.get_pg_conf('GWH') into conf_dblink;

numEc := 0;

numEc:= ( SELECT *  FROM   dblink(conf_dblink,
                'SELECT count(*) FROM qualita_dati_errata_corrige_art17 where id_asl ='||idAsl||';') as p(conta int));

	RETURN numEc;

END
$$;

-------------------

CREATE or replace FUNCTION public_functions.qualita_dati_get_errata_corrige_art17_lista(idasl integer) RETURNS TABLE(data_articolo timestamp without time zone, identificativo text, tipo_macellazione text, ragione_sociale text, approval_number text)
    LANGUAGE plpgsql
    AS $$
   DECLARE
		conf_dblink text;

BEGIN
		select * from conf.get_pg_conf('GWH') into conf_dblink;

FOR 

data_articolo, identificativo, tipo_macellazione, ragione_sociale, approval_number
in
 SELECT *  FROM   dblink(conf_dblink,
                'SELECT data_articolo, identificativo, tipo_macellazione, ragione_sociale, approval_number
 FROM qualita_dati_errata_corrige_art17 where id_asl ='||idAsl||' order by data_articolo desc;') as p(data_articolo timestamp without time zone, identificativo text, tipo_macellazione text, ragione_sociale text, approval_number text)
LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$$;

-------------

CREATE or replace FUNCTION public_functions.qualita_dati_get_errata_corrige_lista(idasl integer) RETURNS TABLE(data timestamp without time zone, ragione_sociale text, num_registrazione text)
    LANGUAGE plpgsql
    AS $$
   DECLARE
conf_dblink text;
BEGIN

	select * from conf.get_pg_conf('GWH') into conf_dblink;
	
FOR 

data, ragione_sociale, num_registrazione
in
 SELECT *  FROM   dblink(conf_dblink,
                'SELECT data, ragione_sociale, num_registrazione FROM qualita_dati_errata_corrige where id_asl ='||idAsl||' order by data desc;') as p(data timestamp without time zone, ragione_sociale text, num_registrazione text)
LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$$;

-------------

CREATE or replace VIEW anagrafica.r_alt_partizioni AS
 SELECT tl.code,
    tl.description,
    tl.nome_campo,
    tl.nome_tabella,
    tl.valore_start,
    tl.valore_end
   FROM public.dblink((select * from conf.get_pg_conf('GISA'))::text, 'select code, description, nome_campo, nome_tabella, valore_start, valore_end from alt_partizioni'::text) tl(code integer, description text, nome_campo text, nome_tabella text, valore_start integer, valore_end integer);

------------------

CREATE or replace VIEW public.guc_allineamento_gisa_ext AS
 SELECT gisa.username AS user_gisa,
    gisa.password AS pass_gisa,
    a.username AS user_guc,
    a.password AS pass_guc
   FROM (public.access_ext gisa
     LEFT JOIN public.dblink((select * from conf.get_pg_conf('GUC'))::text, 'select username,password from guc_utenti join guc_ruoli on guc_ruoli.id_utente =guc_utenti.id where endpoint ilike ''gisa_ext'' and ruolo_integer>0'::text) a(username text, password text) ON (((gisa.username)::text = a.username)))
  WHERE ((gisa.password)::text = a.password);

-------------

CREATE or replace VIEW public.view_allegati_documentale_gisa AS
 SELECT p.id,
    p.nome_client,
    p.data_creazione,
    p.header,
    p.org_id,
    p.stab_id,
    p.alt_id
   FROM public.dblink((select * from conf.get_pg_conf('DOCUMENTALE'))::text, 'SELECT id, nome_client, data_creazione, header, org_id, stab_id, alt_id FROM storage_gisa_allegati'::text) p(id integer, nome_client text, data_creazione timestamp without time zone, header text, org_id integer, stab_id integer, alt_id integer);

-----------


CREATE or replace FUNCTION public_functions.anagrafica_infasamento_privati_fissi() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
 DECLARE
	recImpresa record;
	recLinea record;
	recStabInseriti record;
	recInserimento record;
	recInserimentoTemp record;

	data_i timestamp without time zone;
	data_f timestamp without time zone;
	
	s text;
	utente integer;
	retInsOsa integer;
	numRegStab text;
	qry text;
	qryNumRegStab text;
	idImpresaInserita integer;
	retOperazioneOsaInserito integer;
	strConnTarget text;
	sqlLog text;
BEGIN 
select * from conf.get_pg_conf('GISA') into strConnTarget;
utente:=1; --utente amministratore
s:= ''; 
sqlLog:= '';

-- Elenco operatori privati tutti MAPPATI:7549
FOR recImpresa IN
	select
		riferimento_id,
		riferimento_id_nome,
		riferimento_id_nome_col,
		riferimento_id_nome_tab,
		data_inserimento,
		categoria_rischio,
		prossimo_controllo,
		note_stabilimento,
		data_inizio_attivita_stab,
		data_fine_attivita_stab,
		anag.codice_fiscale_rappresentante codice_fiscale_rappresentante,
		anag.cognome_rappresentante cognome_rappresentante,
		anag.nome_rappresentante nome_rappresentante,
		anag.data_nascita_rappresentante data_nascita_rappresentante,
		anag.comune_nascita_rappresentante comune_nascita_rappresentante,
		json_build_object('soggetto_fisico',json_build_object('titolo', anag.titolo_rappresentante,
									'cognome', anag.cognome_rappresentante,
									'nome', anag.nome_rappresentante,
									'comune_nascita', anag.comune_nascita_rappresentante,
									'codice_fiscale', anag.codice_fiscale_rappresentante,
									'sesso', anag.sesso_rappresentante,
									'telefono', anag.telefono_rappresentante,
									'fax', anag.fax_rappresentante,
									'email', anag.email_rappresentante,
									'telefono1', anag.telefono1_rappresentante,
									'data_nascita', anag.data_nascita_rappresentante,
									'documento_identita', anag.documento_identita_rappresentante,
									'provenienza_estera', anag.provenienza_estera_rappresentante,
									'provincia_nascita', anag.provincia_nascita_rappresentante,
									'indirizzo', json_build_object( 'toponimo', anag.toponimo_rappresentante,
													'descr_indrizzo', anag.descr_indrizzo_rappresentante,
													'civico', anag.civico_rappresentante,
													'cap', anag.cap_rappresentante,
													'provincia', anag.cod_provincia_rappresentante,
													'nazione', anag.nazione_rappresentante,
													'comune', anag.id_comune_rappresentante
												       )
									)

								   
		
		) soggetto_fisico,
		json_build_object('impresa', json_build_object( 'ragione_sociale', anag.ragione_sociale,
								'codice_fiscale', anag.codice_fiscale,
								'partita_iva', anag.partita_iva,
								'id_tipo_impresa_societa', anag.id_tipo_impresa_societa,
								'data_arrivo_pec', anag.data_arrivo_pec,
								'indirizzo', json_build_object( 'toponimo', anag.toponimo_impresa,
												'descr_indrizzo', anag.indirizzo_impresa,
												'civico',  anag.civico_impresa,
												'cap', anag.cap_impresa,
												'provincia', anag.cod_provincia_impresa,
												'nazione', anag.nazione_impresa,
												'comune', anag.id_comune_impresa,
												'latitudine', anag.lat_impresa,
												'longitudine', anag.long_impresa
												)
								)
		) impresa,
		json_build_object('stabilimento',json_build_object('denominazione', anag.denominazione_stab,
								   'id_asl', anag.asl_rif,
								   'id_stato',null,
								   'categoria_rischio',anag.categoria_rischio,
								   'data_prossimo_controllo',anag.data_controllo,
								   'note', anag.note_stabilimento,
								   'data_inizio_attivita',anag.data_inizio_attivita_stab,
								   'data_fine_attivita',anag.data_fine_attivita_stab,
								   'indirizzo', json_build_object('toponimo', anag.toponimo_stab,
												  'descr_indrizzo', anag.indirizzo_stab, 
												  'civico', anag.civico_stab,
												  'cap', anag.cap_stab,
												  'provincia', anag.cod_provincia_stab,
												  'nazione', anag.nazione_stab,
												  'comune', anag.id_comune_stab,
												'latitudine', anag.lat_stab,
												'longitudine', anag.long_stab
												)
								  )
								  

		) stabilimento
	from view_anagrafica_privati_fissi anag
	
	
LOOP
	FOR recLinea IN
		select 
			 json_build_object('linee_attivita',
					   json_agg(json_build_object('idmacroarea', attivita.idmacroarea, 
								      'idaggregazione' , attivita.idaggregazione, 
								      'idattivita', attivita.idattivita,
								      'attivitanonmappata', attivita.attivitanonmappata, 
								      'codiceunivoco', attivita.codiceunivoco, 
								      'numregistrazione', attivita.n_reg,
								      'cun',attivita.num_riconoscimento,
								      'id_stato',attivita.id_stato_linea,
								      'id_tipo_attivita',attivita.tipo_attivita,
								      'data_inizio_attivita',data_inizio_attivita,
								      'data_fine_attivita',data_fine_attivita))
			 ) linee_attivita
		from
		(
			select distinct
				null::integer idmacroarea,	
				null::integer idaggregazione,
				null::integer idattivita,
				attivita attivitanonmappata,
				'OPR-OPR-X' codiceunivoco,
				null::text n_reg, --da ultima mail di bartolo del 08/03/2018
				num_riconoscimento,
				ls.code id_stato_linea,
				ls.description stato_linea,
				tipo_attivita,
				data_inizio_attivita,
				data_fine_attivita
			from 
				ricerche_anagrafiche_old_materializzata anamat
				left join anagrafica.lookup_stati ls on lower(trim(ls.description))=lower(trim(case when id_stato=4 and tipo_ricerca_anagrafica=3 then 'CESSATO E ARCHIVIATO' 
												         when id_stato=0 and tipo_ricerca_anagrafica=3 then 'ATTIVO E ARCHIVIATO' 
												         when id_stato=2 and tipo_ricerca_anagrafica=3 then 'SOSPESO E ARCHIVIATO'
												         else
														anamat.stato
													end))
			where 
				riferimento_id=recImpresa.riferimento_id and
				riferimento_id_nome=recImpresa.riferimento_id_nome and
				riferimento_id_nome_col=recImpresa.riferimento_id_nome_col and
				riferimento_id_nome_tab=recImpresa.riferimento_id_nome_tab
				
		) attivita
		
	LOOP
		qry:= 'select ret_operazione,ret_id_impresa from anagrafica.anagrafica_inserisci_osa_estesi_fissi(' || '''' || replace(CAST(recImpresa.soggetto_fisico as text),'''','''''') || '''' || ',' || 
									     '''' || replace(CAST(recImpresa.impresa as text),'''','''''') || '''' || ',' ||
									     '''' || replace(CAST(recImpresa.stabilimento as text),'''','''''') || '''' || 
									     ',null,' ||
									     '''' || replace(CAST(recLinea.linee_attivita as text),'''','''''') || '''' || 
										 ',null,' ||
									     '''' || utente || '''' || ')';
	
		--raise info '%',qry;	
		
		PERFORM dblink_connect('dblink_trans',strConnTarget);
		begin
			for recInserimento in
				select * from dblink('dblink_trans',qry) as t1(ret_operazione_osa_inserito integer, ret_id_osa integer)
			loop
				
				FOR recStabInseriti IN
					select * from dblink('dblink_trans','select id_stabilimento from anagrafica.rel_imprese_stabilimenti where id_impresa=' || recInserimento.ret_id_osa) AS t_stabInseriti(idStabilimentoInserito integer)
				LOOP
					--MAPPATURA new Impresa con old impresa
					PERFORM dblink_exec('dblink_trans', 'insert into anagrafica.anagrafica_mappatura_old_new ' ||
							   '(id_impresa_new,riferimento_id,riferimento_id_nome,riferimento_id_nome_col,riferimento_id_nome_tab,id_stabilimento_new,entered_old,tipo_operatore) ' ||
							   'values(' || 
							   '''' || recInserimento.ret_id_osa || '''' || ',' || 
							   '''' || recImpresa.riferimento_id || '''' || ',' || 
							   '''' || recImpresa.riferimento_id_nome || '''' || ',' || 
							   '''' || recImpresa.riferimento_id_nome_col || '''' || ',' || 
							   '''' || recImpresa.riferimento_id_nome_tab || '''' || ',' || 
							   '''' || recStabInseriti.idStabilimentoInserito || '''' || ',' ||
							   '''' || recImpresa.data_inserimento || '''' || ',' ||
							   '''' || 'PRIVATI FISSI' || '''' || ')');

					--GESTIONE NUM REGISTRAZIONE STABILIMENTO/LINEE
					qryNumRegStab:= 'select anagrafica.anagrafica_inserisci_numero_registrazione_stabilimento(' || '''' || recStabInseriti.idStabilimentoInserito || '''' || ') as num_reg_stab into TEMPORARY numregstab';
					--raise info '%',qryNumRegStab;
					PERFORM dblink_exec('dblink_trans',qryNumRegStab);
					FOR recInserimentoTemp in
						select * from dblink('dblink_trans','select num_reg_stab from numregstab') AS t_numRegStab(num_reg_stab text)
					LOOP
						PERFORM dblink_exec('dblink_trans','update anagrafica.rel_stabilimenti_linee_attivita set numero_registrazione =' || '''' || recInserimentoTemp.num_reg_stab || '001' || '''' || ' where id_stabilimento=' || recStabInseriti.idStabilimentoInserito);
						
					END LOOP;
					--FINE GESTIONE NUM REGISTRAZIONE STABILIMENTO/LINEE
					
					PERFORM dblink('dblink_trans','COMMIT;');
				END LOOP;
			
				----GESTIONE LOG SOGGETTO FISICO IMPRESA e STABILIMENTO
				--(0) inserimento effettuato senza duplicati
				--(1) valore di ritorno se non esiste l'impresa
				--(2) valore di ritorno se esiste già il soggetto fisico di impresa
				--(3) valore di ritorno se esiste già il soggetto fisico di stabilimento
	
	
				--Log duplicati Soggetti Fisici di impresa
				if(recInserimento.ret_operazione_osa_inserito=2) then
					sqlLog:= concat('INSERT INTO anagrafica.anagrafica_log_duplicati_soggetti_fisici',
						'(codice_fiscale,nome,cognome,data_nascita,comune_nascita,riferimento_id,riferimento_nome_tab,new_id_impresa) ',
						'VALUES(') ||
					 concat_ws(',',	coalesce('''' || recImpresa.codice_fiscale_rappresentante || '''','null'),
							coalesce('''' || replace(recImpresa.nome_rappresentante,'''','''''') || '''','null'),
							coalesce('''' || replace(recImpresa.cognome_rappresentante,'''','''''') || '''','null'),
							coalesce('''' || recImpresa.data_nascita_rappresentante || '''','null'),  
							coalesce('''' || replace(recImpresa.comune_nascita_rappresentante,'''','''''') || '''','null'),
							'''' || recImpresa.riferimento_id || '''',  
							'''' || recImpresa.riferimento_id_nome_tab || '''', 
							recInserimento.ret_id_osa ||
							')');
							
					PERFORM dblink_exec('dblink_trans', sqlLog);
					PERFORM dblink('dblink_trans','COMMIT;');
					
				end if;
			
				--Log duplicati Soggetti Fisici di stabilimento
				if(recInserimento.ret_operazione_osa_inserito=3) then
					-- da gestire in futuro
				end if;
			end loop;
			EXCEPTION when others then
					RAISE info  'Errore % ==> riferimento_id:%  riferimento_id_nome:%  riferimento_id_nome_col:%  riferimento_id_nome_tab:%  qry:%', 
						      SQLERRM, 
						      recImpresa.riferimento_id,
						      recImpresa.riferimento_id_nome,
						      recImpresa.riferimento_id_nome_col,
						      recImpresa.riferimento_id_nome_tab,
						      qry;
		end;
		PERFORM dblink_disconnect('dblink_trans'); 
		
	END LOOP;

END LOOP;


return 'OK';

END;
$$;

--------------------------

CREATE or replace FUNCTION public.update_operatori_commerciali_bdr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
   DECLARE
   tipo integer;
   updateQuery text;
   cursore refcursor  ;
   strada text;
   latitude1 double precision ; 
   longitude1 double precision ;
   cap text;
   cityIn text;
   orgidc int ;
   
   BEGIN
	
		if (NEW.org_id_c is not null and  NEW.org_id_c>0 ) then
		updateQuery := 'UPDATE organization SET name = ''' || NEW.name || ''',partita_iva= ' ||NEW.partita_iva || '
 ,modified = ''' || NEW.modified || ''', notes = ''' || coalesce('''' || replace(NEW.notes, '''','''''') || ',NULL') || ''', 
codice_fiscale = ''' || coalesce('''' || NEW.codice_fiscale_rappresentante || '''','NULL') || ''', 
namefirst = ''' || coalesce('''' || NEW.nome_rappresentante || '''','NULL') || ''', 
namelast = ''' || coalesce('''' || NEW.cognome_rappresentante || '''','NULL') || ''', 
data_nascita = ''' || coalesce('''' || NEW.data_nascita_rappresentante || '''',NULL) || ''', 
luogo_nascita = ''' || coalesce('''' || NEW.luogo_nascita_rappresentante || '''','NULL') || ''', 
autorizzazione = ''' || coalesce('''' || NEW.autorizzazione || '''','NULL') ||  ''' WHERE org_id = '|| NEW.org_id_c ;

		PERFORM dblink_connect('conn-canina',(select * from conf.get_pg_conf('BDU')));
		PERFORM dblink_exec('conn-canina',updateQuery);

PERFORM dblink_disconnect('conn-canina');
end if;
    RETURN NEW;
   END
$$;
