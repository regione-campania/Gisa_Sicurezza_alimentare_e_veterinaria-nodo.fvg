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

create or replace function public.allinea_tutte_cliniche_vam_per_hd(_id_utente_guc integer, id_utente_operazione integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
   rec integer;
   conta_associazione integer;
   verifica_esistenza integer;
   query text;
   id_clinica_out integer;
   nome_clinica text;
   query_endpoint text;
   output_vam text;
   id_super_utente integer;
   id_nuovo_utente integer;
   categories_name text;
   codice_fiscale text;
   nome text;
   messaggio text;
   conn_vam text;
BEGIN
	select * from conf.get_pg_conf('VAM') into conn_vam;
	-- controllo preliminare su GUC per admin Vam
	verifica_esistenza := (select count(*) from guc_utenti u join guc_ruoli r on r.id_utente=u.id
	where (r.trashed is null or r.trashed is false) and u.enabled
	and r.ruolo_integer > 0 and r.endpoint ilike 'vam' 
	and r.ruolo_integer in (1,2,16,17) and u.id = _id_utente_guc);
	if (verifica_esistenza > 0) then 
	        raise info 'esiste in guc utente' ;
		codice_fiscale := (select g.codice_fiscale from guc_utenti g where g.id  = _id_utente_guc limit 1);
		id_super_utente :=(select id
				   --FROM dblink(conn_vam, 'SELECT 
			FROM dblink(conn_vam, 'SELECT superutente from utenti where codice_fiscale ilike '''||codice_fiscale||''' limit 1') 
			t1(id integer));
		raise info 'id_super_utente %', id_super_utente;
		FOR rec IN
			select t1.id_clinica_out
				   --FROM dblink(conn_vam, 'SELECT 
			FROM dblink(conn_vam, 'SELECT * from public.dbi_get_cliniche_utente_attive()') 
			t1(asl_id integer, id_clinica_out integer, clinica_out text)
		LOOP
			raise info 'id clinica: %', rec;
			conta_associazione := (select count(*) from guc_cliniche_vam where id_clinica  = rec and id_utente = _id_utente_guc);
			if (conta_associazione = 0) then -- nessuna associazione quindi inserisci la clinica in guc
				--parte I GUC
				insert into guc_cliniche_vam(id_clinica, descrizione_clinica, id_utente) values(rec, (select clinica_out
																--FROM dblink(conn_vam, 'SELECT 
															FROM dblink(conn_vam, 'SELECT nome_clinica from public.dbi_get_cliniche_utente_attive() where id_clinica='||rec||'') 
															t1(clinica_out text)) 
				,_id_utente_guc);
				 -- parte 2 VAM
				 -- verifo se presente la clinica?
				 conta_associazione := (select t1.numero
							  FROM dblink(conn_vam, 'select count(*) from utenti where clinica  = '||rec||' and codice_fiscale ilike '''||codice_fiscale||'''') 
							  t1(numero integer));
				raise info 'numero associazione clinica %', conta_associazione;
				 if (conta_associazione = 0) then -- significa che in vam non esiste
					  raise info 'inserisco associazione in vam';
					  output_vam:= (select t1.esito
					  --FROM dblink(conn_vam, 'SELECT 
								  FROM dblink(conn_vam, 'select * from public.allinea_tutte_cliniche_vam_per_hd('''||codice_fiscale||''',''Amministratore'','||rec||')')
								  t1(esito text)
							);
					raise info 'output vam: %',output_vam;
				end if; -- fine inserimento in vam
			end if;
			
		END LOOP;

		messaggio :='{"Esito" : "OK", "DescrizioneErrore" : ""}';

	else 
		messaggio :='{"Esito" : "KO", "DescrizioneErrore" : "Utente non presente in GU con ruolo di amministratore VAM"}';
	end if;
	
	return messaggio;
END;
$$;

----------------------------------

create or replace function public.delta_utenti(ambiente_esterno text) RETURNS TABLE(codice_fiscale character varying, ruolo_integer integer, asl_id integer, endpoint character varying, nome character varying, cognome character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
	dblink_config text;
BEGIN
	select * from conf.get_pg_conf('GUC') into dblink_config;
	
	return query 
	select * from dblink(dblink_config,'select * from prepare_delta_utenti()')
	as r(codice_fiscale character varying, ruolo_integer integer, asl_id integer, endpoint character varying, nome character varying, cognome character varying)
	except
	select * from prepare_delta_utenti()
	order by codice_fiscale, endpoint, ruolo_integer;
END;
$$;


----------------------------------

create or replace function public.execute_delta_utenti(ambiente_esterno text, cf_utente text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	count_utenti integer;
	query_ text := 'select * from delta_utenti('''||ambiente_esterno||''') ';
	dblink_config text;
	r record;
	id_richiesta integer;
	res text;
	lista_cliniche integer[];
BEGIN
	select * from conf.get_pg_conf('GUC') into dblink_config;
	
	IF(cf_utente is not null and cf_utente != '') THEN
		query_ := query_ || 'where codice_fiscale = '''|| cf_utente||'''';
	END IF;
	
	--EXECUTE query_ into count_utenti;
	count_utenti := 0;
	res := '';
	
	for r in EXECUTE query_
	loop 
		raise notice '% - % %', r.codice_fiscale, r.ruolo_integer, r.endpoint;
		lista_cliniche := (select * from dblink(dblink_config::text,'select * from get_cliniche_vam('''||r.codice_fiscale||''')') as r (lista_cliniche integer[]));
		-- inserimento richiesta
		CASE
			WHEN r.endpoint = 'Vam' THEN
				IF lista_cliniche is not null THEN
					id_richiesta := spid.dbi_insert_spid_registrazioni(1,1,r.cognome,r.nome,r.codice_fiscale,(select date_part('year',current_date) ||'-RIC-'|| (select to_char((select max(id)+1 from spid.spid_registrazioni),'fm00000000'))),'','',-1,-1,r.ruolo_integer,lista_cliniche,-1,'', '','','', '','','', CURRENT_DATE,'', '','',-1,'',-1,'', '', '',r.asl_id, -1,'', '', -1,'','');
				END IF;
				raise notice 'Vam';
			WHEN r.endpoint = 'Gisa' THEN
				id_richiesta := spid.dbi_insert_spid_registrazioni(1,1,r.cognome,r.nome,r.codice_fiscale,(select date_part('year',current_date) ||'-RIC-'|| (select to_char((select max(id)+1 from spid.spid_registrazioni),'fm00000000'))),'','',r.ruolo_integer,-1,-1,lista_cliniche,-1,'', '','','', '','','', CURRENT_DATE,'', '','',-1,'',-1,'', '', '',r.asl_id, -1,'', '', -1,'','');
				raise notice 'Gisa';
			WHEN r.endpoint = 'bdu' THEN
				id_richiesta := spid.dbi_insert_spid_registrazioni(1,1,r.cognome,r.nome,r.codice_fiscale,(select date_part('year',current_date) ||'-RIC-'|| (select to_char((select max(id)+1 from spid.spid_registrazioni),'fm00000000'))),'','',-1,r.ruolo_integer,-1,lista_cliniche,-1,'', '','','', '','','', CURRENT_DATE,'', '','',-1,'',-1,'', '', '',r.asl_id, -1,'', '', -1,'','');
				raise notice 'bdu';
			WHEN r.endpoint = 'Digemon' THEN
				id_richiesta := spid.dbi_insert_spid_registrazioni(1,1,r.cognome,r.nome,r.codice_fiscale,(select date_part('year',current_date) ||'-RIC-'|| (select to_char((select max(id)+1 from spid.spid_registrazioni),'fm00000000'))),'','',-1,-1,-1,lista_cliniche,-1,'', '','','', '','','', CURRENT_DATE,'', '','',-1,'',r.ruolo_integer,'', '', '',r.asl_id, -1,'', '', -1,'','');
				raise notice 'Digemon';
		END CASE;
		
		-- elabora richiesta
		IF id_richiesta is not null THEN
		res = res || 'n. ' || id_richiesta ||(select spid.processa_richiesta((select numero_richiesta from spid.spid_registrazioni where id = id_richiesta),6567))|| ';';
		count_utenti = count_utenti + 1;
		id_richiesta := null;
		END IF;
	end loop;
	return count_utenti::text||' richieste elaborate; <br>RIEPILOGO<br><br>'||res;
	
END;
$$;

------------------

create or replace function public.raggruppa_utente_vam_bdu_asl(_id_guc_utente_1 integer, _id_ruolo_guc_bdu integer, _id_guc_utente_2 integer, _id_ruolo_guc_vam integer, username_rif text) RETURNS text
    LANGUAGE plpgsql
    AS $$

  DECLARE 
	esito text;
	descrizione_errore text;
	conta integer;
	username_out text;
	password_out text;
	id_guc_out text;
	output_guc text;
	output_bdu text;
	output_vam text;
	_query text;
	indice integer;
	_asl_id integer;
	msg text;
	ruolo_bdu text;
	ruolo_vam text;
	num_clinica integer;
	clinica integer[];
	id_cl integer;
	output text;
  BEGIN
	descrizione_errore='';
	esito='';
	output_bdu = '';
	output_vam = '';
	output_guc := '';
	output := '';

	--recupero asl
	_asl_id := (select asl_id from guc_utenti where username ilike username_rif);

	ruolo_bdu := (select ruolo_string from guc_ruoli where id_utente= _id_guc_utente_1 and ruolo_integer = _id_ruolo_guc_bdu and (trashed is null or trashed = false) and endpoint ilike 'bdu');
	ruolo_vam := (select ruolo_string from guc_ruoli where id_utente= _id_guc_utente_2 and ruolo_integer = _id_ruolo_guc_vam and (trashed is null or trashed = false) and endpoint ilike 'vam');

	--disabilito tutti e 2 gli utenti
	output_bdu := (select * from spid.elimina_ruolo_utente_guc(_id_guc_utente_1,_id_ruolo_guc_bdu,'bdu'));
	raise info 'output bdu %', output_bdu;

	output_vam := (select * from spid.elimina_ruolo_utente_guc(_id_guc_utente_2,_id_ruolo_guc_vam,'vam'));

	-- ne creo uno nuovo per guc, bdu e vam 
	select concat(
	concat('select * from dbi_insert_utente_guc(',
	'''', (select codice_fiscale from guc_utenti where username ilike username_rif), '''', ', ',
	'''', (select cognome from guc_utenti where username ilike username_rif), '''', ', ',
	'''', (select email from guc_utenti where username ilike username_rif), '''', ', ',
	'''', '1', '''', ', ',
	6567, ', ',
	'NULL::timestamp without time zone', ', ', 
	6567, ', ',
	'''', 'INSERIMENTO UTENTE PER RICHIESTA DI RAGGRUPPAMENTO UTENTE', '''', ', ',
	'''', (select nome from guc_utenti where username ilike username_rif), '''',  ', ',
	'''', null::character varying, '''', ', ', 
	'''', null::character varying, '''', ', ', 
	(_asl_id), ', ',
	'''', null::character varying, '''', ', ', 
	-1, ', ',
	'''', '', '''', ', '), 
	concat('''', (select coalesce(luogo,'') from guc_utenti where username ilike username_rif), '''', ', ',
	'''', (select coalesce(num_autorizzazione,'') from  guc_utenti where username ilike username_rif), '''', ', ', 
	-1, ', ',
	-1, ', ',
	'''', '', '''', ', ',
	'''', '', '''', ', ',
	'''', (select coalesce(id_provincia_iscrizione_albo_vet_privato,-1) from guc_utenti where username ilike username_rif), '''', ', ',
	'''', (select nr_iscrione_albo_vet_privato from guc_utenti where username ilike username_rif), '''', ', ',
	0, ', ',
	'''', '', '''', ', ',
	'''', '', '''', ', ',
	'''', '', '''', ', ',
	'''', '', '''', ', ',
	'''', '', '''', ', ',
	'''', '', '''', ', ',
	'''', '', '''', ', ',
	0, ', '), 
	concat('''', null::character varying, '''', ', ', 
	'''', (select telefono from guc_utenti where username ilike username_rif), '''', ', ', 
	-1, ', ',--id ruolo gisa
	'''', '', '''', ', ', --descrizione ruolo gisa
	-1, ', ', -- id ruolo gisa_ext
	'''', '' , '''', ', ',--descrizione ruolo gisa_ext
	(_id_ruolo_guc_bdu), ', ',
	'''', (ruolo_bdu), '''', ', ',
	(_id_ruolo_guc_vam), ', ',
	'''', (ruolo_vam), '''', ', ',
	-1, ', ',
	'''', '', '''', ', ',
	-1 , ', ', -- digemon
	'''', '', '''', ', ', -- ruolo digemon
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
	'''', '', '''', '); ')) into _query;

	EXECUTE FORMAT(_query) INTO output_guc;
	output_guc := '{"Esito" : "'||output_guc ||'"}';
	raise info 'output guc: %', output_guc;
	
	-- se inserimento di GUC è andato a buon fine
	
	if(position('OK' in output_guc) > 0) then
		raise info 'entro qui???';
		username_out := (select split_part(output_guc,';;','3'));
		raise info ' username %', username_out;
		id_guc_out := (select split_part(output_guc,';;','2'));
		raise info ' id_guc_out %', id_guc_out;
	
		-- bdu
		select concat(
		'select * from dbi_insert_utente(', 
		'''', username_out, '''', ', ',
		'''', md5(username_out), '''', ', ',
		_id_ruolo_guc_bdu, ', ',
		6567, ', ',
		6567, ', ',
		'''', 'true', '''', ', ',
		_asl_id, ', ',
		'''', (select nome from guc_utenti  where username ilike username_rif), '''',  ', ',
		'''', (select cognome from guc_utenti  where username ilike username_rif), '''', ', ',
		'''', (select codice_fiscale from guc_utenti  where username ilike username_rif), '''', ', ',
		'''', 'INSERIMENTO UTENTE PER RICHIESTA DI RAGGRUPPAMENTO UTENTE', '''', ', ',
		'''', (select luogo from guc_utenti where username ilike username_rif), '''', ', ',
		'''', null::character varying, '''', ', ', 
		'''', (select email from guc_utenti where username ilike username_rif), '''', ', ',
		'NULL::timestamp with time zone', ', ', 
		-1, ', ',
		-1, ', ',	
		'''', (select coalesce(id_provincia_iscrizione_albo_vet_privato,-1) from guc_utenti where username ilike username_rif), '''', ', ',
		'''', (select nr_iscrione_albo_vet_privato from guc_utenti where username ilike username_rif), '''', ', ',
		'''', (select telefono from guc_utenti  where username ilike username_rif), '''', '); ') into _query;	

		--output_bdu := (select * from spid.esegui_query(_query, 'bdu', 6567,'dbname=bdu'));
		output_bdu  := (select t1.output FROM dblink((select * from conf.get_pg_conf('BDU'))::text, _query) as t1(output text));

		raise info 'output bdu: %', output_bdu;
		output_bdu := '{"Esito" : "'||output_bdu ||'"}';

		-- recupero cliniche vam
		num_clinica :=(select count(*) from guc_cliniche_vam  where id_utente = _id_guc_utente_2);
                clinica:= (select array(select distinct id_clinica  from guc_cliniche_vam  where id_utente = _id_guc_utente_2));
		
		indice := 0;
		WHILE indice < num_clinica 
		LOOP
			id_cl = clinica[indice+1];
			raise info 'clinica %', id_cl;
			select concat(
			'select * from dbi_insert_utente(', 
			'''', username_out, '''', ', ',
			'''', md5(username_out), '''', ', ',
			(_id_ruolo_guc_vam), ', ',
			6567, ', ',
			6567, ', ',
			'''', '1', '''', ', ',
			_asl_id, ', ',
			'''', (select nome from guc_utenti where username ilike username_rif), '''',  ', ',
			'''', (select cognome from guc_utenti where username ilike username_rif), '''', ', ',
			'''', (select codice_fiscale from guc_utenti where username ilike username_rif), '''', ', ',
			'''', 'INSERIMENTO UTENTE PER RICHIESTA DI RAGGRUPPAMENTO UTENTE', '''', ', ',
			'''', (select coalesce(luogo,'') from guc_utenti where username ilike username_rif), '''', ', ',
			'''', null::character varying, '''', ', ', 
			'''', (select email from guc_utenti where username ilike username_rif), '''', ', ',
			'NULL::timestamp with time zone', ', ', 
			id_cl::int, ', ', -----------------------------------inserisco clinica poi ciclo dopo
			'''', '-1', '''', ', ',
			-1, ', ',
			'''', null::character varying, '''', ', ', 
			'''', (select telefono from guc_utenti where username ilike username_rif), '''', '); ') into _query;

			output_vam  := (select t1.output FROM dblink((select * from conf.get_pg_conf('VAM'))::text, _query) as t1(output text));
			output_vam := '{"Esito" : "'||output_vam ||'"}';

			indice = indice+1;
		END LOOP;	
		
		--vam
		if(get_json_valore(output_vam, 'Esito')='OK') then
		-- aggiungere le cliniche in GUC

			_query = (select concat('insert into guc_cliniche_vam(id_clinica, descrizione_clinica, id_utente) (select id_clinica, descrizione_clinica, '||id_guc_out||' from guc_cliniche_vam  where id_utente = '||_id_guc_utente_2||') returning ''OK'';'));
			raise info 'stampa query insert vam cliniche%', _query;
			EXECUTE FORMAT(_query) INTO output_guc;
		end if;

		msg := 'OK';
		-- richiamo disattiva utente su utente BDU e VAM
		output := (select * from public.disattiva_utente(_id_guc_utente_1));
		output := (select * from public.disattiva_utente(_id_guc_utente_2));

	else 
		msg := 'KO';
		descrizione_errore := 'Inserimento in GUC fallito.';
	end if;
	return '{"Esito" : "'||msg||'", "DescrizioneErrore" : "'||descrizione_errore||'","username" : "'||username_out||'"}';
	return msg;

  END;
$$;

--------------------

create or replace function spid.get_dettagli_estesi_utente_guc(_idutente integer) RETURNS json
    LANGUAGE plpgsql
    AS $$
   DECLARE
_username text;
_output json;
BEGIN

SELECT username into _username from guc_utenti_ where id = _idutente;

select row_to_json (row) into _output from 
(select 

u.num_registrazione_stab as "Numero Registrazione GISA",
gac.nome as "Gestore Acque",
trim(u.piva) as "Partita Iva",
(select id_tipologia_utente from spid.spid_registrazioni r
join spid.spid_registrazioni_esiti e on r.numero_richiesta = e.numero_richiesta
where get_json_valore(e.json_esito, 'Username') = _username and e.trashed_date is null 
--where e.json_esito ilike '%'||_username||'%' and e.trashed_date is null 
order by data_esito desc limit 1) as "IdTipologiaUtente"
from guc_utenti_ u

left join (select * FROM dblink((select * from conf.get_pg_conf('GISA')), 'SELECT id, nome::text from public_functions.dbi_get_gestori_acque(-1)')  t1(id integer, nome text)) gac on gac.id = u.gestore_acque

where u.id = _idutente
) row;

return _output;

END
$$;

-------------------------

DROP FUNCTION IF EXISTS spid.get_lista_richieste(text);

create or replace function spid.get_lista_richieste(_numero_richiesta text DEFAULT NULL::text) RETURNS TABLE(id integer, id_tipologia_utente integer, tipologia_utente text, id_tipo_richiesta integer, tipo_richiesta text, cognome text, nome text, codice_fiscale text, email text, telefono text, id_ruolo_gisa integer, ruolo_gisa text, id_ruolo_bdu integer, ruolo_bdu text, id_ruolo_vam integer, ruolo_vam text, id_ruolo_gisa_ext integer, ruolo_gisa_ext text, id_ruolo_digemon integer, ruolo_digemon text, id_clinica_vam integer[], clinica_vam text[], id_ruolo_sicurezza_lavoro integer, ruolo_sicurezza_lavoro text, identificativo_ente text, piva_numregistrazione text, comune text, istat_comune text, nominativo_referente text, ruolo_referente text, email_referente text, telefono_referente text, data_richiesta timestamp without time zone, codice_gisa text, indirizzo text, id_gestore_acque integer, gestore_acque text, cap text, pec text, numero_richiesta text, esito_guc boolean, esito_gisa boolean, esito_gisa_ext boolean, esito_bdu boolean, esito_vam boolean, esito_digemon boolean, esito_sicurezza_lavoro boolean, data_esito timestamp without time zone, stato integer, utente_esito text, id_asl integer, asl text, provincia_ordine_vet text, numero_ordine_vet text, numero_decreto_prefettizio text, scadenza_decreto_prefettizio text, numero_autorizzazione_regionale_vet text, id_tipologia_trasp_dist integer, esito text, id_guc_ruoli integer, endpoint_guc_ruoli text, ruolo_guc_ruoli text, in_nucleo boolean, in_dpat boolean)
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
RETURN QUERY

SELECT r.id, r.id_tipologia_utente, tip.descr as tipologia_utente, r.id_tipo_richiesta, ric.descr as tipologia_richiesta, 
r.cognome::text, r.nome::text, r.codice_fiscale::text, r.email::text, r.telefono::text, r.id_ruolo_gisa::int, g.ruolo as ruolo_gisa, r.id_ruolo_bdu::int,
b.ruolo as ruolo_bdu, r.id_ruolo_vam::int, v.ruolo as ruolo_vam, r.id_ruolo_gisa_ext::int, ge.ruolo as ruolo_ext, r.id_ruolo_digemon::int, dg.ruolo as ruolo_digemon,
r.id_clinica_vam, 
--cli.nome_clinica, 
(select array_agg(nome_clinica)
   FROM dblink((select * from conf.get_pg_conf('VAM')), 'SELECT 
			id_clinica, nome_clinica from dbi_get_cliniche_utente()')
t1(id_clinica integer, nome_clinica text) where id_clinica = ANY (r.id_clinica_vam)),
--r.id_ruolo_sicurezza_lavoro::integer, ges.ruolo as ruolo_sicurezza_lavoro, 
-1, ''::text,
r.identificativo_ente::text, r.piva_numregistrazione::text, 
(select comuni.comune::text from comuni where codiceistatcomune::integer = (select case when length(r.comune)> 0 then r.comune::integer else -1 end)), coalesce(r.comune,'-1')::text as istat_comune, 
r.nominativo_referente::text,
r.ruolo_referente::text, r.email_referente::text, r.telefono_referente::text, r.data_richiesta, r.codice_gisa::text,
r.indirizzo::text, r.id_gestore_acque::integer, gac.nome, r.cap::text, r.pec::text, r.numero_richiesta::text,
es.esito_guc, es.esito_gisa, es.esito_gisa_ext, es.esito_bdu, es.esito_vam, es.esito_digemon, es.esito_sicurezza_lavoro, es.data_esito, es.stato, (select concat_ws(' ', u.nome, u.cognome) from utenti u where u.id = es.id_utente_esito)::text,
r.id_asl, l.nome::text, r.provincia_ordine_vet::text, r.numero_ordine_vet::text, r.numero_decreto_prefettizio::text, r.scadenza_decreto_prefettizio::text,
r.numero_autorizzazione_regionale_vet::text, r.id_tipologia_trasp_dist, es.json_esito, r.id_guc_ruoli, gr.endpoint::text, gr.ruolo_string::text,
f.in_nucleo, f.in_dpat
from spid.spid_registrazioni r 
left join asl l on l.id = r.id_asl
join spid.spid_tipo_richiesta ric on ric.id = r.id_tipo_richiesta
join spid.spid_tipologia_utente tip on tip.id = r.id_tipologia_utente
left join spid.spid_registrazioni_esiti es on es.numero_richiesta = r.numero_richiesta and es.trashed_date is null
left join spid.spid_registrazioni_flag f on f.numero_richiesta = r.numero_richiesta and f.trashed_date is null
left join guc_ruoli gr on gr.id = r.id_guc_ruoli
left join (
select * 
   FROM dblink((select * from conf.get_pg_conf('GISA')), 'SELECT 
			id, nome::text from public_functions.dbi_get_gestori_acque(-1)')  -----> perchÃ¯Â¿Â½ non va bene passare il valore???
t1(id integer, nome text)
) gac on gac.id = r.id_gestore_acque::integer
left join (
select * 
   FROM dblink((select * from conf.get_pg_conf('GISA')), 'SELECT 
			id_ruolo, descrizione_ruolo from dbi_get_ruoli_utente()') 
t1(id integer, ruolo text)
) g on r.id_ruolo_gisa = g.id
left join (
select * 
   FROM dblink((select * from conf.get_pg_conf('BDU')), 'SELECT 
			id_ruolo, descrizione_ruolo from dbi_get_ruoli_utente()') 
t1(id integer, ruolo text)
) b on r.id_ruolo_bdu = b.id
left join (
select * 
   FROM dblink((select * from conf.get_pg_conf('VAM')), 'SELECT 
			id_ruolo, descrizione_ruolo from dbi_get_ruoli_utente()') 
t1(id integer, ruolo text)
) v on r.id_ruolo_vam = v.id 
--left join (
--select * 
--   FROM dblink((select * from conf.get_pg_conf('VAM')), 'SELECT 
--			id_clinica, nome_clinica from dbi_get_cliniche_utente()') 
--t1(id_clinica integer, nome_clinica text)
--) cli on cli.id_clinica::text = r.id_clinica_vam
left join (
select * 
   FROM dblink((select * from conf.get_pg_conf('GISA')), 'SELECT 
			id_ruolo, descrizione_ruolo from dbi_get_ruoli_utente_ext()') 
t1(id integer, ruolo text)
) ge on r.id_ruolo_gisa_ext = ge.id 
left join (
select * 
   FROM dblink((select * from conf.get_pg_conf('DIGEMON'))::text, 'SELECT 
			id_ruolo, descrizione_ruolo from dbi_get_ruoli_utente()') 
t1(id integer, ruolo text)
) dg on r.id_ruolo_digemon = dg.id 
--left join (
--select * 
--   FROM dblink('host=dbGESDASICL dbname=gesdasic'::text, 'SELECT 
--			id_ruolo, descrizione_ruolo from dbi_get_ruoli_utente()') 
--t1(id integer, ruolo text)
--) ges on r.id_ruolo_sicurezza_lavoro = ges.id 
where 1=1 
and (_numero_richiesta is null or r.numero_richiesta = _numero_richiesta)
order by r.data_richiesta desc, r.numero_richiesta;

END;
$$;

---------------------------

create or replace function spid.insert_ruolo_utente_guc(_id_utente integer, _id_ruolo integer, _endpoint text) RETURNS text
    LANGUAGE plpgsql
    AS $$

  DECLARE 

	conta integer;	
	esito text;
	descrizione_errore text;
	descrizione_ruolo text;
  BEGIN
	descrizione_errore='';
	esito='';


	if (_endpoint ilike 'gisa') THEN
	descrizione_ruolo = (select ruolo FROM dblink((select * from conf.get_pg_conf('GISA')), 'SELECT id_ruolo, descrizione_ruolo from dbi_get_ruoli_utente()') t1(id integer, 				ruolo text) where id = _id_ruolo);
	END IF;
	if (_endpoint ilike 'gisa_ext') THEN
	descrizione_ruolo = (select ruolo FROM dblink((select * from conf.get_pg_conf('GISA')), 'SELECT id_ruolo, descrizione_ruolo from dbi_get_ruoli_utente_ext()') t1(id integer, 				ruolo text) where id = _id_ruolo);
	END IF;
		if (_endpoint ilike 'bdu') THEN
	descrizione_ruolo = (select ruolo FROM dblink((select * from conf.get_pg_conf('BDU')), 'SELECT id_ruolo, descrizione_ruolo from dbi_get_ruoli_utente()') t1(id integer, 				ruolo text) where id = _id_ruolo);
	END IF;
	if (_endpoint ilike 'vam') THEN
	descrizione_ruolo = (select ruolo FROM dblink((select * from conf.get_pg_conf('VAM')), 'SELECT id_ruolo, descrizione_ruolo from dbi_get_ruoli_utente()') t1(id integer, 				ruolo text) where id = _id_ruolo);
	END IF;
	if (_endpoint ilike 'digemon') THEN
	descrizione_ruolo = (select ruolo FROM dblink((select * from conf.get_pg_conf('DIGEMON')), 'SELECT id_ruolo, descrizione_ruolo from dbi_get_ruoli_utente()') t1(id integer, 				ruolo text) where id = _id_ruolo);
	END IF;

	raise info '[insert_ruolo_utente_guc] id_ruolo %', _id_ruolo;
	raise info '[insert_ruolo_utente_guc] id_utente %', _id_utente;
	raise info '[insert_ruolo_utente_guc] descrizione_ruolo %', descrizione_ruolo;
	raise info '[insert_ruolo_utente_guc] _endpoint %', _endpoint;
	
	conta := (select count(*) from guc_utenti_ u 
		  join guc_ruoli r on u.id = r.id_utente
		  where u.enabled and u.cessato <> true and u.data_scadenza is null and 
		  u.id = _id_utente and r.trashed is not true 
		  and r.endpoint ilike _endpoint and r.ruolo_integer = _id_ruolo);
	
	if(conta > 0) then
		esito = 'KO';
		descrizione_errore = 'Esiste gia''  un utente per questo codice fiscale e ruolo';
	else
	insert into guc_ruoli (id_utente, ruolo_integer, ruolo_string, endpoint) values (_id_utente, _id_ruolo, descrizione_ruolo, (select endpoint from guc_ruoli where endpoint ilike _endpoint limit 1));
		esito = 'OK';
	end if;
	
	return '{"Esito" : "'||esito||'", "DescrizioneErrore" : "'||descrizione_errore ||'"}';

  END;
$$;

-------------------------------

create or replace function spid.processa_richiesta_elimina(_numero_richiesta text, _id_utente integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
	esito integer;

	esito_processa text;

	query_endpoint text;
	query text;

	output_gisa text;
	output_gisa_ext text;
	output_bdu text;
	output_vam text;
	output_digemon text;
	output_sicurezza_lavoro text;
	output_guc text;
	_codice_fiscale text;
	output_guc_gisa_ext text;
	output_guc_bdu text;
	output_guc_vam text;
	output_guc_digemon text;
	output_guc_sicurezza_lavoro text;
	output_guc_gisa text;

	output_disattiva text;
	_id_guc_ruoli integer;
	_endpoint_guc_ruoli text;
	_id_utente_guc_ruoli integer;
	_id_ruolo_guc_ruoli integer;

	username_out text;
BEGIN
	output_gisa = '{}';
	output_gisa_ext = '{}';
	output_bdu = '{}' ;
	output_vam = '{}';
	output_digemon = '{}';
	output_sicurezza_lavoro = '{}';
	output_guc = '{}';
	-- elimino utente prima in guc e poi nell'EP.
	_id_guc_ruoli := (select id_guc_ruoli from spid.get_lista_richieste(_numero_richiesta));
	_endpoint_guc_ruoli := (select endpoint_guc_ruoli from spid.get_lista_richieste(_numero_richiesta));
	_id_utente_guc_ruoli := (select id_utente from guc_ruoli where id = _id_guc_ruoli);
	_id_ruolo_guc_ruoli := (select ruolo_integer from guc_ruoli where id = _id_guc_ruoli);
	username_out := (select username from guc_utenti where id = _id_utente_guc_ruoli);
	
	_codice_fiscale := (select codice_fiscale from spid.get_lista_richieste(_numero_richiesta));
	/*ep_gisa := (select coalesce(id_ruolo_gisa,-1) from spid.get_lista_richieste(_numero_richiesta));
	ep_gisa_ext := (select coalesce(id_ruolo_gisa_ext,-1) from spid.get_lista_richieste(_numero_richiesta));
	ep_bdu := (select coalesce(id_ruolo_bdu,-1) from spid.get_lista_richieste(_numero_richiesta));
	ep_vam := (select coalesce(id_ruolo_vam, -1) from spid.get_lista_richieste(_numero_richiesta));
	ep_digemon := (select coalesce(id_ruolo_digemon,-1) from spid.get_lista_richieste(_numero_richiesta));

	_ruolo_gisa := (select coalesce(ruolo_gisa,'') from spid.get_lista_richieste(_numero_richiesta));
	_ruolo_gisa_ext := (select coalesce(ruolo_gisa_ext,'')from spid.get_lista_richieste(_numero_richiesta));
	_ruolo_bdu := (select coalesce(ruolo_bdu,'') from spid.get_lista_richieste(_numero_richiesta));
	_ruolo_vam := (select coalesce(ruolo_vam,'') from spid.get_lista_richieste(_numero_richiesta));
	_ruolo_digemon :=(select coalesce(ruolo_digemon,'') from spid.get_lista_richieste(_numero_richiesta));
*/

	if (_endpoint_guc_ruoli ilike 'gisa') then
		
		-- chiamo guc e gestisco l'output
			query  := 'select * from spid.elimina_ruolo_utente_guc('||_id_utente_guc_ruoli||','||_id_ruolo_guc_ruoli||',''Gisa'')';
			output_guc := (select * from spid.esegui_query(query , 'guc', _id_utente,''));
			output_gisa := COALESCE(output_guc, '');

			if (get_json_valore(output_guc, 'Esito') = 'OK') then
				query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'gisa', 'elimina', _id_utente, username_out, '', now()::timestamp without time zone - interval '1 DAY',_id_ruolo_guc_ruoli, -1));
				output_gisa := (select * from spid.esegui_query(query_endpoint, 'gisa', _id_utente,(select * from conf.get_pg_conf('GISA'))));
			end if;	
		  end if; -- fine ep_gisa

	if (_endpoint_guc_ruoli ilike 'gisa_ext') then
		
		-- chiamo guc e gestisco l'output
			query  := 'select * from spid.elimina_ruolo_utente_guc('||_id_utente_guc_ruoli||','||_id_ruolo_guc_ruoli||',''Gisa_ext'')';
			output_guc := (select * from spid.esegui_query(query , 'guc', _id_utente,''));
			output_gisa_ext := COALESCE(output_guc, '');

			if (get_json_valore(output_guc, 'Esito') = 'OK') then
				query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'gisa_ext', 'elimina', _id_utente, username_out, '', (now()::timestamp without time zone - interval '1 DAY'),_id_ruolo_guc_ruoli, -1));
				output_gisa_ext := (select * from spid.esegui_query(query_endpoint, 'gisa_ext', _id_utente,(select * from conf.get_pg_conf('GISA'))));
			end if;	
		end if; -- fine ep_gisa_ext
        
	if (_endpoint_guc_ruoli ilike 'bdu') then
		
			query  := 'select * from spid.elimina_ruolo_utente_guc('||_id_utente_guc_ruoli||','||_id_ruolo_guc_ruoli||',''bdu'')';
			output_guc := (select * from spid.esegui_query(query , 'guc', _id_utente,''));
			output_bdu := COALESCE(output_guc, '');
			if (get_json_valore(output_guc, 'Esito') = 'OK') then
				query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'bdu', 'elimina', _id_utente, username_out, '', (now()::timestamp without time zone - interval '1 DAY'),_id_ruolo_guc_ruoli, -1));
				output_bdu := (select * from spid.esegui_query(query_endpoint, 'bdu', _id_utente,(select * from conf.get_pg_conf('BDU'))));
				
			end if;	
		end if; -- fine ep_bdu
        
	if (_endpoint_guc_ruoli ilike 'vam') then
		
		-- chiamo guc e gestisco l'output
			query  := 'select * from spid.elimina_ruolo_utente_guc('||_id_utente_guc_ruoli||','||_id_ruolo_guc_ruoli||',''vam'')';
			output_guc := (select * from spid.esegui_query(query , 'guc', _id_utente,''));
			output_vam := COALESCE(output_guc, '');

			if (get_json_valore(output_guc, 'Esito') = 'OK') then
				query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'vam', 'elimina', _id_utente, username_out, '', (now()::timestamp without time zone - interval '1 DAY'),_id_ruolo_guc_ruoli, -1));
				output_vam := (select * from spid.esegui_query(query_endpoint, 'vam', _id_utente,(select * from conf.get_pg_conf('VAM'))));
			end if;	
		  end if; -- fine ep_vam

	if (_endpoint_guc_ruoli ilike 'digemon') then
		
			query  := 'select * from spid.elimina_ruolo_utente_guc('||_id_utente_guc_ruoli||','||_id_ruolo_guc_ruoli||',''digemon'')';
			output_guc := (select * from spid.esegui_query(query , 'guc', _id_utente,''));
			output_digemon := COALESCE(output_guc, '');

			if (get_json_valore(output_guc, 'Esito') = 'OK') then
				query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'digemon', 'elimina', _id_utente, username_out, '', (now()::timestamp without time zone - interval '1 DAY'),_id_ruolo_guc_ruoli, -1));
				output_digemon := (select * from spid.esegui_query(query_endpoint, 'digemon', _id_utente,(select * from conf.get_pg_conf('DIGEMON'))));
			end if;	
		 end if; -- fine ep_digemon

		 if (_endpoint_guc_ruoli ilike 'sicurezzalavoro') then
		
			query  := 'select * from spid.elimina_ruolo_utente_guc('||_id_utente_guc_ruoli||','||_id_ruolo_guc_ruoli||',''sicurezzalavoro'')';
			output_guc := (select * from spid.esegui_query(query , 'guc', _id_utente,''));
			output_sicurezza_lavoro := COALESCE(output_guc, '');

			if (get_json_valore(output_guc, 'Esito') = 'OK') then
				query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'sicurezzalavoro', 'elimina', _id_utente, username_out, '', (now()::timestamp without time zone - interval '1 DAY'),_id_ruolo_guc_ruoli, -1));
				output_sicurezza_lavoro := (select * from spid.esegui_query(query_endpoint, 'sicurezzalavoro', _id_utente,(select * from conf.get_pg_conf('SICLAV'))));
			end if;	
		 end if; -- fine ep_sicurezza_lavoro
       
	esito_processa = '{"EndPoint" : "GUC", "Risultato": '||output_guc||', "CodiceFiscale": "'||_codice_fiscale||'","ListaEndPoint" : [
					{"EndPoint" : "GISA", "Risultato" : ['||output_gisa||']},
					{"EndPoint" : "GISA_EXT", "Risultato" : ['||output_gisa_ext||']},
					{"EndPoint" : "BDR", "Risultato" : ['||output_bdu||']},
					{"EndPoint" : "VAM", "Risultato" : ['||output_vam||']},
					{"EndPoint" : "DIGEMON", "Risultato" : ['||output_digemon||']},
					{"EndPoint" : "SICUREZZA LAVORO", "Risultato" : ['||output_sicurezza_lavoro||']}]}';	
				   
	raise info '[STAMPA ESITO PROCESSA] %', esito_processa;

	IF get_json_valore(output_gisa, 'Esito')='OK' THEN
		esito = 1;
	END IF;
	IF get_json_valore(output_gisa_ext, 'Esito')='OK' THEN
		esito = 1;
	END IF;
	IF get_json_valore(output_bdu, 'Esito')='OK' THEN
		esito = 1;
	END IF;
	IF get_json_valore(output_vam, 'Esito')='OK' THEN
		esito = 1;
	END IF;
	IF get_json_valore(output_digemon, 'Esito')='OK' THEN
		esito = 1;
	END IF;
	IF get_json_valore(output_sicurezza_lavoro, 'Esito')='OK' THEN
		esito = 1;
	END IF;

	output_disattiva := (select * from public.disattiva_utente(_id_utente_guc_ruoli));

	UPDATE spid.spid_registrazioni_esiti set trashed_date = now() where numero_richiesta = _numero_richiesta and trashed_date is null;
	insert into spid.spid_registrazioni_esiti(numero_richiesta, esito_guc, esito_gisa, esito_gisa_ext, esito_bdu, esito_vam, esito_digemon,esito_sicurezza_lavoro, id_utente_esito, stato, json_esito) 
	values (_numero_richiesta,true,(case when get_json_valore(output_gisa, 'Esito')='OK' then true when get_json_valore(output_gisa, 'Esito')='KO' then false else null end),
			       (case when get_json_valore(output_gisa_ext, 'Esito')='OK' then true when get_json_valore(output_gisa_ext, 'Esito')='KO' then false else null end),
			       (case when get_json_valore(output_bdu, 'Esito')='OK' then true when get_json_valore(output_bdu, 'Esito')='KO' then false else null end),
			       (case when get_json_valore(output_vam, 'Esito')='OK' then true when get_json_valore(output_vam, 'Esito')='KO' then false else null end),
			       (case when get_json_valore(output_digemon, 'Esito')='OK' then true when get_json_valore(output_digemon, 'Esito')='KO' then false else null end),
			       (case when get_json_valore(output_sicurezza_lavoro, 'Esito')='OK' then true when get_json_valore(output_sicurezza_lavoro, 'Esito')='KO' then false else null end),
					       _id_utente, (case when esito = 1 then 1 end)
						,esito_processa);					
		   
	return esito_processa;
	
END
$$;

----------------------------------

create or replace function spid.processa_richiesta_insert(_numero_richiesta text, _id_utente integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $$

DECLARE
	--r RECORD;
	giava integer;
	ep_guc text;
	ep_gisa integer;
	ep_gisa_ext integer;
	ep_bdu integer;
	ep_vam integer;
	ep_digemon integer;
	ep_sicurezza_lavoro integer;
	_id_tipo_richiesta integer;
	username_out text;
	password_out text;
	output_gisa text;
	output_gisa_ext text;
	output_bdu text;
	output_vam text;
	output_digemon text;
	output_sicurezza_lavoro text;
	esito_processa text;
	check_gisa text;
	check_vam text;
	check_bdu text;
	check_digemon text;
	check_gisa_ext text;
	check_sicurezza_lavoro text;
	query text;
	query_endpoint text;
	esito_api text;
	esito_dist text;
	esito_acque text;
	esito_guc text;

	indice integer;
BEGIN
	giava := -1;
	username_out := '';
	output_gisa = '';
	output_gisa_ext = '';
	output_bdu = '' ;
	output_vam = '';
	output_digemon = '';
	output_sicurezza_lavoro = '';
	ep_gisa = -1;
	ep_gisa_ext = -1;
	ep_bdu = -1;
	ep_vam = -1;
	ep_digemon = -1;
	ep_sicurezza_lavoro = -1;
	
	check_gisa := '';
	check_gisa_ext := '';
	check_bdu := '';
	check_vam := '';
	check_digemon := '';
	check_sicurezza_lavoro := '';

	ep_gisa := (select coalesce(id_ruolo_gisa,-1) from spid.get_lista_richieste(_numero_richiesta));
	ep_gisa_ext := (select coalesce(id_ruolo_gisa_ext,-1) from spid.get_lista_richieste(_numero_richiesta));
	ep_bdu := (select coalesce(id_ruolo_bdu,-1) from spid.get_lista_richieste(_numero_richiesta));
	ep_vam := (select coalesce(id_ruolo_vam, -1) from spid.get_lista_richieste(_numero_richiesta));
	ep_digemon := (select coalesce(id_ruolo_digemon,-1) from spid.get_lista_richieste(_numero_richiesta));
	ep_sicurezza_lavoro := (select coalesce(id_ruolo_sicurezza_lavoro,-1) from spid.get_lista_richieste(_numero_richiesta));

	_id_tipo_richiesta := (select id_tipo_richiesta from spid.spid_registrazioni  where numero_richiesta = _numero_richiesta);
	--codicefiscale := (select codice_fiscale from spid.spid_registrazioni where numero_richiesta = _numero_richiesta);
	

	-- chiamo dbi dei check
	if(ep_gisa > 0) then
		query := 'select * from spid.check_vincoli_ruoli_by_endpoint('''||_numero_richiesta||''', '||ep_gisa||', ''gisa'');';
		check_gisa := (select * from spid.esegui_query(query, 'guc', _id_utente,''));
	end if;

	if(ep_gisa_ext > 0) then
		query := 'select * from spid.check_vincoli_ruoli_by_endpoint('''||_numero_richiesta||''', '||ep_gisa_ext||', ''gisa_ext'');';
		check_gisa_ext := (select * from spid.esegui_query(query, 'guc', _id_utente,''));
	end if;

	if(ep_bdu > 0) then
		query := 'select * from spid.check_vincoli_ruoli_by_endpoint('''||_numero_richiesta||''', '||ep_bdu||', ''bdu'');';
		check_bdu := (select * from spid.esegui_query(query, 'guc', _id_utente,''));
	end if;
	
	if(ep_vam > 0) then
		query := 'select * from spid.check_vincoli_ruoli_by_endpoint('''||_numero_richiesta||''', '||ep_vam||', ''vam'');';
		check_vam := (select * from spid.esegui_query(query, 'guc', _id_utente,''));
	end if;

	if(ep_digemon> 0) then
		query := 'select * from spid.check_vincoli_ruoli_by_endpoint('''||_numero_richiesta||''', '||ep_digemon||', ''digemon'');';
		check_digemon := (select * from spid.esegui_query(query, 'guc', _id_utente,''));
	end if;

	if(ep_sicurezza_lavoro> 0) then
		query := 'select * from spid.check_vincoli_ruoli_by_endpoint('''||_numero_richiesta||''', '||ep_digemon||', ''sicurezzalavoro'');';
		check_sicurezza_lavoro := (select * from spid.esegui_query(query, 'sicurezzalavoro', _id_utente,''));
	end if;
	
	
	IF length(check_gisa)>0 THEN
	ep_guc := 'KO;;KO';
	output_gisa := '{"Esito":"KO", "DescrizioneErrore":"'||check_gisa||'"}';
	END IF;
	IF length(check_gisa_ext)>0 THEN
		IF check_gisa_ext not like '%esiste%un account con questo ruolo%' THEN
			ep_guc := 'KO;;KO'; -- commentare per ignorare i ko su gisa ext flusso 315 -- aggiunto check su errore per bloccare quando il ko è vero
		END IF;
	output_gisa_ext := '{"Esito":"KO", "DescrizioneErrore":"'||check_gisa_ext||'"}';
	END IF;
	IF length(check_bdu)>0 THEN
	ep_guc := 'KO;;KO';
	output_bdu := '{"Esito":"KO", "DescrizioneErrore":"'||check_bdu||'"}';
	END IF;
	IF length(check_vam)>0 THEN
	ep_guc := 'KO;;KO';
	output_vam := '{"Esito":"KO", "DescrizioneErrore":"'||check_vam||'"}';
	END IF;
	IF length(check_digemon)>0 THEN
	--ep_guc := 'KO;;KO'; -- per ignorare i ko digemon
	output_digemon := '{"Esito":"KO", "DescrizioneErrore":"'||check_digemon||'"}';
	END IF;
	IF length(check_sicurezza_lavoro)>0 THEN
	ep_guc := 'KO;;KO';
	output_sicurezza_lavoro := '{"Esito":"KO", "DescrizioneErrore":"'||check_sicurezza_lavoro||'"}';
	END IF;
	
	if (length(check_gisa)=0  and length(check_bdu) = 0 and length(check_vam) = 0 --and length(check_digemon) = 0 IGNORO I KO SU DIGEMON E VADO AVANTI COMUNQUE
									              and length(check_gisa_ext) = 0 --IGNORO I KO SU gisa ext E VADO AVANTI COMUNQUE(commento eliminato)
	 and length(check_sicurezza_lavoro) = 0) then 
	
		if (_id_tipo_richiesta = 1) then -- inserimento utente
			query := (select * from spid.get_dbi_per_endpoint(_numero_richiesta,'guc','insert',_id_utente,null,null,null::timestamp without time zone,-1, -1)); 
			ep_guc:= (select * from spid.esegui_query(query, 'guc', _id_utente,''));
		end if;

		username_out := (select split_part(ep_guc,';;','3'));
		raise info ' username %', username_out;
		password_out := (select split_part(ep_guc,';;','4'));
		raise info ' password %', password_out;
		esito_guc := (select split_part(ep_guc,';;','1'));
		raise info ' esito insert guc %', esito_guc;

		if (ep_gisa > 0 and esito_guc = 'OK' and length(check_gisa)=0) then
			query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'gisa', 'insert', _id_utente, username_out, password_out, null::timestamp without time zone,-1, -1));
			output_gisa := (select * from spid.esegui_query(query_endpoint, 'gisa', _id_utente,(select * from conf.get_pg_conf('GISA'))));
			output_gisa := '{"Esito" : "'||output_gisa ||'"}';
			query := (select concat(
			concat('select * from dbi_insert_utente_extended_opt(',
			'''', (select id from guc_utenti where username = username_out), '''', ', ',
			'''', (select COALESCE((select coalesce(in_nucleo::text, 'false') from spid.spid_registrazioni_flag where trashed_date is null and numero_richiesta = _numero_richiesta), 'false')), '''', ', ',
			'''', 'true', '''', ', ',
			'''', (select COALESCE((select coalesce(in_dpat::text, 'false') from spid.spid_registrazioni_flag where trashed_date is null and numero_richiesta = _numero_richiesta), 'false')), '''', ', ',
			'''', 'false', '''', ', ',
			'''', 'false', 
			'''', '); ')) );
			query := (select * from spid.esegui_query(query, 'guc', _id_utente,''));
		end if;

		if (ep_gisa_ext > 0 and esito_guc = 'OK' and length(check_gisa_ext)=0) then
			query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'gisa_ext', 'insert', _id_utente, username_out, password_out, null::timestamp without time zone,-1, -1));
			output_gisa_ext := (select * from spid.esegui_query(query_endpoint, 'gisa', _id_utente,(select * from conf.get_pg_conf('GISA'))));
			output_gisa_ext := '{"Esito" : "'||output_gisa_ext ||'"}';
			giava := (select id_ruolo_gisa_ext from spid.spid_registrazioni s where s.numero_richiesta = _numero_richiesta);
			query :=(select concat(
			concat('select * from dbi_insert_utente_extended_opt(',
				'''', (select id from guc_utenti where username = username_out), '''', ', ',
				'''', 'false', '''', ', ',
				'''', 'false', '''', ', ',
				'''', 'false', '''', ', ',
				'''', (select COALESCE((select coalesce(in_nucleo::text, 'false') from spid.spid_registrazioni_flag where trashed_date is null and numero_richiesta = _numero_richiesta), 'false')), '''', ', ',
				'''', (case when giava =10000008 then 'false' else 'true' end), 
				'''', '); ')) );
			query := (select * from spid.esegui_query(query, 'guc', _id_utente,''));
		end if;
	    
		if (ep_bdu > 0 and esito_guc = 'OK' and length(check_bdu)=0) then
			query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'bdu', 'insert', _id_utente, username_out, password_out, null::timestamp without time zone,-1, -1));
			output_bdu := (select * from spid.esegui_query(query_endpoint, 'bdu', _id_utente,(select * from conf.get_pg_conf('BDU'))));
			output_bdu := '{"Esito" : "'||output_bdu ||'"}';
		end if;

		if (ep_vam > 0 and esito_guc = 'OK' and length(check_vam)=0) then

		indice := 0;
		WHILE indice < (select array_length (id_clinica_vam, 1) from spid.get_lista_richieste(_numero_richiesta)) LOOP

			query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'vam', 'insert', _id_utente, username_out, password_out, null::timestamp without time zone,-1, (indice+1)));
			output_vam := (select * from spid.esegui_query(query_endpoint, 'vam', _id_utente,(select * from conf.get_pg_conf('VAM'))));

				output_vam := '{"Esito" : "'||output_vam ||'"}';
			indice = indice+1;
		END LOOP;	
		end if;

		if (ep_digemon > 0 and esito_guc = 'OK' and length(check_digemon)=0) then
			query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'digemon', 'insert', _id_utente, username_out, password_out, null::timestamp without time zone,-1, -1));
			output_digemon := (select * from spid.esegui_query(query_endpoint, 'digemon', _id_utente,(select * from conf.get_pg_conf('DIGEMON'))));
			output_digemon := '{"Esito" : "'||output_digemon ||'"}';
		end if;

if (ep_sicurezza_lavoro > 0 and esito_guc = 'OK' and length(check_sicurezza_lavoro)=0) then
			query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'sicurezzalavoro', 'insert', _id_utente, username_out, password_out, null::timestamp without time zone,-1, -1));
			output_sicurezza_lavoro := (select * from spid.esegui_query(query_endpoint, 'sicurezzalavoro', _id_utente,(select * from conf.get_pg_conf('SICLAV'))));
			output_sicurezza_lavoro := '{"Esito" : "'||output_sicurezza_lavoro ||'"}';
		end if;		

		END IF;

		esito_processa = '{"EndPoint" : "GUC", "Esito": "'||(select split_part(ep_guc,';;','1'))||'", 
				   "Username" : "'||username_out||'", "ListaEndPoint" : [
					{"EndPoint" : "GISA", "Risultato" : ['||output_gisa||']},
					{"EndPoint" : "GISA_EXT", "Risultato" : ['||output_gisa_ext||']},
					{"EndPoint" : "BDR", "Risultato" : ['||output_bdu||']},
					{"EndPoint" : "VAM", "Risultato" : ['||output_vam||']},
					{"EndPoint" : "DIGEMON", "Risultato" : ['||output_digemon||']},
					{"EndPoint" : "SICUREZZA LAVORO", "Risultato" : ['||output_sicurezza_lavoro||']}
				   ]
				}';		

		RAISE INFO 'esito_processa= %', esito_processa;

		if(get_json_valore(output_gisa_ext, 'Esito')='OK') then
			-- gestione ruolo gestore acque
			if ep_gisa_ext = 10000006 then 
				query = (select concat('SELECT * from dbi_insert_log_user_reg(''', (select replace(coalesce(nome,''), '''', '') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', 
				(select replace(coalesce(cognome,''), '''', '') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', (select codice_fiscale from spid.get_lista_richieste(_numero_richiesta)), ''', ''', '', ''', ''', 
				(select email from spid.get_lista_richieste(_numero_richiesta)), ''', ''', (select coalesce(istat_comune,'') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', 
				(select coalesce(lower(provincia_ordine_vet),'') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', (select coalesce(cap,'') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', 
				(select replace(coalesce(indirizzo,''), '''', '') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', 
				(select telefono from spid.get_lista_richieste(_numero_richiesta)), ''', ''', (select ip from spid.spid_registrazioni where numero_richiesta = _numero_richiesta), ''',', 
				(select coalesce(id_gestore_acque,-1) from spid.get_lista_richieste(_numero_richiesta)), ', ''', '', ''', ', 'null::timestamp with time zone', ', ''', 
				(select piva_numregistrazione from spid.get_lista_richieste(_numero_richiesta)), 
				''', ''', (select user_agent from spid.spid_registrazioni where numero_richiesta = _numero_richiesta), ''', ''', 'ACQUE', ''')'));
				raise info 'stampa query insert gisa_ext acque%', query;
				query := (select * from spid.esegui_query(query, 'gisa', _id_utente,(select * from conf.get_pg_conf('GISA'))));
				raise info 'output query gisa_ext per insert acque: %', query;
			end if;
			-- gestione ruolo apicoltore autoconsumo/commercio
			if ep_gisa_ext = 10000002 then 
				raise info 'inserisco una richiesta per apicoltura';
				query = (select concat('SELECT * from dbi_insert_log_user_reg(''', (select replace(coalesce(nome,''), '''', '') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', (select replace(coalesce(cognome,''), '''', '') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', (select codice_fiscale from spid.get_lista_richieste(_numero_richiesta)), ''', ''', '', ''', ''', (select email from spid.get_lista_richieste(_numero_richiesta)), ''', ''', (select coalesce(istat_comune,'') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', 
				(select coalesce(lower(provincia_ordine_vet),'') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', 
				(select coalesce(cap,'') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', 
				(select replace(coalesce(indirizzo,''), '''', '') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', 
				(select telefono from spid.get_lista_richieste(_numero_richiesta)), ''', ''', (select ip from spid.spid_registrazioni where numero_richiesta = _numero_richiesta), ''',', -1, ', ''', '', ''', ', 'null::timestamp with time zone', ', ''', 
				(select piva_numregistrazione from spid.get_lista_richieste(_numero_richiesta)), ''', ''', (select user_agent from spid.spid_registrazioni where numero_richiesta = _numero_richiesta), ''', ''', 'API', ''')'));
				raise info 'stampa query insert gisa_ext api%', query;
				query := (select * from spid.esegui_query(query, 'gisa', _id_utente,(select * from conf.get_pg_conf('GISA'))));
				raise info 'output query gisa_ext per insert apicoltura: %', query;	
										
				raise info 'inserisco un soggetto fisico per apicoltura';
				query = (select concat('SELECT * from insert_soggetto_fisico_per_apicoltore(''', (select replace(coalesce(nome,''), '''', '') from spid.get_lista_richieste(_numero_richiesta)), '''::text, '''::text, (select replace(coalesce(cognome,''), '''', '') from spid.get_lista_richieste(_numero_richiesta)), '''::text, ''', (select codice_fiscale from spid.get_lista_richieste(_numero_richiesta)), '''::text, ''', '', '''::text, -1, ''', (select telefono from spid.get_lista_richieste(_numero_richiesta)), '''::text, ''', (select email from spid.get_lista_richieste(_numero_richiesta)), '''::text,  ''', '', '''::text, ''', (select cap from spid.get_lista_richieste(_numero_richiesta)), '''::text, ''', (select indirizzo from spid.get_lista_richieste(_numero_richiesta)), '''::text, ''', (select replace(coalesce(comune,''), '''', '') from spid.get_lista_richieste(_numero_richiesta)), '''::text, ''', (select istat_comune from spid.get_lista_richieste(_numero_richiesta)), '''::text)'));
				raise info 'stampa query insert gisa_ext api%', query;
				query := (select * from spid.esegui_query(query, 'gisa', _id_utente,(select * from conf.get_pg_conf('GISA'))));
				raise info 'output query gisa_ext per insert apicoltura: %', query;	
			end if;
			
			-- gestione ruolo dist e trasportatore
			if ep_gisa_ext = 10000004 then 
				query := (select concat('SELECT * from dbi_insert_log_user_reg(''', (select replace(coalesce(nome,''), '''', '') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', 
				(select replace(coalesce(cognome,''), '''', '') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', (select codice_fiscale from spid.get_lista_richieste(_numero_richiesta)), ''', ''', '', ''', ''', 
				(select email from spid.get_lista_richieste(_numero_richiesta)), ''', ''', (select coalesce(istat_comune,'') from spid.get_lista_richieste(_numero_richiesta)), ''', ''',
				 (select coalesce(lower(provincia_ordine_vet),'') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', (select coalesce(cap,'') from spid.get_lista_richieste(_numero_richiesta)), ''', ''',
				  (select replace(coalesce(indirizzo,''), '''', '') from spid.get_lista_richieste(_numero_richiesta)), ''', ''', (select telefono from spid.get_lista_richieste(_numero_richiesta)), ''', ''', 
				  (select ip from spid.spid_registrazioni where numero_richiesta = _numero_richiesta), ''',', -1, ', ''', '', ''', ', 'null::timestamp with time zone', ', ''', 
				  (select codice_gisa from spid.get_lista_richieste(_numero_richiesta)), ''', ''', (select user_agent from spid.spid_registrazioni where numero_richiesta = _numero_richiesta), ''', ''', (select case when id_tipologia_trasp_dist = 1 then 'TRASPORTATORE' when id_tipologia_trasp_dist = 2 then 'DISTRIBUTORE' else '' end from spid.get_lista_richieste(_numero_richiesta)), ''')'));
				raise info 'stampa query insert gisa_ext trasp/dist%', query;
				query := (select * from spid.esegui_query(query, 'gisa', _id_utente,(select * from conf.get_pg_conf('GISA'))));
				raise info 'output query gisa_ext per insert distributori: %', query;	
			end if;
		end if;

		if(get_json_valore(output_vam, 'Esito')='OK') then
		indice := 0;
		WHILE indice < (select array_length (id_clinica_vam, 1) from spid.get_lista_richieste(_numero_richiesta)) LOOP
		
				query = (select concat('insert into guc_cliniche_vam(id_clinica, descrizione_clinica, id_utente) values(', (select id_clinica_vam[indice+1] from spid.get_lista_richieste(_numero_richiesta)), ',''', (select replace(clinica_vam[indice+1], '''', '') from spid.get_lista_richieste(_numero_richiesta)), ''', ', (select split_part(ep_guc,';;','2')), ') returning ''OK'';'));
				raise info 'stampa query insert vam cliniche%', query;
				query := (select * from spid.esegui_query(query, 'guc', _id_utente,''));
				raise info 'output query insert vam cliniche: %', query;

				indice = indice+1;
		END LOOP;
			end if;
		
		-- update e insert richieste
UPDATE spid.spid_registrazioni_esiti set trashed_date = now() where numero_richiesta = _numero_richiesta and trashed_date is null;
insert into spid.spid_registrazioni_esiti(numero_richiesta, esito_guc, esito_gisa, esito_gisa_ext, esito_bdu, esito_vam, esito_digemon, esito_sicurezza_lavoro, id_utente_esito, stato, json_esito) 
values (_numero_richiesta,true,(case when get_json_valore(output_gisa, 'Esito')='OK' then true when get_json_valore(output_gisa, 'Esito')='KO' then false else null end),
			       (case when get_json_valore(output_gisa_ext, 'Esito')='OK' then true when get_json_valore(output_gisa_ext, 'Esito')='KO' then false else null end),
			       (case when get_json_valore(output_bdu, 'Esito')='OK' then true when get_json_valore(output_bdu, 'Esito')='KO' then false else null end),
			       (case when get_json_valore(output_vam, 'Esito')='OK' then true when get_json_valore(output_vam, 'Esito')='KO' then false else null end),
			       (case when get_json_valore(output_digemon, 'Esito')='OK' then true when get_json_valore(output_digemon, 'Esito')='KO' then false else null end),
 (case when get_json_valore(output_sicurezza_lavoro, 'Esito')='OK' then true when get_json_valore(output_sicurezza_lavoro, 'Esito')='KO' then false else null end),			       
					       _id_utente, (case when (select split_part(ep_guc,';;','1')) = 'OK' then 1 end)
						,esito_processa);
						

     RETURN esito_processa;

 END;
$$;

---------------------------------

create or replace function spid.processa_richiesta_modifica(_numero_richiesta text, _idutente integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare

	esito integer;
	output_guc_gisa text;
	output_guc_gisa_ext text;
	output_guc_bdu text;
	output_guc_vam text;
	output_guc_digemon text;
	output_guc_sicurezza_lavoro text;
	username_out text;
	password_out text;
	
	ep_gisa integer;
	ep_gisa_ext integer;
	ep_bdu integer;
	ep_vam integer;
	ep_digemon integer;
	ep_sicurezza_lavoro integer;

	check_endpoint text;

	output_gisa text;
	output_gisa_ext text;
	output_bdu text;
	output_vam text;
	output_digemon text;
	output_sicurezza_lavoro text;
	query text;
	
	_codice_fiscale text;
	esito_processa text;
	query_endpoint text;
	output_guc text;

	indice integer;

	_id_guc_ruoli integer;
	_endpoint_guc_ruoli text;
	_id_utente_guc_ruoli integer;
	_id_ruolo_guc_ruoli integer;

BEGIN
	-- recupero CF e id_ruoli per ogni EP
	_id_guc_ruoli := (select id_guc_ruoli from spid.get_lista_richieste(_numero_richiesta));
	_endpoint_guc_ruoli := (select endpoint_guc_ruoli from spid.get_lista_richieste(_numero_richiesta));
	_id_utente_guc_ruoli := (select id_utente from guc_ruoli where id = _id_guc_ruoli);
	_id_ruolo_guc_ruoli := (select ruolo_integer from guc_ruoli where id = _id_guc_ruoli);
	username_out := (select username from guc_utenti where id = _id_utente_guc_ruoli);
	password_out := (select password from guc_utenti where id = _id_utente_guc_ruoli);

	_codice_fiscale := (select codice_fiscale from spid.get_lista_richieste(_numero_richiesta));
	ep_gisa := (select coalesce(id_ruolo_gisa,-1) from spid.get_lista_richieste(_numero_richiesta));
	ep_gisa_ext := (select coalesce(id_ruolo_gisa_ext,-1) from spid.get_lista_richieste(_numero_richiesta));
	ep_bdu := (select coalesce(id_ruolo_bdu,-1) from spid.get_lista_richieste(_numero_richiesta));
	ep_vam := (select coalesce(id_ruolo_vam, -1) from spid.get_lista_richieste(_numero_richiesta));
	ep_digemon := (select coalesce(id_ruolo_digemon,-1) from spid.get_lista_richieste(_numero_richiesta));
	
	-- new
	ep_sicurezza_lavoro := (select coalesce(id_ruolo_sicurezza_lavoro,-1) from spid.get_lista_richieste(_numero_richiesta));

	
	output_gisa='{}';
	output_gisa_ext='{}';
	output_bdu='{}';
	output_vam='{}';
	output_digemon='{}';
	output_guc ='{}';
	output_sicurezza_lavoro ='{}';
	
	if (ep_gisa > 0 and _endpoint_guc_ruoli ilike 'gisa') then
		
		
			query  := 'select * from spid.elimina_ruolo_utente_guc('||_id_utente_guc_ruoli||','||_id_ruolo_guc_ruoli||',''Gisa'')';
			output_guc_gisa := (select * from spid.esegui_query(query , 'guc', _idutente,''));
			output_gisa := COALESCE(output_guc_gisa, '');

			if (get_json_valore(output_guc_gisa, 'Esito') = 'OK') then
				query := 'select * from spid.insert_ruolo_utente_guc('||_id_utente_guc_ruoli||','||ep_gisa||',''Gisa'')';			
				output_guc_gisa := (select * from spid.esegui_query(query , 'guc', _idutente,''));
				if (get_json_valore(output_guc_gisa, 'Esito') = 'OK') then
					-- chiamo la dbi elimina utente
					query_endpoint :=( select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'gisa', 'elimina', _idutente, username_out, '', (now()::timestamp without time zone - interval '1 DAY'), _id_ruolo_guc_ruoli, -1));
					output_gisa := (select * from spid.esegui_query(query_endpoint, 'gisa', _idutente,(select * from conf.get_pg_conf('GISA'))));
					if (get_json_valore(output_gisa, 'Esito') = 'OK') then -- insert utente
						query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'gisa', 'insert', _idutente, username_out, password_out, null::timestamp without time zone, -1, -1));
						output_gisa := (select * from spid.esegui_query(query_endpoint, 'gisa', _idutente,(select * from conf.get_pg_conf('GISA'))));
						output_gisa := '{"Esito" : "'||output_gisa ||'"}';
					end if;
					--else
			--output_gisa := output_guc_gisa;
				end if;
			end if;	
	
	end if; -- fine ep_gisa

	if (ep_gisa_ext > 0 and _endpoint_guc_ruoli ilike 'gisa_ext') then
		
			query  := 'select * from spid.elimina_ruolo_utente_guc('||_id_utente_guc_ruoli||','||_id_ruolo_guc_ruoli||',''Gisa_ext'')';
			output_guc_gisa_ext := (select * from spid.esegui_query(query , 'guc', _idutente,''));
			output_gisa_ext := COALESCE(output_guc_gisa_ext, '');

			if (get_json_valore(output_guc_gisa_ext, 'Esito') = 'OK') then
				query := 'select * from spid.insert_ruolo_utente_guc('||_id_utente_guc_ruoli||','||ep_gisa_ext||',''Gisa_ext'')';			
				output_guc_gisa_ext := (select * from spid.esegui_query(query , 'guc', _idutente,''));
				if (get_json_valore(output_guc_gisa_ext, 'Esito') = 'OK') then
					-- chiamo la dbi elimina utente
					query_endpoint :=( select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'gisa_ext', 'elimina', _idutente, username_out, '', (now()::timestamp without time zone - interval '1 DAY'), _id_ruolo_guc_ruoli, -1));
					output_gisa_ext := (select * from spid.esegui_query(query_endpoint, 'gisa_ext', _idutente,(select * from conf.get_pg_conf('GISA'))));
					if (get_json_valore(output_gisa_ext, 'Esito') = 'OK') then -- insert utente
						query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'gisa_ext', 'insert', _idutente, username_out, password_out, null::timestamp without time zone, -1, -1));
						output_gisa_ext := (select * from spid.esegui_query(query_endpoint, 'gisa_ext', _idutente,(select * from conf.get_pg_conf('GISA'))));
						output_gisa_ext := '{"Esito" : "'||output_gisa_ext||'"}';
					end if;
					--else
			--output_gisa_ext := output_guc_gisa_ext;
				end if;
			end if;			        
			
	end if; -- fine ep_gisa_ext

	if (ep_bdu > 0 and _endpoint_guc_ruoli ilike 'bdu') then
		
			query  := 'select * from spid.elimina_ruolo_utente_guc('||_id_utente_guc_ruoli||','||_id_ruolo_guc_ruoli||',''bdu'')';
			output_guc_bdu := (select * from spid.esegui_query(query , 'guc', _idutente,''));
			output_bdu := COALESCE(output_guc_bdu, '');
			if (get_json_valore(output_guc_bdu, 'Esito') = 'OK') then
				query := 'select * from spid.insert_ruolo_utente_guc('||_id_utente_guc_ruoli||','||ep_bdu||',''bdu'')';			
				output_guc_bdu := (select * from spid.esegui_query(query , 'guc', _idutente,''));
				if (get_json_valore(output_guc_bdu, 'Esito') = 'OK') then
					-- chiamo la dbi elimina utente
					query_endpoint :=( select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'bdu', 'elimina', _idutente, username_out, '', (now()::timestamp without time zone - interval '1 DAY'), _id_ruolo_guc_ruoli, -1));
					output_bdu := (select * from spid.esegui_query(query_endpoint, 'bdu', _idutente,(select * from conf.get_pg_conf('BDU'))));
					if (get_json_valore(output_bdu, 'Esito') = 'OK') then -- insert utente
						query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'bdu', 'insert', _idutente, username_out, password_out, null::timestamp without time zone, -1, -1));
						output_bdu := (select * from spid.esegui_query(query_endpoint, 'bdu', _idutente,(select * from conf.get_pg_conf('BDU'))));
						output_bdu := '{"Esito" : "'||output_bdu||'"}';
					end if;
					--else
			--output_bdu := output_guc_bdu;
				end if;
			end if;		
		
	end if; -- fine ep_bdu
				  
	if (ep_vam > 0 and _endpoint_guc_ruoli ilike 'vam') then
		
			-- chiamo guc e gestisco l'output
			query  := 'select * from spid.elimina_ruolo_utente_guc('||_id_utente_guc_ruoli||','||_id_ruolo_guc_ruoli||',''vam'')';
			output_guc_vam := (select * from spid.esegui_query(query , 'guc', _idutente,''));
			output_vam := COALESCE(output_guc_vam, '');
			if (get_json_valore(output_guc_vam, 'Esito') = 'OK') then
				query := 'select * from spid.insert_ruolo_utente_guc('||_id_utente_guc_ruoli||','||ep_vam||',''vam'')';			
				output_guc_vam := (select * from spid.esegui_query(query , 'guc', _idutente,''));
				if (get_json_valore(output_guc_vam, 'Esito') = 'OK') then
					-- chiamo la dbi elimina utente
					query_endpoint :=( select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'vam', 'elimina', _idutente, username_out, '', (now()::timestamp without time zone - interval '1 DAY'), _id_ruolo_guc_ruoli, -1));
					output_vam := (select * from spid.esegui_query(query_endpoint, 'vam', _idutente,(select * from conf.get_pg_conf('VAM'))));
					if (get_json_valore(output_vam, 'Esito') = 'OK') then -- insert utente
					-- svuoto tutte le cliniche in GUC
					delete from guc_cliniche_vam where id_utente = _id_utente_guc_ruoli;
					indice := 0;
		WHILE indice < (select array_length (id_clinica_vam, 1) from spid.get_lista_richieste(_numero_richiesta)) LOOP
		
						query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'vam', 'insert', _idutente, username_out, password_out, null::timestamp without time zone, -1, (indice+1)));
						output_vam := (select * from spid.esegui_query(query_endpoint, 'vam', _idutente,(select * from conf.get_pg_conf('VAM'))));
						output_vam := '{"Esito" : "'||output_vam||'"}';

						-- aggiornamento cliniche vam
						query := (select concat('insert into guc_cliniche_vam(id_clinica, descrizione_clinica, id_utente) values(', 
						(select id_clinica_vam[indice+1] from spid.get_lista_richieste(_numero_richiesta)), ',''', 
						(select replace(clinica_vam[indice+1], '''', '') from spid.get_lista_richieste(_numero_richiesta)), ''', ', 
						(_id_utente_guc_ruoli), ') returning ''OK'';'));
						raise info 'stampa query insert vam cliniche%', query;
						query := (select * from spid.esegui_query(query, 'guc', _idutente,''));
						raise info 'output query insert vam cliniche: %', query;

						
						indice = indice+1;
		END LOOP;
					end if;
					--else
			--output_vam := output_guc_vam;
				end if;
			end if;		
		
	end if; -- fine ep_vam	  

	if (ep_digemon > 0 and _endpoint_guc_ruoli ilike 'digemon') then
		
			query  := 'select * from spid.elimina_ruolo_utente_guc('||_id_utente_guc_ruoli||','||_id_ruolo_guc_ruoli||',''digemon'')';
			output_guc_digemon := (select * from spid.esegui_query(query , 'guc', _idutente,''));
			output_digemon := COALESCE(output_guc_digemon, '');

			if (get_json_valore(output_guc_digemon, 'Esito') = 'OK') then
				query := 'select * from spid.insert_ruolo_utente_guc('||_id_utente_guc_ruoli||','||ep_digemon||',''digemon'')';			
				output_guc_digemon := (select * from spid.esegui_query(query , 'guc', _idutente,''));
				if (get_json_valore(output_guc_digemon, 'Esito') = 'OK') then
					-- chiamo la dbi elimina utente
					query_endpoint :=( select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'digemon', 'elimina', _idutente, username_out, '', (now()::timestamp without time zone - interval '1 DAY'), _id_ruolo_guc_ruoli, -1));
					output_digemon := (select * from spid.esegui_query(query_endpoint, 'digemon', _idutente,(select * from conf.get_pg_conf('DIGEMON'))));
					if (get_json_valore(output_digemon, 'Esito') = 'OK') then -- insert utente
						query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'digemon', 'insert', _idutente, username_out, password_out, null::timestamp without time zone, -1, -1));
						output_digemon := (select * from spid.esegui_query(query_endpoint, 'digemon', _idutente,(select * from conf.get_pg_conf('DIGEMON'))));
						output_digemon := '{"Esito" : "'||output_digemon||'"}';
					end if;
					--else
			--output_digemon := output_guc_digemon;
				end if;
			end if;	
		
	end if; -- fine ep_digemon
	

	if (ep_sicurezza_lavoro > 0 and _endpoint_guc_ruoli ilike 'sicurezzalavoro') then
		
			query  := 'select * from spid.elimina_ruolo_utente_guc('||_id_utente_guc_ruoli||','||_id_ruolo_guc_ruoli||',''sicurezzalavoro'')';
			output_guc_sicurezza_lavoro := (select * from spid.esegui_query(query , 'guc', _idutente,''));
			output_sicurezza_lavoro := COALESCE(output_guc_sicurezza_lavoro, '');

			if (get_json_valore(output_guc_sicurezza_lavoro, 'Esito') = 'OK') then
				query := 'select * from spid.insert_ruolo_utente_guc('||_id_utente_guc_ruoli||','||ep_sicurezza_lavoro||',''sicurezzalavoro'')';			
				output_guc_sicurezza_lavoro := (select * from spid.esegui_query(query , 'guc', _idutente,''));
				if (get_json_valore(output_guc_sicurezza_lavoro, 'Esito') = 'OK') then
					-- chiamo la dbi elimina utente
					query_endpoint :=( select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'sicurezzalavoro', 'elimina', _idutente, username_out, '', (now()::timestamp without time zone - interval '1 DAY'), _id_ruolo_guc_ruoli, -1));
					output_sicurezza_lavoro := (select * from spid.esegui_query(query_endpoint, 'sicurezzalavoro', _idutente,(select * from conf.get_pg_conf('SICLAV'))));
					if (get_json_valore(output_sicurezza_lavoro, 'Esito') = 'OK') then -- insert utente
						query_endpoint := (select * from spid.get_dbi_per_endpoint(_numero_richiesta, 'sicurezzalavoro', 'insert', _idutente, username_out, password_out, null::timestamp without time zone, -1, -1));
						output_sicurezza_lavoro := (select * from spid.esegui_query(query_endpoint, 'sicurezzalavoro', _idutente,(select * from conf.get_pg_conf('SICLAV'))));
						output_sicurezza_lavoro := '{"Esito" : "'||output_sicurezza_lavoro||'"}';
					end if;
				end if;
			end if;	
		
	end if; -- fine ep_sicurezza_lavoro

	esito_processa = '{"EndPoint" : "GUC", "Username" : "' || username_out || '", "CodiceFiscale": "'||_codice_fiscale||'","ListaEndPoint" : [
					{"EndPoint" : "GISA", "Risultato" : ['||output_gisa||']},
					{"EndPoint" : "GISA_EXT", "Risultato" : ['||output_gisa_ext||']},
					{"EndPoint" : "BDR", "Risultato" : ['||output_bdu||']},
					{"EndPoint" : "VAM", "Risultato" : ['||output_vam||']},
					{"EndPoint" : "DIGEMON", "Risultato" : ['||output_digemon||']},
					{"EndPoint" : "SICUREZZA LAVORO", "Risultato" : ['||output_sicurezza_lavoro||']}

			]}';
	raise info '[STAMPA ESITO PROCESSA] %', esito_processa;

	IF get_json_valore(output_gisa, 'Esito')='OK' THEN
		esito = 1;
	END IF;
	IF get_json_valore(output_gisa_ext, 'Esito')='OK' THEN
		esito = 1;
	END IF;
	IF get_json_valore(output_bdu, 'Esito')='OK' THEN
		esito = 1;
	END IF;
	IF get_json_valore(output_vam, 'Esito')='OK' THEN
		esito = 1;
	END IF;
	IF get_json_valore(output_digemon, 'Esito')='OK' THEN
		esito = 1;
	END IF;
	IF get_json_valore(output_sicurezza_lavoro, 'Esito')='OK' THEN
		esito = 1;
	END IF;
		
	-- update e insert richieste
	UPDATE spid.spid_registrazioni_esiti set trashed_date = now() where numero_richiesta = _numero_richiesta and trashed_date is null;
	insert into spid.spid_registrazioni_esiti(numero_richiesta, esito_guc, esito_gisa, esito_gisa_ext, esito_bdu, esito_vam, esito_digemon, esito_sicurezza_lavoro, id_utente_esito, stato, json_esito) 
	values (_numero_richiesta,true,(case when get_json_valore(output_gisa, 'Esito')='OK' then true when get_json_valore(output_gisa, 'Esito')='KO' then false else null end),
					       (case when get_json_valore(output_gisa_ext, 'Esito')='OK' then true when get_json_valore(output_gisa_ext, 'Esito')='KO' then false else null end),
					       (case when get_json_valore(output_bdu, 'Esito')='OK' then true when get_json_valore(output_bdu, 'Esito')='KO' then false else null end),
					       (case when get_json_valore(output_vam, 'Esito')='OK' then true when get_json_valore(output_vam, 'Esito')='KO' then false else null end),
					       (case when get_json_valore(output_digemon, 'Esito')='OK' then true when get_json_valore(output_digemon, 'Esito')='KO' then false else null end),
					       (case when get_json_valore(output_sicurezza_lavoro, 'Esito')='OK' then true when get_json_valore(output_sicurezza_lavoro, 'Esito')='KO' then false else null end),
					       _idutente, (case when esito = 1 then 1 end),esito_processa);
		

	return esito_processa;
	
END
$$;

--------------------------------------------

create or replace function spid.check_vincoli_ruoli_by_endpoint(_numero_richiesta text, _id_ruolo integer, _endpoint text) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
 _query text;
 _msg text;
 conta_guc integer;
 _id_tipologia_utente integer;
BEGIN

_query := '';
_msg := '';
conta_guc = 0;

RAISE INFO '[CHECK RUOLI BY ENDPOINT] _numero_richiesta: %', _numero_richiesta;
RAISE INFO '[CHECK RUOLI BY ENDPOINT] _id_ruolo: %', _id_ruolo;
RAISE INFO '[CHECK RUOLI BY ENDPOINT] _endpoint: %', _endpoint;

-- CHECK SU GUC PRELIMINARE
conta_guc := (select count(*) from spid.get_lista_ruoli_utente_guc((select codice_fiscale from spid.spid_registrazioni where numero_richiesta = _numero_richiesta), _endpoint, (select codice_gisa from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)) 
where id_ruolo = _id_ruolo);
    
if conta_guc > 0 then 
	_msg := 'Per il codice fiscale selezionato, esiste gia'' un account con questo ruolo.';
end if;

_id_tipologia_utente = (select id_tipologia_utente from spid.spid_registrazioni where numero_richiesta = _numero_richiesta);
RAISE INFO '[CHECK RUOLI BY ENDPOINT] Id tipologia utente recuperato da richiesta: %', _id_tipologia_utente;

-- gestore acque
IF _id_ruolo = 10000006 and _endpoint ilike 'GISA_EXT' THEN 
RAISE INFO '[CHECK RUOLI BY ENDPOINT] Avvio check per il ruolo GESTORE ACQUE';
-- Controlla se non c'ï¿½ un'altra richiesta con lo stesso gestore e lo stesso comune

SELECT 'SELECT * from check_vincoli_richieste(''''::text,'''||('ACQUE')||'''::text, '||(select id_gestore_acque from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'::integer, 
''' || (select comune from spid.spid_registrazioni where numero_richiesta = _numero_richiesta) || '''::text, ''''::text);' into _query;

_msg := (select * from spid.esegui_query(_query, 'gisa', -1,(select * from conf.get_pg_conf('GISA'))));

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito del check esistenza RICHIESTE: %', _msg;

-- Controlla se il comune esiste in banca dati
-- Non faccio nulla. Il comune ï¿½ giï¿½ mappato come istat.

END IF;

--apicoltore
IF _id_ruolo = 10000002 and _endpoint ilike 'GISA_EXT' THEN
RAISE INFO '[CHECK RUOLI BY ENDPOINT] Avvio check per il ruolo API';
-- Controlla se non c'ï¿½ un'altra richiesta con lo stesso codice fiscale

SELECT 'SELECT * from check_vincoli_richieste('''||(select codice_fiscale from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text,'''||('API')||'''::text, -1, ''''::text,
'''||(select piva_numregistrazione from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text);' into _query;

_msg := (select * from spid.esegui_query(_query, 'gisa', -1,(select * from conf.get_pg_conf('GISA'))));

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito del check esistenza RICHIESTE: %', _msg;

IF (_msg = '' and _id_tipologia_utente = 5) THEN 
SELECT 'SELECT * from check_vincoli_utente_api('''||(select piva_numregistrazione from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text);' into _query;

_msg := (select * from spid.esegui_query(_query, 'gisa', -1,(select * from conf.get_pg_conf('GISA'))));

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito del check per APICOLTORE COMMERCIALE: %', _msg;


END IF;
-- Controlla se il comune esiste in banca dati
-- Non faccio nulla. Il comune ï¿½ giï¿½ mappato come istat.

END IF;

--trasportatore/distributore
IF _id_ruolo = 10000004 and _endpoint ilike 'GISA_EXT' THEN
RAISE INFO '[CHECK RUOLI BY ENDPOINT] Avvio check per il ruolo TRASPORTATORE/DISTRIBUTORE';
-- Controlla se il CF ï¿½ valido
-- Non faccio nulla. Lo fa giï¿½ il modulo e se non lo fa lo deve fare lui e non una dbi

-- Controlla se il comune esiste in banca dati
-- Non faccio nulla. Il comune ï¿½ giï¿½ mappato come istat.

-- Controlla se esiste una richiesta con lo stesso codice fiscale e tipologia (trasporto/distr)
SELECT 'SELECT * from check_vincoli_richieste('''||(select codice_fiscale from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text,
'''||(select CASE WHEN id_tipologia_trasp_dist = 1 then 'TRASPORTATORE' WHEN id_tipologia_trasp_dist = 2 then 'DISTRIBUTORE' end from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text, -1, 
''''::text, '''||(select codice_gisa from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text);' into _query;
_msg := (select * from spid.esegui_query(_query, 'gisa', -1,(select * from conf.get_pg_conf('GISA'))));

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito del check esistenza RICHIESTE: %', _msg;

IF (_msg = '') THEN 

SELECT 'SELECT * from check_vincoli_utente_trasp_dist('''||(select codice_gisa from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text,
'''||(select id_tipologia_trasp_dist from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::integer,
'''||(select comune from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text);' into _query;

_msg := (select * from spid.esegui_query(_query, 'gisa', -1,(select * from conf.get_pg_conf('GISA'))));

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito del check VINCOLI: %', _msg;

END IF;

END IF;


--veterinario respnsabile centro seme o recapito 10000010
IF (_id_ruolo = 10000010 or _id_ruolo = 10000011) and _endpoint ilike 'GISA_EXT' THEN
RAISE INFO '[CHECK RUOLI BY ENDPOINT] Avvio check per il ruolo VETERINARIO RESPONSABILE CENTRO RIPRODUZIONE O RECAPITI';
-- Controlla se il CF ï¿½ valido
-- Non faccio nulla. Lo fa giï¿½ il modulo e se non lo fa lo deve fare lui e non una dbi

-- Controlla se il comune esiste in banca dati
-- Non faccio nulla. Il comune ï¿½ giï¿½ mappato come istat.

-- Controlla se esiste una richiesta con lo stesso codice fiscale?? 
SELECT 'SELECT * from check_vincoli_richieste('''||(select codice_fiscale from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text,'''||('VET_RESP_SEME_RECAPITO')||'''::text, -1, ''''::text,
'''||(select piva_numregistrazione from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text);' into _query;

_msg := (select * from spid.esegui_query(_query, 'gisa', -1,(select * from conf.get_pg_conf('GISA'))));

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito del check esistenza RICHIESTE: %', _msg;

IF (_msg = '') THEN 

SELECT 'SELECT * from check_vincoli_utente_vet_resp_centri_e_recapiti('''||(select codice_gisa from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text);' into _query;

_msg := (select * from spid.esegui_query(_query, 'gisa', -1,(select * from conf.get_pg_conf('GISA'))));

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito del check VINCOLI: %', _msg;

END IF;

END IF;

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito finale (Vuoto=OK): %', _msg;

return _msg;
END
$$;