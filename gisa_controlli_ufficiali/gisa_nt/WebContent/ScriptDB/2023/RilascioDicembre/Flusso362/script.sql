
CREATE OR REPLACE FUNCTION public.get_motivazione_piani_campione_macello(_anno_input integer DEFAULT NULL::integer)
    RETURNS TABLE(code integer, description text, default_item boolean, level integer, enabled boolean)
		--id_piano_attivita integer, id_indicatore integer, cod_raggruppamento text, anno integer, descrizione text, ordinamento_piano integer, ordinamento_indicatore integer, data_scadenza timestamp without time zone, stato integer, codice_esame text, tipo_attivita text, codice_interno_piano text, codice_interno_attivita text, alias_piano text, alias_attivita text, codice_alias_attivita text, codice_interno_indicatore text, alias_indicatore text, codice_alias_indicatore text, id_sezione integer, sezione text, tipo_item_dpat integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
BEGIN
	return query select id_indicatore, concat(upper(alias_piano),' - ', upper(descrizione)), false, 0, true  
				 from public.dpat_get_piani_attivita(_anno_input,'2,0'::text,null::integer,null::text)
				 where tipo_attivita ilike 'PIANO' 
				 and tipo_item_dpat=3
				 order by ordinamento_piano, ordinamento_indicatore;

     RETURN;
 END;
$BODY$;

ALTER FUNCTION public.get_motivazione_piani_campione_macello(integer)
    OWNER TO postgres;
	

CREATE OR REPLACE FUNCTION public.get_motivazione_attivita_campione_macello(_anno_input integer DEFAULT NULL::integer)
    RETURNS TABLE(code integer, description text, default_item boolean, level integer, enabled boolean)
		--id_piano_attivita integer, id_indicatore integer, cod_raggruppamento text, anno integer, descrizione text, ordinamento_piano integer, ordinamento_indicatore integer, data_scadenza timestamp without time zone, stato integer, codice_esame text, tipo_attivita text, codice_interno_piano text, codice_interno_attivita text, alias_piano text, alias_attivita text, codice_alias_attivita text, codice_interno_indicatore text, alias_indicatore text, codice_alias_indicatore text, id_sezione integer, sezione text, tipo_item_dpat integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
BEGIN
	return query select id_indicatore, concat(upper(alias_attivita),' - ', upper(descrizione)), false, 0, true  
				 from public.dpat_get_piani_attivita(_anno_input,'2,0'::text,null::integer,null::text)
				 where tipo_attivita ilike 'attivita-ispezione' 
				 and tipo_item_dpat = 3
				 order by ordinamento_piano, ordinamento_indicatore;

     RETURN;
 END;
$BODY$;

ALTER FUNCTION public.get_motivazione_attivita_campione_macello(integer)
    OWNER TO postgres;

	--select * from public.get_motivazione_attivita_campione_macello(2023)


DROP FUNCTION get_motivazione_campione_macello()
CREATE OR REPLACE FUNCTION public.get_motivazione_campione_macello()
    RETURNS TABLE(code integer, description text, default_item boolean, level integer, enabled boolean)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
BEGIN
	return query 
		select l.code, upper(l.description::text), l.default_item, l.level, true
		from lookup_tipo_ispezione l 
		where l.enabled=false and l.level=20
		union
		select l.code, upper(l.description::text), l.default_item, l.level, true
		from lookup_tipo_ispezione l 
		where l.description ilike 'piano di monitoraggio'
		union
		select 0, 'ATTIVITA-ISPEZIONE', false, 0, true; 		

     RETURN;
 END;
$BODY$;

ALTER FUNCTION public.get_motivazione_campione_macello()
    OWNER TO postgres;

--select * from public.get_motivazione_campione_macello()
CREATE OR REPLACE FUNCTION public.insert_campione_vpm_new(
	_id_capo integer,
	_alt_id integer,
	_matricola text,
	_data_prelievo text,
	_num_verbale text,
	_id_motivo integer,
	_id_piano integer,
	_id_matrice integer,
	_id_tipo_analisi text,
	_id_laboratorio integer,
	_note text,
	_entered_by integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE 
id_campione integer;
idmotivo integer;
motivo text;
tipomotivo text;
json_result text;
esito text;
messaggio text;
desc_motivazione text;
desc_matrice text;
desc_analiti text;
desc_laboratorio text;

BEGIN

desc_motivazione = '';

if _id_piano > 0 then
		motivo := concat('P','_',_id_piano);
		tipomotivo = 'P';
		idmotivo := _id_piano;
		desc_motivazione := (select upper(concat_ws(alias_indicatore,' ', descrizione)) from dpat_indicatore_new where id = idmotivo);
	else
		motivo := concat('A','_',_id_motivo);
		tipomotivo = 'A';
		idmotivo := _id_motivo;
		desc_motivazione := (select upper(concat_ws(alias,' ', description)) from lookup_tipo_ispezione where code = idmotivo);
	end if;

raise info 'motivo: %', motivo;


SELECT nome into desc_matrice from matrici where matrice_id = _id_matrice;
SELECT string_agg(nome, ', ') into desc_analiti from analiti where analiti_id in (select unnest(string_to_array(_id_tipo_analisi, ','))::integer);
SELECT description into desc_laboratorio from lookup_destinazione_campione where code = _id_laboratorio;


insert into m_vpm_campioni_new (
	id_capo,alt_id, matricola, data_prelievo, num_verbale, id_motivo, tipo_motivo, id_matrice, 
	id_tipo_analisi, id_laboratorio, note, entered_by) 
		values (
		_id_capo, _alt_id, _matricola, _data_prelievo,
		_num_verbale, idmotivo, tipomotivo, _id_matrice, _id_tipo_analisi, _id_laboratorio,_note, _entered_by)
	RETURNING id into id_campione;								

--update m_vpm_campioni_new set modified=now(), modified_by = _entered_by, note_hd=concat_ws(' ',note_hd,'Modifica effettuata tramite dbi "insert_campione_vpm_new(...)"'), 
--matricola=_matricola where id_capo= _id_capo;

if id_campione > 0 then
esito := 'OK';
messaggio := 'Campione al macello inserito con successo';
else
esito := 'KO';
messaggio := 'Errore di inserimento nella tabella campioni.';
end if; 

select concat('{"Esito" : "', esito, '", "Messaggio" : "', messaggio, '", "Id" : ', id_campione, ', "Motivazione" : "', desc_motivazione, '", "Matrice" : "', desc_matrice, '", "Analiti" : "', desc_analiti, '", "Laboratorio" : "', desc_laboratorio, '", "Matricola" : "', _matricola, '", "DataPrelievo" : "', _data_prelievo, '", "Note" : "', _note, '"}') into json_result;

return json_result;

END;
$BODY$;

ALTER FUNCTION public.insert_campione_vpm_new(integer, integer, text, text, text, integer, integer, integer, text, integer, text, integer)
    OWNER TO postgres;

    
CREATE OR REPLACE FUNCTION public.get_vpm_campioni_new(
	 _id_capo integer)
    RETURNS TABLE(id integer, id_campione integer, id_capo integer, matricola text, id_macello integer, data_prelievo text, numero_verbale text, 
				  id_motivo integer,
				  descrizione_motivo text, 
				  id_piano integer,
				  descrizione_piano text, 
				  id_matrice integer, descrizione_matrice text, tipo_analisi text, descrizione_analisi text, id_laboratorio integer,
				 descrizione_laboratorio text, note text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE 


BEGIN

return query
		
    select m.id, m.id_campione, m.id_capo, m.matricola, (select c.id_macello from m_capi c where c.id = _id_capo), m.data_prelievo, 
	coalesce(c.location::text, m.num_verbale), 
	case when m.tipo_motivo='A' then m.id_motivo else 89 end, 
	case when m.tipo_motivo='A' then (select upper(concat_ws(alias,' ', description)) from lookup_tipo_ispezione where code = m.id_motivo) else 'PIANO DI MONITORAGGIO' end, 
	case when m.tipo_motivo='P' then m.id_motivo else -1 end, 
	case when m.tipo_motivo='P' then (select upper(concat_ws(d.alias_indicatore,' ', d.descrizione)) from dpat_indicatore_new d where d.id = m.id_motivo) else '' end, 
	m.id_matrice, 
	(SELECT mat.nome  from matrici mat where mat.matrice_id = m.id_matrice)::text as descrizione_matrice, 
	m.id_tipo_analisi, 
	(SELECT string_agg(nome, ', ') from analiti where analiti_id in (select unnest(string_to_array(m.id_tipo_analisi, ','))::integer)) as descrizione_analisi,
    m.id_laboratorio,
	(SELECT description  from lookup_destinazione_campione where code = m.id_laboratorio)::text as descrizione_laboatorio,
	m.note
	from m_vpm_campioni_new m 
	left join ticket c on c.ticketid = m.id_campione and c.trashed_date is null and c.tipologia=2
	where m.id_capo = _id_capo and m.trashed_date is null;
	
END;
$BODY$;

ALTER FUNCTION public.get_vpm_campioni_new(integer)
    OWNER TO postgres;
    
 

CREATE OR REPLACE FUNCTION public.get_motivi_cu_per_aggiunta_motivo_seduta(
	_anno integer,
	_id_macello integer, 
	_data_seduta text,
	_numero_seduta integer
	)
    RETURNS TABLE(cod_interno_ind text, id_tipo_ispezione integer, descrizione_tipo_ispezione character varying, codice_int_tipo_ispe text, id_piano integer, descrizione_piano character varying, codice_int_piano integer, ordinamento integer, ordinamento_figli integer, livello_tipo_ispezione integer, data_scadenza timestamp without time zone, codice_interno_ind text, anno integer, codice text, tipo_attivita text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
	num_campioni integer;
BEGIN

		num_campioni := (select count(*) from m_vpm_campioni_new where id_capo in (select id from m_capi where id_macello = _id_macello  and 
															vpm_data= _data_seduta::timestamp without time zone 
															and cd_seduta_macellazione = _numero_seduta)
		and trashed_date is null);
		
		raise info 'n.campioni: %', num_campioni;
		
		if num_campioni = 0 then
			RETURN QUERY 
						 (SELECT * FROM get_motivi_cu_per_aggiunta_motivo(-1, _anno,-1)
						 union 
						 SELECT '0', g.id, upper(concat('Attività di macellazione di ungulati domestici - ',g.alias_indicatore,' >> ',g.descrizione)), '0', -1, '','0', g.ordinamento, g.ordinamento, '0', null, '0', _anno, g.codice_alias_indicatore, 'ATTIVITA-ISPEZIONE OBBLIGATORIA' 
 						 FROM dpat_indicatore_new g where g.alias_indicatore ilike '%AO19_G%' and g.anno= _anno and g.data_scadenza is null)
						 order by tipo_attivita;
		else
			RETURN QUERY 
						(SELECT * FROM get_motivi_cu_per_aggiunta_motivo(-1, _anno,-1) m where m.id_tipo_ispezione in (
															select id_motivo from m_vpm_campioni_new where id_capo in (select id from m_capi where id_macello = _id_macello and 
															vpm_data= _data_seduta::timestamp without time zone 
															and cd_seduta_macellazione = _numero_seduta)
															and trashed_date is null and tipo_motivo='A')
						 union
						 SELECT * FROM get_motivi_cu_per_aggiunta_motivo(-1, _anno,-1) n where n.id_piano in (select id_motivo from m_vpm_campioni_new where id_capo in (select id from m_capi where id_macello = _id_macello and 
															vpm_data= _data_seduta::timestamp without time zone 
															and cd_seduta_macellazione = _numero_seduta)
															and trashed_date is null and tipo_motivo='P')
						union
						 SELECT '0', g.id, upper(concat('Attività di macellazione di ungulati domestici - ',g.alias_indicatore,' >> ',g.descrizione)), '0', -1, '','0', g.ordinamento, g.ordinamento, '0', null, '0', _anno, g.codice_alias_indicatore, 'ATTIVITA-ISPEZIONE OBBLIGATORIA' 
 						 FROM dpat_indicatore_new g where g.alias_indicatore ilike '%AO19_G%' and g.anno= _anno and g.data_scadenza is null)
						 order by tipo_attivita;
															
		end if;
 END;
$BODY$;

ALTER FUNCTION public.get_motivi_cu_per_aggiunta_motivo_seduta(integer, integer, text, integer)
    OWNER TO postgres;
	


    -- FUNCTION: dbi_gestione_cu.verifica_campi_cu_insert_1(date, integer, date, integer, integer, integer, text, text, text, date, text, text, integer, text, text[], boolean)

-- DROP FUNCTION IF EXISTS dbi_gestione_cu.verifica_campi_cu_insert_1(date, integer, date, integer, integer, integer, text, text, text, date, text, text, integer, text, text[], boolean);

CREATE OR REPLACE FUNCTION dbi_gestione_cu.verifica_campi_cu_insert_1(
	data_inizio_controllo date,
	id_asl integer,
	_data_fine_controllo date,
	_id_stabilimento integer,
	_enteredby integer,
	_modifiedby integer,
	lista_attivita_motivi text,
	lista_piani_motivi text,
	oggetto_cu text,
	_entered date,
	id_nucleo_ispettivo text,
	_id_linea_attivita text,
	_provvedimenti_prescrittivi integer,
	_riferimento_id_nome_tab text,
	chiave_hstore text[],
	validazione boolean)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

   DECLARE

msg text;
validatore_integer boolean;
validatore_text boolean;
validatore_data_null boolean;
validatore_asl boolean;
validatore_entered boolean;
validatore_data boolean;
validatore_oggetto boolean;
validatore_motivo boolean;
validatore_nucleo boolean;
validatore_match boolean;
validatore_piano boolean;
validatore_linea boolean;
check_hstore integer;
oggetto integer;

BEGIN 

msg := '';
raise info '%', chiave_hstore;
validatore_data_null := (select * from dbi_gestione_cu.date_null(data_inizio_controllo));
if(validatore_data_null = false)THEN 
	msg := 'IL CAMPO DATA INIZIO CONTROLLO NON PUO ESSERE NULL';
	return msg;
END IF;

validatore_data_null := (select * from dbi_gestione_cu.date_null(_data_fine_controllo));
if(validatore_data_null = false)THEN 
	msg := 'IL CAMPO DATA FINE CONTROLLO NON PUO ESSERE NULL';
	return msg;
END IF;

--Se il controllo e un ncp la data puo essere precedente al anno attuale quindi viene usata una dbi esterna
if(_provvedimenti_prescrittivi = 2)THEN 
	validatore_data := (select * from dbi_gestione_cu.date_is_valid_ncp(_data_fine_controllo, data_inizio_controllo, _entered));
	if(validatore_data = false) THEN 
		msg := 'DATA FINE CONTROLLO INFERIORE ALLA DATA DI INIZIO DEL CONTROLLO OPPURE DATA INIZIO CONTROLLO MAGGIORE DELLA DATA ODIERNA.';
		return msg; 
	END IF;
ELSE 
	validatore_data := (select * from dbi_gestione_cu.date_is_valid(_data_fine_controllo, data_inizio_controllo, _entered));
	if(validatore_data = false) THEN 
		msg := 'DATA FINE CONTROLLO INFERIORE ALLA DATA DI INIZIO DEL CONTROLLO OPPURE DATA INIZIO CONTROLLO MAGGIORE DELLA DATA ODIERNA.';
		return msg; 
	END IF;
END IF;

validatore_integer := (select * from dbi_gestione_cu.integer_null(id_asl));
if(validatore_integer = false)THEN 
	msg := 'IL CAMPO ASL NON PUO ESSERE NULL';											
	return msg;
END IF;

-- Controllo se l'asl ricade nel range 201-207
validatore_asl := (select * from dbi_gestione_cu.asl_is_valid(id_asl));
if(validatore_asl = false)THEN
	msg := 'ASL NON VALIDA. I VALORI CONSENTITI CORRISPONDONO ALLE ASL AVELLINO (CODICE 201), BENEVENTO  (CODICE 202), CASERTA  (CODICE 203), NAPOLI 1 CENTRO  (CODICE 204), NAPOLI 2 NORD  (CODICE 205), SALERNO  (CODICE 206)';
	return msg;
END IF; 

validatore_integer := (select * from dbi_gestione_cu.integer_null(_id_stabilimento));
if(validatore_integer = false)THEN 
	msg := 'IL CAMPO ID STABILIMENTO NON PUO ESSERE NULL';
	return msg;
END IF;

validatore_match := (select * from dbi_gestione_cu.match_asl_valid(_id_stabilimento, id_asl));
if(validatore_match = false) then
	msg := 'ASL DISCORDANTE O STABILIMENTO NON PRESENTE NEL TIPO SELEZIONATO';
	return msg;
END IF;

validatore_integer := (select * from dbi_gestione_cu.integer_null(_enteredby));
if(validatore_integer = false)THEN 
	msg := 'IL CAMPO ENTEREDBY NON PUO ESSERE NULL';
	return msg;
END IF;

validatore_integer := (select * from dbi_gestione_cu.integer_null(_modifiedby));
if(validatore_integer = false)THEN 
	msg := 'IL CAMPO MODIFIEDBY NON PUO ESSERE NULL'; 
	return msg;
END IF;

--Se il controllo e un ispezione semplice da gisa ext controllo nelle tabelle di access ext
if(_provvedimenti_prescrittivi = 1)THEN 
	validatore_entered := (select * from dbi_gestione_cu.entered_ext_is_valid(_enteredby));
	if(validatore_entered = false)THEN 
		msg := 'Inserimento da utente non presente nella tabella access_ext';
		return msg;
	END IF;

	validatore_entered := (select * from dbi_gestione_cu.entered_ext_is_valid(_modifiedby));
	if(validatore_entered = false)THEN 
		msg := 'Modifica da utente non presente nella tabella access_ext';
		return msg;
	END IF;
ELSE 	
	validatore_entered := (select * from dbi_gestione_cu.entered_is_valid(_enteredby));
	if(validatore_entered = false)THEN 
		msg := 'Inserimento da utente non presente nella tabella access';
		return msg;
	END IF;

	validatore_entered := (select * from dbi_gestione_cu.entered_is_valid(_modifiedby));
	if(validatore_entered = false)THEN 
		msg := 'Modifica da utente non presente nella tabella access';
		return msg;
	END IF;
END IF;

--Se il controllo è un ispezione semplice 
if(_provvedimenti_prescrittivi = 4)THEN
	validatore_text := (select * from dbi_gestione_cu.text_null(lista_attivita_motivi));
	if(validatore_text = false)THEN 
		validatore_text := (select * from dbi_gestione_cu.text_null(lista_piani_motivi));
		if(validatore_text = false)THEN 
			msg := 'IL CAMPO MOTIVO NON PUO ESSERE NULL';
			return msg;
		END IF; 
	END IF;
	validatore_text := (select * from dbi_gestione_cu.text_null(lista_piani_motivi));
	if(validatore_text = false)THEN 
		validatore_text := (select * from dbi_gestione_cu.text_null(lista_attivita_motivi));
		if(validatore_text = false)THEN 
			msg := 'IL CAMPO MOTIVO NON PUO ESSERE NULL';
			return msg;
		END IF; 
	END IF;
	--validatore_motivo := (select * from dbi_gestione_cu.motivo_is_valid(lista_attivita_motivi, data_inizio_controllo));
	--if(validatore_motivo = false) THEN 
	--		msg := 'TIPO ISPEZIONE NON VALIDA';
	--		return msg;
	--END IF; 
	validatore_piano := (select * from dbi_gestione_cu.pianomonitoraggio_is_valid(lista_piani_motivi, data_inizio_controllo));
	if(validatore_piano = false)THEN 
		msg := 'PIANO NON VALIDO ';
		return msg;
	END IF;
END IF;

--Se il controllo è un ncp o una ispezione giornaliera carni o una sorveglianza aperta
if(_provvedimenti_prescrittivi = 2 OR _provvedimenti_prescrittivi = 26 OR _provvedimenti_prescrittivi = 5)THEN
	validatore_text := (select * from dbi_gestione_cu.text_null(lista_attivita_motivi));
	if(validatore_text = false)THEN 
		msg := 'IL CAMPO PER CONTO DI NON PUO ESSERE NULL';
		return msg;
	END IF;
END IF;
	
--Se il controllo è un audit
if(_provvedimenti_prescrittivi = 3)THEN
	validatore_text := (select * from dbi_gestione_cu.text_null(lista_attivita_motivi));
	if(validatore_text = false)THEN 
		msg := 'IL CAMPO MOTIVO NON PUO ESSERE NULL';
		return msg;
	END IF;
	validatore_motivo := (select * from dbi_gestione_cu.motivo_audit_is_valid(lista_attivita_motivi, data_inizio_controllo));
	if(validatore_motivo = false) THEN 
		msg := 'MOTIVO NON VALIDO PER TECNICA AUDIT';
		return msg;
	END IF;
END IF; 

if(_provvedimenti_prescrittivi = 3)THEN
	check_hstore := (array_length(chiave_hstore, 1));
	if(check_hstore > 1)THEN
		msg := 'L''HSTORE ACCETTA NEL CASO DEL AUDIT UNA SOLA CHIAVE: ISPEZIONE';
		return msg; 
	END IF;	
	if(chiave_hstore[1] <> 'ispezione')THEN
		msg := 'L''HSTORE ACCETTA NEL CASO DEL AUDIT UNA SOLA CHIAVE: ISPEZIONE';
		return msg;
	END IF;
END IF;

if(_provvedimenti_prescrittivi = 4) THEN 
	check_hstore := (array_length(chiave_hstore, 1));
	raise info '% check hstore', check_hstore;
	if(check_hstore > 2)THEN
		msg := 'L''HSTORE ACCETTA NEL CASO DEL ISPEZIONE SEMPLICE SOLO DUE CHIAVI: ISPEZIONE E PIANO';
		return msg;
	END IF; 
	IF(chiave_hstore[1]<> 'ispezione' AND chiave_hstore[1] <> 'piano')THEN
		msg := 'L''HSTORE ACCETTA NEL CASO DEL ISPEZIONE SEMPLICE SOLO DUE CHIAVI: ISPEZIONE E PIANO';
		return msg;
	END IF;
	if(check_hstore = 2)THEN
		IF(chiave_hstore[2]<> 'ispezione' AND chiave_hstore[2] <> 'piano')THEN
			msg := 'L''HSTORE ACCETTA NEL CASO DEL ISPEZIONE SEMPLICE SOLO DUE CHIAVI: ISPEZIONE E PIANO';
			return msg;
		END IF;
	END IF;
END IF;

--Per l attivita giornaliera di ispezioni carni al macello e la sorveglianza aperta non è presente l oggetto del controllo
if(_provvedimenti_prescrittivi <> 26 AND _provvedimenti_prescrittivi <> 5)THEN 
	if((length(trim(oggetto_cu)) = 1))THEN
		oggetto := (cast(oggetto_cu as integer));
		if(oggetto > 0 AND oggetto < 10 AND oggetto <> 7)THEN
			msg := 'UNO O PIU'' OGGETTI DEL CONTROLLO SOTTOPOSTI AL CONTROLLO NON VALIDI';
			return msg;
		END IF;
	END IF; 
	validatore_text := (select * from dbi_gestione_cu.text_null(oggetto_cu));
	if(validatore_text = false AND oggetto_cu <> '7')THEN 
		msg := 'IL CAMPO OGGETTO SOTTOPOSTO AL CONTROLLO NON PUO ESSERE NULL';
		return msg;
	END IF;
END IF;
--Per l attivita giornaliera di ispezioni carni al macello e la sorveglianza aperta non è presente l oggetto del controllo
if(_provvedimenti_prescrittivi <> 26 AND _provvedimenti_prescrittivi <> 5)THEN
	validatore_oggetto := (select * from dbi_gestione_cu.oggetto_is_valid(oggetto_cu));
	if(validatore_oggetto = false) THEN 
		msg := 'UNO O PIU'' OGGETTI DEL CONTROLLO SOTTOPOSTI AL CONTROLLO NON VALIDI';
		return msg;
	END IF;
END IF; 

validatore_text := (select * from dbi_gestione_cu.text_null(id_nucleo_ispettivo));
if(validatore_text = false)THEN 
	msg := 'IL CAMPO NUCLEO ISPETTIVO NON PUO ESSERE NULL';
	return msg;
END IF;

--Se il controllo e un ispezione semplice da gisa ext controllo nelle tabelle di access ext
if(_provvedimenti_prescrittivi = 1)THEN
	validatore_nucleo := (select * from dbi_gestione_cu.nucleo_is_valid_ext(id_nucleo_ispettivo));
	if(validatore_nucleo = false) THEN 
		msg := 'NUCLEO ISPETTIVO NON VALIDO';
		return msg;
	END IF;
ELSE
	validatore_nucleo := (select * from dbi_gestione_cu.nucleo_is_valid(id_nucleo_ispettivo, data_inizio_controllo, id_asl));
	if(validazione = false)THEN
		validatore_nucleo := true;
	END IF; 
	if(validatore_nucleo = false) THEN 
		msg := 'NUCLEO ISPETTIVO NON VALIDO';
		return msg;
	END IF;
END IF;

--Se il controllo è una sorveglianza aperta non faccio nulla, se il controllo è un audit controllo solo che la linea non sia null poiche il controllo viene fatto nella insert audit, se il controllo non è un audit procedo a controllare anche la linea
if(_provvedimenti_prescrittivi <> 5)THEN
	if(_provvedimenti_prescrittivi <> 3)THEN
		validatore_integer := (select * from dbi_gestione_cu.integer_null(cast(_id_linea_attivita as integer)));
		if(validatore_integer = false)THEN 
			msg := 'IL CAMPO LINEA ATTIVITA NON PUO ESSERE NULL';
			return msg; 
		END IF;
		validatore_linea := (select * from dbi_gestione_cu.linea_attivita_is_valid(cast(_id_linea_attivita as integer), _riferimento_id_nome_tab, _id_stabilimento));
		if(validatore_linea = false)THEN					 
			msg := 'LINEA ATTIVITA SOTTOPOSTA A CONTROLLO';
			return msg;
		END IF;
	ELSE 
		validatore_text := (select * from dbi_gestione_cu.text_null(_id_linea_attivita));
		if(validatore_text = false)THEN 
			msg := 'IL CAMPO LINEA ATTIVITA NON PUO ESSERE NULL';
			return msg;
		END IF;
	END IF;
END IF;

return msg; 

END 
$BODY$;

ALTER FUNCTION dbi_gestione_cu.verifica_campi_cu_insert_1(date, integer, date, integer, integer, integer, text, text, text, date, text, text, integer, text, text[], boolean)
    OWNER TO postgres;

-- FUNCTION: public.chiudi_seduta_new(integer, text, integer, integer, text, text, text, text, integer)

-- DROP FUNCTION IF EXISTS public.chiudi_seduta_new(integer, text, integer, integer, text, text, text, text, integer);
CREATE OR REPLACE FUNCTION public.chiudi_seduta_new(
	_id_macello integer,
	_data_vpm text,
	_numero_seduta integer,
	_id_asl integer,
	_lista_motivi text,
	_lista_piani text,
	_lista_oggetti_del_controllo text,
	_lista_nucleo_ispettivo text,
	_id_utente integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE 

json_result text;
esito text;
messaggio text;
motivo text;
idmotivo integer;
tipomotivo text;
id_controllo text;
rec record;
idcampione integer;
n_capi integer;
lista_per_conto_di text;
--new
tot_piani integer;
tot_att integer;
i integer;
lista_piani text;
lista_att text;
lista_def text;

BEGIN
n_capi := (select count(*) from m_capi where id_macello = _id_macello and 
			vpm_data= _data_vpm::timestamp without time zone and cd_seduta_macellazione = _numero_seduta);

i :=0;
tot_piani := (select cardinality(string_to_array(_lista_piani, '/'))); 
raise info 'tot piani %', tot_piani;
tot_att := (select cardinality(string_to_array(_lista_motivi, '/')));
raise info 'tot_att %', tot_att;

if tot_piani > 0 then
	for i in 0..tot_piani
		LOOP
			i := i+1;
				lista_piani := concat_ws('-', lista_piani, (select split_part(split_part(_lista_piani,'/',i),'-',1)));
				raise info 'lista piani: %', lista_piani;
		END LOOP;
	lista_piani := (select substr(lista_piani, 1, length(lista_piani) - 1));

else 
	lista_piani := '';
end if;

if tot_att > 0 then
	for i in 0..tot_att
		LOOP
			i := i+1;
			lista_att := concat_ws('-', lista_att, (select split_part(split_part(_lista_motivi,'/',i),'-',1)));
			raise info 'lista att: %', lista_att;
		END LOOP;
	lista_att := (select substr(lista_att, 1, length(lista_att) - 1));
else 
	tot_att :='';
end if;

if tot_piani >0 and tot_att > 0 then
	raise info 'Scenario di piani e attivita'' presenti';
	lista_per_conto_di := (select concat('ispezione=>',_lista_motivi,',piano=>', _lista_piani));
elsif tot_piani = 0 and tot_att > 0 then
	raise info 'Scenario di sole attivita'' presenti';
	lista_per_conto_di := (select concat('ispezione=>',_lista_motivi));
else
	raise info 'Scenario di soli piani presenti';
	lista_per_conto_di := (select concat('piano=>', _lista_piani));
end if;

raise info 'lista motivi: %', lista_att;
raise info 'lista piani: %', lista_piani;
raise info 'per conto di: %', lista_per_conto_di; 

if (n_capi > 0) then

	update m_capi set modified_by = _id_utente, articolo17=true 
	where id_macello = _id_macello and 
	vpm_data= _data_vpm::timestamp without time zone 
	and cd_seduta_macellazione = _numero_seduta;

	update m_capi_sedute set id_utente_chiusura = _id_utente,
	data_chiusura=current_timestamp,
	seduta_chiusa =true
	where id_macello = _id_macello and data= _data_vpm::timestamp 
	and numero = _numero_seduta;

	-- inserisco il CU sul macello e salvo il numero della seduta in ticket
	messaggio := (select * from public.inserisci_cu_vpm_new(_id_macello, _data_vpm, _id_asl,
															lista_att::text,
															lista_piani::text,
															lista_per_conto_di::text,
															_lista_oggetti_del_controllo,  
															_lista_nucleo_ispettivo,
															_id_utente));
	id_controllo := messaggio::json->>'Id Controllo'; --(SELECT RIGHT(messaggio, - 3));
	
	raise info 'CU inserito: %', id_controllo;
	-- aggiorno la seduta con il CU appena inserito

	update  m_capi_sedute set id_cu = id_controllo::integer
	where id_macello = _id_macello and data= _data_vpm::timestamp 
	and numero = _numero_seduta;

	-- parte campioni da includere
	FOR rec IN
		 select 
			 cam.id as idcam, 
			 cam.id_motivo as idmotivo, 
			 cam.tipo_motivo as tipomotivo, 
			 cam.matricola as matr, cam.note as note, cam.id_matrice as idmatrice, 
			 cam.id_laboratorio as idlab, 
			 cam.id_tipo_analisi as idanaliti 
			from m_capi capi
			join m_vpm_campioni_new cam on cam.id_capo = capi.id
			where cam.trashed_date is null and id_macello = _id_macello 
			and cd_seduta_macellazione = _numero_seduta and cam.data_prelievo = _data_vpm

	   LOOP
	       motivo := concat(rec.tipomotivo,'_',rec.idmotivo);
		   raise info 'motivo: %', motivo;
		   idcampione := (select * from public.insert_campione_al_macello (_id_macello, _data_vpm, motivo, _id_utente, _id_asl, 
																		rec.idmatrice, rec.idanaliti, rec.idlab, rec.note, id_controllo::integer, rec.matr));
	
		  raise info 'id campione %', idcampione;
		  update m_vpm_campioni_new set id_campione= idcampione 
		  where id = rec.idcam;
		 
	   END LOOP;

	 -- CU stato chiuso
	update ticket set status_id=2, closed= now(), chiusura_attesa_esito=true where ticketid = id_controllo::integer;
	messaggio = concat('Seduta chiusa correttamente. Controllo ufficiale generato con id:',id_controllo);
	esito := 'OK';
ELSE 
	esito := 'KO';
	messaggio := 'Nessun capo da aggiornare.';
END IF;

select concat('{"Esito" : "', esito, '", "Messaggio" : "', messaggio, '"}') into json_result;
return json_result;		

END;
$BODY$;

ALTER FUNCTION public.chiudi_seduta_new(integer, text, integer, integer, text, text, text, text, integer)
    OWNER TO postgres;
    
    

CREATE OR REPLACE FUNCTION public.inserisci_cu_vpm_new(
	_id_macello integer,
	_data_seduta text,
	_id_asl integer,
	_lista_motivi text,
	_lista_piani text,
	_lista_per_conto_di text,
	_lista_oggetti_del_controllo text,
	_lista_nucleo_ispettivo text,
	_id_utente integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE 

json_result text;
esito text;
num_nucleo integer;
componenti_nucleo text;
messaggio text;
id_controllo text;
data_inizio_cu text;
id_linea_attivita integer;
id_motivo integer;
motivo text;

BEGIN

id_linea_attivita := (select id from public.get_linee_attivita(_id_macello, 'sintesis_stabilimento', false, -1) where linea_attivita ilike 'SH MACELLO' AND trashed_date is null);
data_inizio_cu = (select to_char( _data_seduta::timestamp,'yyyy-mm-dd'));					  
num_nucleo := (select cardinality(string_to_array(_lista_nucleo_ispettivo, '-')));
componenti_nucleo := (select get_lista_componenti_nucleo(_lista_nucleo_ispettivo,num_nucleo));

raise info 'lista motivi: %', _lista_motivi;
if _lista_motivi = '' then
	_lista_motivi := null;
end if;

raise info 'lista piani: %', _lista_piani;
if _lista_piani = '' then
	_lista_piani := null;
end if;

-- dbi da utilizzare per inserire il CU
select * into messaggio from dbi_gestione_cu.insert_cu_ispezione_semplice_1(
										 'INSERIMENTO CONTROLLO AUTOMATICO AL MACELLO'::text,
										 data_inizio_cu::date,
										 _id_asl,
										 data_inizio_cu::date, --data fine controllo uguale a data inizio
										 _id_macello, -- id stabilimento sarebbe
										 _id_utente, 
										 _lista_motivi::text, -- id attivita
								         _lista_piani::text,  -- id piani
										 _lista_oggetti_del_controllo::text, -- oggetti del controllo 
										 _lista_per_conto_di::hstore,
										 --motivo::hstore, --attivita+percontodi 
										 componenti_nucleo::text, --componenti nucleo calcolati
										 id_linea_attivita, false);
raise info '%', messaggio;
return messaggio;

END;
$BODY$;

ALTER FUNCTION public.inserisci_cu_vpm_new(integer, text, integer, text, text, text, text, text, integer)
    OWNER TO postgres;

