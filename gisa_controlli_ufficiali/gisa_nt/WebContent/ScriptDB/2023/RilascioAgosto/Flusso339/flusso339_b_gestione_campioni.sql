DROP TABLE IF EXISTS public.m_vpm_campioni_new;

CREATE TABLE IF NOT EXISTS public.m_vpm_campioni_new
(
    id integer NOT NULL DEFAULT nextval('m_vpm_campioni_new_id_seq'::regclass),
    id_capo integer,
    alt_id integer,
    matricola text COLLATE pg_catalog."default",
    data_prelievo text COLLATE pg_catalog."default",
    num_verbale text COLLATE pg_catalog."default",
    id_motivo integer,
    id_matrice integer,
    id_tipo_analisi text COLLATE pg_catalog."default",
    id_laboratorio integer,
    note text COLLATE pg_catalog."default",
    entered_by integer,
    modified_by integer,
    entered timestamp with time zone DEFAULT now(),
    modified timestamp with time zone DEFAULT now(),
    trashed_date timestamp with time zone,
    note_hd text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.m_vpm_campioni_new
    OWNER to postgres;


CREATE OR REPLACE FUNCTION public.insert_campione_vpm_new(
	_id_capo integer,
	_alt_id integer,
	_matricola text,
	_data_prelievo text,
	_num_verbale text,
	_id_motivo integer,
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

json_result text;
esito text;
messaggio text;
desc_motivazione text;
desc_matrice text;
desc_analiti text;
desc_laboratorio text;

BEGIN

SELECT nome into desc_matrice from matrici where matrice_id = _id_matrice;
SELECT string_agg(nome, ', ') into desc_analiti from analiti where analiti_id in (select unnest(string_to_array(_id_tipo_analisi, ','))::integer);select concat_ws(alias_indicatore,' ', descrizione) into desc_motivazione from dpat_indicatore_new where id = _id_motivo;
SELECT description into desc_laboratorio from lookup_destinazione_campione where code = _id_laboratorio;


insert into m_vpm_campioni_new (
	id_capo,alt_id, matricola, data_prelievo, num_verbale, id_motivo, id_matrice, 
	id_tipo_analisi, id_laboratorio, note, entered_by) 
		values (
		_id_capo, _alt_id, _matricola, _data_prelievo,
		_num_verbale, _id_motivo, _id_matrice, _id_tipo_analisi, _id_laboratorio,_note, _entered_by)
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

ALTER FUNCTION public.insert_campione_vpm_new(integer, integer, text, text, text, integer, integer, text, integer, text, integer)
    OWNER TO postgres;





CREATE OR REPLACE FUNCTION public.aggiorna_campioni_vpm_new(
	_id_capo integer,
	_matricola text,
	_lista_campioni text,
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

BEGIN

update m_vpm_campioni_new set 
id_capo = _id_capo  
where matricola = _matricola and id in (select unnest(string_to_array(_lista_campioni, ','))::integer);

update m_vpm_campioni_new set 
trashed_date=now(), 
modified_by= _id_utente, 
modified=now(), 
note_hd=concat_ws(' ',note_hd,'Modifica effettuata tramite dbi "aggiorna_campioni_vpm_new(...)"')
where id_capo = -1 and matricola = _matricola and id not in (select unnest(string_to_array(_lista_campioni, ','))::integer)
and trashed_date is null;

esito := 'OK';
messaggio := 'Aggiornamento effettuato con successo';

select concat('{"Esito" : "', esito, '", "Messaggio" : "', messaggio, '"}') into json_result;

return json_result;

END;
$BODY$;

ALTER FUNCTION public.aggiorna_campioni_vpm_new(integer, text, text, integer)
    OWNER TO postgres;
	
	


	
	
	
	


alter table m_capi_sedute add column seduta_chiusa boolean; 
alter table m_capi_sedute add column data_chiusura timestamp without time zone;
alter table m_capi_sedute add column id_utente_chiusura integer;
    
    
alter table m_capi_sedute add column id_cu integer;
alter table m_vpm_campioni_new add column id_campione integer;

CREATE OR REPLACE FUNCTION public.get_vpm_campioni_new(
	 _id_capo integer)
    RETURNS TABLE(id integer, id_campione integer, id_capo integer, matricola text, id_macello integer, data_prelievo text, numero_verbale text, id_motivo integer,
				  descrizione_motivo text, id_matrice integer, descrizione_matrice text, tipo_analisi text, descrizione_analisi text, id_laboratorio integer,
				 descrizione_laboratorio text, note text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE 


BEGIN

return query
		
    select m.id, m.id_campione, m.id_capo, m.matricola, (select c.id_macello from m_capi c where c.id = _id_capo), m.data_prelievo, coalesce(c.location::text, m.num_verbale), m.id_motivo, 
	(select concat_ws(d.alias_indicatore,' ', d.descrizione) from dpat_indicatore_new d where d.id = m.id_motivo) as descrizione_motivo, 
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
--SELECT * FROM get_vpm_campioni_new(1397761)


CREATE OR REPLACE FUNCTION public.get_vpm_motivo_campioni_new(
	_data_prelievo text)
    RETURNS TABLE(id_motivo integer, descrizione_motivo text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE 
anno_campione integer;
BEGIN
anno_campione := (select date_part('year',_data_prelievo::date));
raise info '%', anno_campione; 
return query
	-- tipo: attività			  
	select id, descrizione::text  from dbi_gestione_cu.estrazione_motivi(1, anno_campione) where descrizione ilike '%giornate MACELLazione%';
END;
$BODY$;

ALTER FUNCTION public.get_vpm_motivo_campioni_new(text)
    OWNER TO postgres;


ALTER FUNCTION public.get_vpm_motivo_campioni_new(text)
    OWNER TO postgres;

    

 ----------------------------------------------inserimento CU al MACELLO --------------------------------------------
-- FUNCTION: public.get_lista_componenti_nucleo(text, integer)

-- DROP FUNCTION IF EXISTS public.get_lista_componenti_nucleo(text, integer);

CREATE OR REPLACE FUNCTION public.get_lista_componenti_nucleo(
	_lista_da_splittare text,
	_dim integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
componenti_nucleo text;
i text;
begin
for counter in 1.._dim loop
	FOR i  in (select split_part(split_part(_lista_da_splittare,'-',counter),'_',3))
	LOOP
  		raise info 'i %', i;
		componenti_nucleo := concat_ws('-', i, componenti_nucleo);
	END LOOP;
		raise info 'componenti nucleo: %', componenti_nucleo;
end loop;
	return componenti_nucleo;
end; 
$BODY$;

ALTER FUNCTION public.get_lista_componenti_nucleo(text, integer)
    OWNER TO postgres;


CREATE OR REPLACE FUNCTION public.chiudi_seduta_new(
	_id_macello integer,
	_data_vpm text,
	_numero_seduta integer,
	_id_asl integer,
	_id_motivo integer,
	_id_piano integer,
	_id_per_conto_di integer,
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

BEGIN
n_capi := (select count(*) from m_capi where id_macello = _id_macello and 
			vpm_data= _data_vpm::timestamp without time zone and cd_seduta_macellazione = _numero_seduta);

if _id_piano > 0 then
		motivo := concat('P','_',_id_piano);
		tipomotivo = 'P';
		idmotivo := _id_piano;
	else
		motivo := concat('A','_',_id_motivo);
		tipomotivo = 'A';
		idmotivo := _id_motivo;
	end if;




raise info 'motivo: %', motivo;

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
															_id_motivo ,
															_id_piano ,
															_id_per_conto_di ,
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
		 select cam.id as idcam, cam.id_motivo as idmotivo, cam.matricola as matr, cam.note as note, cam.id_matrice as idmatrice, cam.id_laboratorio as idlab, 
				cam.id_tipo_analisi as idanaliti 
			from m_capi capi
			join m_vpm_campioni_new cam on cam.id_capo = capi.id
			where cam.trashed_date is null and id_macello= _id_macello
			and cd_seduta_macellazione = _numero_seduta and cam.data_prelievo = _data_vpm
			
	   LOOP
		  idcampione := (select * from public.insert_campione_al_macello (_id_macello, _data_vpm, motivo, _id_utente, _id_asl, 
																		rec.idmatrice, rec.idanaliti, rec.idlab, rec.note, id_controllo::integer, rec.matr));
	
		  raise info 'id campione %', idcampione;
		  update m_vpm_campioni_new set id_campione= idcampione, tipo_motivo = tipomotivo, id_motivo = idmotivo  where id = rec.idcam;
		 
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

ALTER FUNCTION public.chiudi_seduta_new(integer, text, integer, integer, integer, integer, integer, text, text, integer)
    OWNER TO postgres;
	

CREATE OR REPLACE FUNCTION public.inserisci_cu_vpm_new(
    _id_macello integer,
	_data_seduta text,
	_id_asl integer,
	_id_motivo integer,
	_id_piano integer,
	_id_per_conto_di integer,
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

if _id_piano > 0 then
	motivo := concat('piano=>', _id_piano, concat('-',_id_per_conto_di::text));
else
	motivo := concat('ispezione=>', _id_motivo, concat('-',_id_per_conto_di::text));
end if;
-- dbi da utilizzare per inserire il CU
select * into messaggio from dbi_gestione_cu.insert_cu_ispezione_semplice_1(
										 'INSERIMENTO CONTROLLO AUTOMATICO AL MACELLO'::text,
										 data_inizio_cu::date,
										 _id_asl,
										 data_inizio_cu::date, --data fine controllo uguale a data inizio
										 _id_macello, -- id stabilimento sarebbe
										 _id_utente, 
										 (case when _id_motivo > 0 and _id_motivo <> 89 then _id_motivo::text else null::text end), -- id attivita
								         (case when _id_piano > 0 then _id_piano::text else null::text end), --id piano vuoto
										 _lista_oggetti_del_controllo::text, -- oggetti del controllo 
										 motivo::hstore, --attivita+percontodi 
										 componenti_nucleo::text, --componenti nucleo calcolati
										 id_linea_attivita, false);
raise info '%', messaggio;
return messaggio;

END;
$BODY$;

CREATE OR REPLACE FUNCTION public.insert_campione_al_macello(
	_alt_id integer,
	_data_prelievo text,
	_motivazione text,
	_enteredby integer,
	_id_asl integer,
	_id_matrice integer,
	_id_analiti text,
	_id_laboratorio integer,
    _note text, 
    _idcu integer,
    _matricola text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE 

idcampione integer;
identificativo text;
id_analiti integer[];
elem int;
num_verbale text;
id_motivazione integer;
id_piano integer;
identificativo_campione text;
piano_o_attivita text;
siglaprov text;
BEGIN
id_piano := -1;
id_motivazione := -1;

siglaprov := (select short_description from lookup_site_id where enabled and code = _id_asl);
num_verbale := (select nextval('public.barcode_osa_serial_id_seq')+1);
num_verbale := (select lpad(num_verbale, 6, '0'));
piano_o_attivita := (select split_part(_motivazione,'_',1));

raise info 'piano o attivita: %', piano_o_attivita;
if piano_o_attivita ='P' then -- si tratta di un piano
   id_motivazione = 89;
   id_piano = (select split_part(_motivazione,'_',2)::integer);
else -- si tratta di una attivita'
   id_motivazione = (select split_part(_motivazione,'_',2)::integer); 
end if;

id_analiti := (select array(select unnest(string_to_array(_id_analiti, ','))::integer));
raise info '%', id_analiti;
INSERT INTO ticket (alt_id, problem, site_id, ticketid, motivazione_campione,motivazione_piano_campione, assigned_date, enteredby, modifiedby, tipologia, sanzioni_penali, id_controllo_ufficiale)
            VALUES (_alt_id, concat_ws(' ',_note, _matricola),_id_asl,(select max(ticketid) +1 from ticket where ticketid <10000000), id_motivazione, id_piano,_data_prelievo::timestamp, _enteredby, _enteredby, 2, _id_laboratorio, _idcu::text) returning ticketid into idcampione;

identificativo_campione = concat(siglaprov, _idcu::text,idcampione::text);

INSERT INTO barcode_osa(org_id,id_campione,barcode,barcode_new, ticket_id) VALUES(-1, idcampione, num_verbale, concat(num_verbale,_id_asl::text), _idcu);

update ticket set identificativo = identificativo_campione, location=num_verbale, location_new=concat(num_verbale,'-',_id_asl::text) where ticketid = idcampione;

insert into matrici_campioni (id_campione,id_matrice,cammino) values(idcampione,_id_matrice, 
							  (SELECT mat.nome from matrici mat where mat.matrice_id = _id_matrice));


foreach  elem in array id_analiti
loop
   raise info '%',elem;
   insert into analiti_campioni (id_campione,analiti_id,cammino) values(idcampione,elem, (select nome from analiti where analiti_id = elem and enabled));
end loop;



RETURN idcampione;

END;
$BODY$;



 


CREATE OR REPLACE FUNCTION public.get_nominativi_by_qualifica_macelli(
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
	where ac.role_id = _id_qualifica and ac.username not ilike '%_cni%'
	order by 2;
else 
	raise info 'do nothing';
END IF;
 END;
$BODY$;

ALTER FUNCTION public.get_nominativi_by_qualifica_macelli(integer, integer, integer)
    OWNER TO postgres;

   -- FUNCTION: public.get_qualifiche_ac(integer)

-- DROP FUNCTION IF EXISTS public.get_qualifiche_ac(integer);

CREATE OR REPLACE FUNCTION public.get_qualifiche_macelli(
	_anno integer)
    RETURNS TABLE(id integer, nome text, gruppo boolean, view_lista_componenti boolean, livello integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
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

ALTER FUNCTION public.get_qualifiche_macelli(integer)
    OWNER TO postgres;

alter table m_vpm_campioni_new add column tipo_motivo text;
