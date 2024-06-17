update lookup_oggetto_audit set description = replace(description,'Stomachi','Stomaci');

DROP FUNCTION get_strutture_da_controllare_ac(integer,integer) ;

-- FUNCTION: public.get_strutture_da_controllare_ac(integer, integer)

-- DROP FUNCTION IF EXISTS public.get_strutture_da_controllare_ac(integer, integer);


CREATE OR REPLACE FUNCTION public.get_strutture_da_controllare_ac(
	_id_asl integer DEFAULT '-1'::integer,
	_anno integer DEFAULT NULL::integer)
    RETURNS TABLE(id_asl integer, descrizione_tipologia_struttura text, descrizione_struttura text, descrizione_padre text, id integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
	r RECORD;
BEGIN
	
	if _id_asl = 14 then 
		_id_asl= -1;
	end if;
	
return query 
SELECT 
	strutture.id_asl as id_asl_struttura,
   tipooia.description::text as tipologia_struttura_complessa,
	strutture.descrizione::text ,
     strutture.descrizione_padre::text,
	 strutture.id
FROM dpat_strutture_asl strutture                               
LEFT JOIN lookup_tipologia_nodo_oia tipooia ON strutture.tipologia_struttura = tipooia.code 
where data_scadenza is null and
      (strutture.id_asl = _id_asl or _id_asl =-1) and
      id_strumento_calcolo in (select dsc.id 
			                          from dpat_strumento_calcolo dsc
			                          where (dsc.id_asl = _id_asl or _id_asl = -1) and 
			                                (dsc.anno = _anno or _anno is null) 
			                          ) 
order by strutture.id_asl, tipooia.description;

 END;
$BODY$;

ALTER FUNCTION public.get_strutture_da_controllare_ac(integer, integer)
    OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.get_per_conto_di_ac(
	_id_asl integer DEFAULT -1::INTEGER,
    _anno integer DEFAULT null::INTEGER)
    RETURNS TABLE(id_asl integer, descrizione_tipologia_struttura text, descrizione_struttura text, descrizione_padre text, id integer) 
    LANGUAGE 'plpgsql'
    COST 100
    ROWS 1000

AS $BODY$
DECLARE
	r RECORD;
BEGIN
return query 
(SELECT 
	strutture.id_asl as id_asl_struttura,
   tipooia.description::text as tipologia_struttura_complessa,
	strutture.descrizione::text ,
     strutture.descrizione_padre::text,
	 strutture.id
FROM dpat_strutture_asl strutture                               
LEFT JOIN lookup_tipologia_nodo_oia tipooia ON strutture.tipologia_struttura = tipooia.code 
where data_scadenza is null and
      (strutture.id_asl = _id_asl or _id_asl =-1) and
      id_strumento_calcolo in (select dsc.id 
			                          from dpat_strumento_calcolo dsc
			                          where (dsc.id_asl = _id_asl or _id_asl = -1) and 
			                                (dsc.anno = _anno or _anno is null) 
			                  )
union
SELECT 
	strutture.id_asl as id_asl_struttura,
   tipooia.description::text as tipologia_struttura_complessa,
	strutture.descrizione::text ,
     strutture.descrizione_padre::text,
	 strutture.id
FROM dpat_strutture_asl strutture                               
LEFT JOIN lookup_tipologia_nodo_oia tipooia ON strutture.tipologia_struttura = tipooia.code 
where data_scadenza is null and
     tipologia_struttura=40
union
 -- SCENARIO BALORDO! PER NURECU DEVO ANDARE PUNTUALE SULL'ID NONOSTANTE SIA DISATTIVATO PER FLUSSO 195!!
SELECT 
	strutture.id_asl as id_asl_struttura,
        tipooia.description::text as tipologia_struttura_complessa,
	strutture.descrizione_lunga::text ,
        'REGIONE',
	 strutture.id
FROM strutture_asl strutture                               
LEFT JOIN lookup_tipologia_nodo_oia tipooia ON strutture.tipologia_struttura = tipooia.code 
where  descrizione_lunga ilike 'NU.RE.CU')
order by 1, 2;

 END;
$BODY$;

ALTER FUNCTION public.get_per_conto_di_ac(integer, integer)
    OWNER TO postgres;
--select * from dpat_strutture_asl where anno=2023 and id_asl=202

DROP FUNCTION get_qualifiche_ac(integer);

CREATE OR REPLACE FUNCTION public.get_qualifiche_ac(_anno integer)
    RETURNS TABLE(id integer, nome text, gruppo boolean, view_lista_componenti boolean, livello integer) 
    LANGUAGE 'plpgsql'
    COST 100
    ROWS 1000

AS $BODY$
DECLARE
	
BEGIN
return query 

-- query per gruppo_asl
(
select -1, 'QUALIFICHE DA ORGANIGRAMMA ASL', true, true, 0
union 
select distinct id_lookup_qualifica, r.role::text, false, false, 1
from dpat_strumento_calcolo_nominativi scn
join role r on r.role_id=scn.id_lookup_qualifica
where anno= _anno and trashed_date is null
union 
-- query per gruppo_crr
select -1, 'CENTRI DI RIFERIMENTO REGIONALI E POLO DIDATTICO', true, true, 2
union 
select r.role_id, r.role::text, false, false, 3
from role r  
join rel_gruppo_ruoli  rgr on rgr.id_ruolo = r.role_id
join lookup_gruppo_ruoli lgr on lgr.code = rgr.id_gruppo
and lgr.code = 16  and r.enabled
union
-- query per nurecu 
select -1, 'REGIONE', true, truE, 4
UNION
select r.role_id, r.role::text, false, false,5
from role r  
join rel_gruppo_ruoli  rgr on rgr.id_ruolo = r.role_id
join lookup_gruppo_ruoli lgr on lgr.code = rgr.id_gruppo
and rgr.id_ruolo=324 -- nurecu
) order by 5, 2;
 END;
$BODY$;
ALTER FUNCTION public.get_qualifiche_ac(integer)
    OWNER TO postgres;
--select * from get_qualifiche_ac(2023)


CREATE OR REPLACE FUNCTION public.dpat_get_nominativi(
	asl_input integer DEFAULT NULL::integer,
	anno_input integer DEFAULT NULL::integer,
	stato_input text DEFAULT NULL::text,
	id_struttura_complessa_input integer DEFAULT NULL::integer,
	descrizione_struttura_complessa_input text DEFAULT NULL::text,
	id_struttura_semplice_input integer DEFAULT NULL::integer,
	descrizione_struttura_semplice_input text DEFAULT NULL::text)
    RETURNS TABLE(id_nominativo integer, id_anagrafica_nominativo integer, nominativo text, codice_fiscale text, qualifica text, data_scadenza_nominativo timestamp without time zone, id_struttura_semplice integer, desc_strutt_semplice text, stato_strutt_semplice integer, data_scadenza_strutt_semplice timestamp without time zone, id_strutt_complessa integer, desc_strutt_complessa text, data_scadenza_strutt_complessa timestamp without time zone, stato_strutt_complessa integer, id_asl integer, anno integer, id_qualifica integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
	r RECORD;
BEGIN
	FOR id_nominativo, id_anagrafica_nominativo, nominativo,  codice_fiscale, qualifica, data_scadenza_nominativo,id_struttura_semplice, desc_strutt_semplice, 
       stato_strutt_semplice, data_scadenza_strutt_semplice, id_strutt_complessa, desc_strutt_complessa,data_scadenza_strutt_complessa, stato_strutt_complessa,  
       id_asl, anno, id_qualifica
      in

select n.id as id_nominativo, n.id_anagrafica_nominativo, concat(c.namefirst, ' ', c.namelast) as nominativo,  c.codice_fiscale, lq.description as qualifica,  
       n.data_scadenza as data_scadenza_nominativo,n.id_dpat_strumento_calcolo_strutture as id_struttura_semplice, strutt_semplice.descrizione as desc_strutt_semplice, 
       strutt_semplice.stato as stato_strutt_semplice, strutt_semplice.data_scadenza as data_scadenza_strutt_semplice, strutt_complessa.id as id_strutt_complessa, 
       strutt_complessa.descrizione as desc_strutt_complessa, strutt_complessa.data_scadenza as data_scadenza_strutt_complessa, strutt_complessa.stato as stato_strutt_complessa,  
       strutt_complessa.id_asl, strutt_complessa.anno, n.id_lookup_qualifica as id_qualifica
from dpat_strumento_calcolo_nominativi n 
join dpat_strutture_asl strutt_semplice on strutt_semplice.id = n.id_struttura and strutt_semplice.disabilitato = false
join dpat_strutture_asl strutt_complessa on strutt_complessa.id = strutt_semplice.id_padre and strutt_complessa.disabilitato = false 
join lookup_qualifiche lq on lq.code = id_lookup_qualifica 
join access_ users on users.user_id =  n.id_anagrafica_nominativo
join contact_ c on c.contact_id = users.contact_id
where n.trashed_Date is null and 
      (strutt_semplice.stato::text = ANY (string_to_array(stato_input, ',')) or stato_input is null) and
      (strutt_complessa.id = id_struttura_complessa_input or id_struttura_complessa_input is null) and 
      (strutt_complessa.descrizione ilike '%' || descrizione_struttura_complessa_input || '%' or descrizione_struttura_complessa_input is null) and
      (strutt_semplice.id = id_struttura_semplice_input or id_struttura_semplice_input is null) and 
      (strutt_semplice.descrizione ilike '%' || descrizione_struttura_semplice_input || '%' or descrizione_struttura_semplice_input is null) and
      strutt_complessa.id_strumento_calcolo in (select id 
						from dpat_strumento_calcolo 
						where (strutt_complessa.id_asl = asl_input or asl_input is null) and 
						      (strutt_complessa.anno = anno_input or anno_input is null) 
						)
order by lq.livello_qualifiche_dpat


        LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$;

ALTER FUNCTION public.dpat_get_nominativi(integer, integer, text, integer, text, integer, text)
    OWNER TO postgres;

     
    
DROP FUNCTION get_motivi_supervisione_ac(integer);
CREATE OR REPLACE FUNCTION public.get_motivi_supervisione_ac(
	_anno integer)
    RETURNS TABLE(id_tipo_ispezione integer, tipo_attivita text, descrizione_tipo_ispezione character varying, codice_int_tipo_ispe text, 
				  id_piano integer, descrizione_piano character varying, codice_int_piano integer, ordinamento integer, 
				  ordinamento_figli integer, livello_tipo_ispezione integer, data_scadenza timestamp without time zone, 
				  codice_interno_ind text, anno integer, codice text) 
    LANGUAGE 'plpgsql'
    COST 100
AS $BODY$

DECLARE
BEGIN
	
	return query
	
        select  a.id_tipo_ispezione , '' as tipo_attivita, a.descrizione_tipo_ispezione  , a.codice_int_tipo_ispe , 
		a.id_piano , a.descrizione_piano  , a.codice_int_piano , a.ordinamento , a.ordinamento_figli , 
		a.livello_tipo_ispezione , a.data_scadenza  , a.codice_interno_ind , a.anno ,a.codice 
		from 
			controlli_ufficiali_motivi_ispezione a where a.anno = _anno
			and a.data_scadenza is null and a.descrizione_tipo_ispezione ilike '%a3%'
							
         order by a.ordinamento,a.ordinamento_figli;
       
     RETURN;
 END;
$BODY$;

ALTER FUNCTION public.get_motivi_supervisione_ac(integer)
    OWNER TO postgres;

--select * from get_motivi_supervisione_ac(2023)
CREATE TABLE log_storico_json(id serial primary key,
							 input_json text,
							 esito text,
							 entered timestamp without time zone default now(),
							 enteredby integer
);
alter table cu_nucleo add column id_struttura_componente integer;
-------------------- nuova gestione CU per AC --------------------------

CREATE OR REPLACE FUNCTION public.insert_per_conto_di(
	_json_dati json,
    _idcu integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
AS $BODY$
	
DECLARE
	
	i integer;
	percontodi json;

BEGIN

	percontodi :=  _json_dati ->'PerContoDi';
	raise info 'percontodi: %', percontodi;
	
	FOR i IN SELECT * FROM json_array_elements(percontodi)
		LOOP
			  RAISE NOTICE 'id %', i; 
			 INSERT INTO unita_operative_controllo (id_controllo, id_unita_operativa) 
												 values (_idcu, i);
		END LOOP;
	
	
	return 1;
	
	
END;
$BODY$;

ALTER FUNCTION public.insert_per_conto_di(json, integer)
    OWNER TO postgres;

 CREATE OR REPLACE FUNCTION public.insert_strutture_controllate(
	_json_dati json,
    _idcu integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
AS $BODY$
	
DECLARE
	
	i integer;
	strutturecontrollate json;

BEGIN

	strutturecontrollate :=  _json_dati ->'StruttureControllate';
	raise info 'strutturecontrollate: %', strutturecontrollate;
	
	FOR i IN SELECT * FROM json_array_elements(strutturecontrollate)
		LOOP
			  RAISE NOTICE 'id %', i; 
			 INSERT INTO strutture_controllate_autorita_competenti (id_controllo, id_struttura, enabled, entered) 
												 values (_idcu, i, true, current_timestamp);
		END LOOP;
	
	
	return 1;
	
	
END;
$BODY$;

ALTER FUNCTION public.insert_strutture_controllate(json, integer)
    OWNER TO postgres;
    


CREATE OR REPLACE FUNCTION public.insert_nucleo_ispettivo(
	_json_dati json,
    _idcu integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
AS $BODY$
	
DECLARE
	
	val_componenti text;
	componenti json;
    idstruttura integer;
	idcomponente integer;
BEGIN

	componenti :=  _json_dati ->'Componenti';
	raise info 'componenti: %', componenti;
	
	FOR val_componenti IN SELECT * FROM json_array_elements(componenti)
		LOOP
			  RAISE NOTICE 'id %', replace(val_componenti,'"',''''); 
			  idstruttura := (select split_part(replace(val_componenti,'"',''),'_',2)::integer);
			  raise info 'idstruttura %', idstruttura;
			  idcomponente := (select split_part(replace(val_componenti,'"',''),'_',3)::integer);
			  raise info 'idcomponente %', idcomponente;
			  
			 INSERT INTO cu_nucleo (id_controllo_ufficiale, id_componente, enabled, id_struttura_componente) 
							values (_idcu, idcomponente, true, idstruttura);
		END LOOP;

	return 1;
	
END;
$BODY$;

ALTER FUNCTION public.insert_nucleo_ispettivo(json, integer)
    OWNER TO postgres;


CREATE OR REPLACE FUNCTION public.insert_motivi_oggetti_controllo(
	_json_dati json,
	_idutente integer,
    _idcu integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
AS $BODY$
	
DECLARE
	
	i integer;
	oggettoaudit json;
	idtipocu integer;
	_audit_tipo integer;
	_audit_followup boolean;
	_tipo_ispezione integer;
	
BEGIN

	oggettoaudit :=  _json_dati ->'OggettoAudit';
	raise info 'oggettoaudit: %', oggettoaudit;
	
	_audit_tipo := (_json_dati ->>'tipoMotivoAudit')::int;
	_audit_followup := (_json_dati ->>'auditFollowUp')::boolean;
	_tipo_ispezione := (_json_dati ->>'tipoMotivoSupervisione')::int;
	
	if ( (_json_dati ->>'tipoTecnica')::int = 7) then
	    -- per audit interno
		FOR i IN SELECT * FROM json_array_elements(oggettoaudit) 
		LOOP
			  RAISE NOTICE 'id %', i; 
			  INSERT INTO tipocontrolloufficialeimprese (idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, audit_tipo, oggetto_audit, audit_di_followup, enabled) 
												 values (_idcu, -1, -1, -1, -1, -1, _audit_tipo, i, _audit_followup, true);
		END LOOP;
		
	else
		INSERT INTO tipocontrolloufficialeimprese (idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, audit_tipo, oggetto_audit, audit_di_followup, enabled) 
										   values (_idcu, -1, -1, -1, _tipo_ispezione, -1, -1, -1, false, true);
		
	end if;
	
	return 1;
	
END;
$BODY$;

ALTER FUNCTION public.insert_motivi_oggetti_controllo(json, integer, integer)
    OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.insert_cu_ac(
	_json_dati json, _idutente integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
	
DECLARE
	 
	id_controllo integer;
	componenti json;
	percontodi json;
	strutturecontrollate json;
	esito_operazione text;
	output_dbi integer;
	
BEGIN
	
	componenti :=  _json_dati ->'Componenti';
	raise info 'componenti nucleo: %', componenti;
	
	percontodi :=  _json_dati ->'PerContoDi';
	raise info 'per conto di: %', percontodi;
	
	strutturecontrollate :=  _json_dati ->'StruttureControllate';
	raise info 'strutture controllate: %', strutturecontrollate;
	
	id_controllo := (select max(ticketid)+1 from ticket where ticketid < 10000000);
 	-- STEP 1: INSERIAMO IL RECORD IN TICKET PER OTTENERE IL TICKETID
	insert into ticket(ticketid, id_controllo_ufficiale, org_id, problem, entered, enteredby, modifiedby,
					   assigned_date, status_id, site_id, tipologia, 
					  provvedimenti_prescrittivi, data_fine_controllo, header_allegato_documentale) 
					  values(id_controllo, id_controllo::text, (_json_dati ->> 'orgId')::int,_json_dati ->> 'note', current_timestamp, _idutente, _idutente,
							(_json_dati ->>'dataInizioControllo')::timestamp without time zone,1,(_json_dati ->>'idAsl')::integer,3,
							(_json_dati ->>'tipoTecnica')::int, case when length(_json_dati ->> 'dataFineControllo') > 0 then (_json_dati ->> 'dataFineControllo')::timestamp without time zone else null end,
							_json_dati ->>'verbale');
			
	-- STEP 2: INSERIAMO I DATI DEI MOTIVI E OGGETTI DEL CU IN BASE ALLA TECNICA
	output_dbi :=(SELECT * from public.insert_motivi_oggetti_controllo(_json_dati, _idutente, id_controllo));	
    
	-- STEP 3: INSERIAMO LE STRUTTURE CONTROLLATE
	output_dbi :=(SELECT * from public.insert_strutture_controllate(_json_dati, id_controllo));
	
	-- STEP 3: INSERIAMO IL NUCLEO ISPETTIVO
	output_dbi :=(SELECT * from public.insert_nucleo_ispettivo(_json_dati, id_controllo));
	
	-- STEP 3: INSERIAMO PER CONTO DI
	output_dbi :=(SELECT * from public.insert_per_conto_di(_json_dati, id_controllo));
	
	if (id_controllo > 0) then
		INSERT INTO log_storico_json(input_json, esito, entered, enteredby) values(_json_dati, esito_operazione, current_timestamp, _idutente);
		esito_operazione := '{"idControlloUfficiale" :'||id_controllo||', "esito" : "OK", "descrizioneErrore" : ""}';
	else
		esito_operazione := '{"idControlloUfficiale" : -1, "esito" : "KO", "descrizioneErrore" : "inserimento CU fallito"}';
	end if;
	
	return esito_operazione;
END;
$BODY$;

ALTER FUNCTION public.insert_cu_ac(json, integer)
    OWNER TO postgres;

----------- modifica CU -------------------------

	CREATE OR REPLACE FUNCTION public.modifica_motivi_oggetti_controllo(
	_json_dati json,
	_idutente integer,
    _idcu integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
AS $BODY$
	
DECLARE
	
	i integer;
	oggettoaudit json;
	idtipocu integer;
	_audit_tipo integer;
	_audit_followup boolean;
	_tipo_ispezione integer;
	
BEGIN

	oggettoaudit :=  _json_dati ->'OggettoAudit';
	raise info 'oggettoaudit: %', oggettoaudit;
	
	_audit_tipo := (_json_dati ->>'tipoMotivoAudit')::int;
	_audit_followup := (_json_dati ->>'auditFollowUp')::boolean;
	_tipo_ispezione := (_json_dati ->>'tipoMotivoSupervisione')::int;
	
	-- disabilito e inserisco ex novo
	update tipocontrolloufficialeimprese set note_hd = concat_ws('-',note_hd,'Dbi modifica CU per autorita'' competenti. Disabiltato record per nuovo inserimento'), enabled=false 
	where idcontrollo = _idcu and enabled=true;
	
	if ( (_json_dati ->>'tipoTecnica')::int = 7) then
	    -- per audit interno
		FOR i IN SELECT * FROM json_array_elements(oggettoaudit) 
		LOOP
			  RAISE NOTICE 'id %', i; 
			  INSERT INTO tipocontrolloufficialeimprese (idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, audit_tipo, oggetto_audit, audit_di_followup, enabled) 
												 values (_idcu, -1, -1, -1, -1, -1, _audit_tipo, i, _audit_followup, true);
		END LOOP;
		
	else
		INSERT INTO tipocontrolloufficialeimprese (idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, audit_tipo, oggetto_audit, audit_di_followup, enabled) 
										   values (_idcu, -1, -1, -1, _tipo_ispezione, -1, -1, -1, false, true);
		
	end if;
	
	return 1;
	
END;
$BODY$;

ALTER FUNCTION public.modifica_motivi_oggetti_controllo(json, integer, integer)
    OWNER TO postgres;

    CREATE OR REPLACE FUNCTION public.modifica_nucleo_ispettivo(
	_json_dati json,
    _idcu integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
AS $BODY$
	
DECLARE
	
	val_componenti text;
	componenti json;
    idstruttura integer;
	idcomponente integer;
BEGIN

	componenti :=  _json_dati ->'Componenti';
	raise info 'componenti: %', componenti;
	
	update cu_nucleo set notes_hd = concat_ws('-',notes_hd,'Dbi modifica CU per autorita'' competenti. Disabiltato record per nuovo inserimento'),
	enabled=false where id_controllo_ufficiale = _idcu;
	
	FOR val_componenti IN SELECT * FROM json_array_elements(componenti)
		LOOP
			  RAISE NOTICE 'id %', replace(val_componenti,'"',''''); 
			  idstruttura := (select split_part(replace(val_componenti,'"',''),'_',2)::integer);
			  raise info 'idstruttura %', idstruttura;
			  idcomponente := (select split_part(replace(val_componenti,'"',''),'_',3)::integer);
			  raise info 'idcomponente %', idcomponente;
			  
			 INSERT INTO cu_nucleo (id_controllo_ufficiale, id_componente, enabled, id_struttura_componente) 
							values (_idcu, idcomponente, true, idstruttura);
		END LOOP;
	
	
	return 1;
	
	
END;
$BODY$;

ALTER FUNCTION public.modifica_nucleo_ispettivo(json, integer)
    OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.modifica_per_conto_di(
	_json_dati json,
    _idcu integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
AS $BODY$
	
DECLARE
	
	i integer;
	percontodi json;

BEGIN

	percontodi :=  _json_dati ->'PerContoDi';
	raise info 'percontodi: %', percontodi;
	
	delete from unita_operative_controllo where id_controllo = _idcu;
	
	FOR i IN SELECT * FROM json_array_elements(percontodi)
		LOOP
			  RAISE NOTICE 'id %', i; 
			  INSERT INTO unita_operative_controllo (id_controllo, id_unita_operativa) 
											 values (_idcu, i);
		END LOOP;
	
	
	return 1;
	
	
END;
$BODY$;

ALTER FUNCTION public.modifica_per_conto_di(json, integer)
    OWNER TO postgres;

 CREATE OR REPLACE FUNCTION public.modifica_strutture_controllate(
	_json_dati json,
    _idcu integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
AS $BODY$
	
DECLARE
	
	i integer;
	strutturecontrollate json;

BEGIN

	strutturecontrollate :=  _json_dati ->'StruttureControllate';
	raise info 'strutturecontrollate: %', strutturecontrollate;
	
	update strutture_controllate_autorita_competenti 
	     set enabled=false, note_hd = concat_ws('-',note_hd,'Dbi  CU per autorita'' competenti. Disabiltato record per nuovo inserimento')
	where id_controllo = _idcu;
	
	FOR i IN SELECT * FROM json_array_elements(strutturecontrollate)
		LOOP
			  RAISE NOTICE 'id %', i; 
			 INSERT INTO strutture_controllate_autorita_competenti (id_controllo, id_struttura, enabled, entered) 
												 values (_idcu, i, true, current_timestamp);
		END LOOP;
	
	
	return 1;
	
	
END;
$BODY$;

ALTER FUNCTION public.modifica_strutture_controllate(json, integer)
    OWNER TO postgres;

    
 CREATE OR REPLACE FUNCTION public.modifica_cu_ac(
	_json_dati json, _idutente integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
	
DECLARE
	 
	esito_operazione text;
	output_dbi integer;
	id_controllo integer;
	
BEGIN

	 id_controllo := (_json_dati ->> 'idControlloUfficiale')::integer;
	
	update ticket 
		set problem = _json_dati ->> 'note', modified = current_timestamp, modifiedby= _idutente , 
		assigned_date = (_json_dati ->> 'dataInizioControllo')::timestamp without time zone,--valutare 
		data_fine_controllo = (case when length(_json_dati ->> 'dataFineControllo') > 0 then (_json_dati ->> 'dataFineControllo')::timestamp without time zone else null end), 
		header_allegato_documentale = _json_dati ->> 'verbale'
	where ticketid = id_controllo; --si chiama così?
			
	-- STEP 2: INSERIAMO I DATI DEI MOTIVI E OGGETTI DEL CU IN BASE ALLA TECNICA
	output_dbi :=(SELECT * from public.modifica_motivi_oggetti_controllo(_json_dati, _idutente, id_controllo));	
    
	-- STEP 3: INSERIAMO LE STRUTTURE CONTROLLATE
	output_dbi :=(SELECT * from public.modifica_strutture_controllate(_json_dati, id_controllo));
	
	-- STEP 3: INSERIAMO IL NUCLEO ISPETTIVO
	output_dbi :=(SELECT * from public.modifica_nucleo_ispettivo(_json_dati, id_controllo));
	
	-- STEP 3: INSERIAMO PER CONTO DI
	output_dbi :=(SELECT * from public.modifica_per_conto_di(_json_dati, id_controllo));
	
	INSERT INTO log_storico_json(input_json, esito, entered, enteredby) values(_json_dati, esito_operazione, current_timestamp, _idutente);
		esito_operazione := '{"idControlloUfficiale" :'||id_controllo||', "esito" : "OK", "descrizioneErrore" : ""}';
	
	return esito_operazione;
END;
$BODY$;

ALTER FUNCTION public.modifica_cu_ac(json, integer)
    OWNER TO postgres;
   

    CREATE OR REPLACE FUNCTION public.get_nominativi_by_qualifica_ac(
	_anno integer,
	_id_qualifica integer,
	_id_asl integer)
    RETURNS TABLE(id integer, nominativo text, nome_struttura text, id_struttura integer, id_qualifica integer, nome_qualifica text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
	conta_personale_asl integer;
	id_gruppo integer;
BEGIN
	conta_personale_asl :=0;
	id_gruppo := -1;
	-- conto il personale DPAT
	conta_personale_asl :=(select count(*) from public.dpat_get_nominativi(_id_asl, _anno, null::text,null::integer,null::text,null,null) d
                           where d.id_qualifica = _id_qualifica);
	raise info 'conta personale ASL%', conta_personale_asl;
	-- verifico il gruppo di appartenenza della qualifica
	id_gruppo := (select r.id_gruppo from rel_gruppo_ruoli r where r.id_ruolo = _id_qualifica and r.id_gruppo=11);
	raise info 'id gruppo %', id_gruppo;

IF conta_personale_asl > 0 and id_gruppo in(11) THEN 
	
	return query 
	-- utenti dpat	
	select distinct d.id_anagrafica_nominativo, d.nominativo::text, 
	(select asl.pathdes from dpat_strutture_asl asl where asl.id=d.id_struttura_semplice)::text,  d.id_struttura_semplice, d.id_qualifica, d.qualifica
	from public.dpat_get_nominativi(_id_asl, _anno, null::text,null::integer,null::text,null,null) d
	where d.id_qualifica = _id_qualifica
	order by 2;
ELSif conta_personale_asl = 0 and id_gruppo is null then
	-- utenti nurecu e crr
	return query
	select distinct ac.user_id, concat(cc.namefirst, ' ', cc.namelast) as nominativo, ''::text, -1, ac.role_id, 
	(select role::text from role where role_id = _id_qualifica)
	from access ac
	join contact cc on cc.contact_id = ac.contact_id
	where ac.role_id = _id_qualifica order by 2;
else 
	raise info 'do nothing';
END IF;
 END;
$BODY$;

ALTER FUNCTION public.get_nominativi_by_qualifica_ac(integer, integer, integer)
    OWNER TO postgres;

 -- elimina da gisa
update access_ set  enabled= false, data_scadenza= now() where username='gbruno';
update access_ set enabled= false, data_scadenza= now() where username in(
'_cni_252bf31eb054ccbfd018117b6d124faa_324',
'_cni_34ef2d69c8b27d95d68b1c981fdaf45e_324',
'_cni_3d37a88bc1233f6680649f60b8e75e4f_324',
'_cni_46f7f40d0bb4c5bac1c8c56a276f78db_324',
'_cni_4cd698643aa937c45186c0e311a1bd04_324',
'_cni_64cc823e909bd8522bcbbbd1f3e9e872_324',
'_cni_78201b975b340003e4a309fb8d824e7d_324',
'_cni_7cc0e0763d64ddfadbe51dabd78eb2a5_324',
'_cni_99c0f338c2a213157159bb286c9bab69_324',
'_cni_a1e82ec9de437ce038176f80d2fd300a_324',
'_cni_a69006088cd3fd8e41ea9960cb06bdb2_324',
'_cni_ac60a5eb35ddd8810e791e556581245b_324',
'_cni_b36d36730d0d7eb747976452e11cc462_324',
'_cni_b81b20b05d2c19d1a71d54836e014909_324',
'_cni_bb750de0b1cfae92abf46e2a590477fc_324',
'_cni_c5c4604e5d49cc599a7e859fe69c8a1c_324',
'_cni_cb24ab45ccd9d3644a2e88d4d613fbe4_324',
'_cni_d98dcb9024f14a03efad4f0f0c2a031e_324',
'_cni_d9eaddfde6e12278d458d040d61f6962_324',
'_cni_da22a2edcd377d3226b80961899a6628_324',
'_cni_e04c3e526b3c9c3254871d1b21460e39_324',
'_cni_fbfcb119f86237948077dd1ffd614a02_324');

-- elimina da GUC
update guc_utenti_ set note_internal_use_only=concat_ws('**01/03/2023**',note_internal_use_only,'Disattivazione utente per mancato accesso da piu'' di un anno'), enabled= false, data_scadenza= now() where username='gbruno';
update guc_utenti_ set note_internal_use_only=concat_ws('**01/03/2023**',note_internal_use_only,'Disattivazione utente per mancato accesso da piu'' di un anno'), enabled= false, data_scadenza= now() where username in(
'_cni_252bf31eb054ccbfd018117b6d124faa_324',
'_cni_34ef2d69c8b27d95d68b1c981fdaf45e_324',
'_cni_3d37a88bc1233f6680649f60b8e75e4f_324',
'_cni_46f7f40d0bb4c5bac1c8c56a276f78db_324',
'_cni_4cd698643aa937c45186c0e311a1bd04_324',
'_cni_64cc823e909bd8522bcbbbd1f3e9e872_324',
'_cni_78201b975b340003e4a309fb8d824e7d_324',
'_cni_7cc0e0763d64ddfadbe51dabd78eb2a5_324',
'_cni_99c0f338c2a213157159bb286c9bab69_324',
'_cni_a1e82ec9de437ce038176f80d2fd300a_324',
'_cni_a69006088cd3fd8e41ea9960cb06bdb2_324',
'_cni_ac60a5eb35ddd8810e791e556581245b_324',
'_cni_b36d36730d0d7eb747976452e11cc462_324',
'_cni_b81b20b05d2c19d1a71d54836e014909_324',
'_cni_bb750de0b1cfae92abf46e2a590477fc_324',
'_cni_c5c4604e5d49cc599a7e859fe69c8a1c_324',
'_cni_cb24ab45ccd9d3644a2e88d4d613fbe4_324',
'_cni_d98dcb9024f14a03efad4f0f0c2a031e_324',
'_cni_d9eaddfde6e12278d458d040d61f6962_324',
'_cni_da22a2edcd377d3226b80961899a6628_324',
'_cni_e04c3e526b3c9c3254871d1b21460e39_324',
'_cni_fbfcb119f86237948077dd1ffd614a02_324');

-- parte digemon --

CREATE OR REPLACE FUNCTION digemon.get_controlli_audit_autorita_competenti_motivi_supervisione(
	_data_1 timestamp without time zone DEFAULT '1900-01-01 00:00:00'::timestamp without time zone,
	_data_2 timestamp without time zone DEFAULT NULL::timestamp without time zone)
    RETURNS TABLE(id_controllo integer, id_motivo_supervisione integer, motivo_supervisione text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE

BEGIN

	for 
	id_controllo,
	id_motivo_supervisione,
	motivo_supervisione
in 
select 
distinct
	t.ticketid as id_controllo,
	tcu.tipoispezione as id_motivo_supervisione,
	d.description::text as motivo_supervisione
    from ticket t 
	left join tipocontrolloufficialeimprese tcu on tcu.idcontrollo = t.ticketid
	left join lookup_tipo_ispezione d on d.code = tcu.tipoispezione
where 
	provvedimenti_prescrittivi = 22 and tipologia = 3 and trashed_date is null and tcu.enabled
	and t.assigned_date  between coalesce (_data_1,'1900-01-01') and coalesce (_data_2,now())
  LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
  
 END;
$BODY$;

ALTER FUNCTION digemon.get_controlli_audit_autorita_competenti_motivi_supervisione(timestamp without time zone, timestamp without time zone)
    OWNER TO postgres;
