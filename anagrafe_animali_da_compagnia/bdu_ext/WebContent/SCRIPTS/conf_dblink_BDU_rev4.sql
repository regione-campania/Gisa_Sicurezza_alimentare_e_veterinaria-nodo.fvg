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
('COLLAUDOCRED_SICLAV','dbSICLAVL','siclav','siclav');


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

----------------------------

CREATE OR REPLACE FUNCTION public.dbi_insert_utente(
	usr character varying,
	password character varying,
	role_id integer,
	enteredby integer,
	modifiedby integer,
	enabled boolean,
	site_id integer,
	namefirst character varying,
	namelast character varying,
	cf character varying,
	notes text,
	luogo text,
	nickname character varying,
	email character varying,
	expires timestamp with time zone,
	id_importatore integer,
	num_registrazione_gisa text,
	id_prov_iscr_albo integer,
	nr_iscrizione_albo text,
	input_telefono text)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
   DECLARE
msg text ;
us_id int ;
con_id int;
us_id2 int ;
id_canile integer;
_id_stabilimento_gisa integer;
query_vam text;
output_text text;
   
BEGIN

	IF (role_id=-1) THEN
		enabled:=false;
	ELSE
		enabled:=true;
	END IF;

	IF (id_importatore=-1) THEN
		id_importatore:=null;
	END IF;

	_id_stabilimento_gisa := (select t1.output FROM dblink((select * from conf.get_pg_conf('GISA')), 'select id from opu_stabilimento where numero_registrazione ilike ''' || num_registrazione_gisa || '''') as t1(output integer));

	id_canile :=  (select rel.id from opu_relazione_stabilimento_linee_produttive rel, opu_stabilimento stab, opu_operatore op where stab.id_stabilimento_gisa = _id_stabilimento_gisa and rel.id_stabilimento = stab.id and rel.id_linea_produttiva = 5 and rel.data_fine is null and rel.trashed_date is null and stab.id_operatore = op.id and op.trashed_date is null);

	
		us_id=nextVal('access_user_id_seq');
		con_id=nextVal('contact_contact_id_seq');
		INSERT INTO access_ ( user_id, username, password, contact_id, site_id, role_id, enteredby, modifiedby, timezone, currency, language, enabled, expires,id_importatore,id_linea_produttiva_riferimento ) 
		VALUES (  us_id, usr, password, con_id, site_id, role_id, 964, 964, 'Europe/Berlin', 'EUR', 'it_IT', enabled, expires::timestamp without time zone,id_importatore,id_canile); 

		--con_id=currVal('contact_contact_id_seq');
		--us_id=currVal('access_user_id_seq');		
		INSERT INTO contact_ ( contact_id, user_id, namefirst, namelast, enteredby, modifiedby, site_id, codice_fiscale, notes, enabled,luogo,nickname,id_provincia_iscrizione_albo_vet_privato,nr_iscrione_albo_vet_privato, telefono) 
		VALUES ( con_id, us_id, namefirst, namelast, 964, 964, site_id, cf, notes, enabled,luogo,nickname,id_prov_iscr_albo,nr_iscrizione_albo, input_telefono);
			
		--con_id=currVal('contact_contact_id_seq');
		INSERT INTO contact_emailaddress(contact_id, emailaddress_type, email, enteredby, modifiedby, primary_email)
		VALUES (con_id, 1, email, 964, 964, true);
	

	IF (id_canile is not null) THEN
		us_id2=nextVal('access_collegamento_id_seq');
		INSERT INTO access_collegamento (id,id_utente,id_collegato,enabled) 
		VALUES (us_id2,us_id,id_canile,enabled); 
	END IF;
	
	--Se utente privato, effettuo inserimento anche in Vam
	--18 è il ruolo LP in Vam
        if(role_id=24) then 
	query_vam:= concat ('select * from dbi_insert_utente(''', usr, ''' , ''' , password, ''',18,-1,-1,true,-1,''' , namefirst, ''' , ''' , namelast , ''','''',null,null,null,null,null,-1,null,', coalesce(id_prov_iscr_albo,'-1',id_prov_iscr_albo), ',''', nr_iscrizione_albo,''',null)' );
        raise info 'query_vam: %', query_vam;
	select t1.output into output_text FROM dblink((select * from conf.get_pg_conf('VAM')), query_vam) as t1(output text);
	end if;

	msg = 'OK';
	RETURN msg;

END
$BODY$;

----------------------------

create or replace function public.dblink_get_messaggio_home(ambiente_ text, endpoint_ text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	dblink_config text;
	header_ text;
	body_ text;
	footer_ text;
	msg text;
BEGIN
	
	msg := '<center><font color=''red''><h1>';
	select * from conf.get_pg_conf('GUC') into dblink_config;

	select r.header, r.body, r.footer from dblink(dblink_config,'select header, body, footer from get_messaggio_home('''|| endpoint_ ||''')')
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

-------------------------

create or replace function public.get_strade_napoli(_tipo text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE

risultato text;

BEGIN

risultato := '';

IF _tipo is null THEN
_tipo = '';
END IF;

select t1.output into risultato FROM dblink((select * from conf.get_pg_conf('GISA')), 'select * from get_strade_napoli('''||_tipo||''');') as t1(output text);

raise info 'tipo % risultato %', _tipo, risultato;

return risultato ;
	
END;
$$;
