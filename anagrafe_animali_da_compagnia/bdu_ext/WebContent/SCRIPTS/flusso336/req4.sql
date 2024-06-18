--GISA
  
 --Modifiche per gestione campi nuovi Sinac - Modifiche obsolete
 drop function  public.get_valori_anagrafica( integer);
CREATE OR REPLACE FUNCTION public.get_valori_anagrafica(_altid integer)
 RETURNS TABLE(ragione_sociale_impresa text, partita_iva_impresa text, codice_fiscale_impresa text, tipo_impresa text, email_impresa text, telefono_impresa text, nome_rapp_legale text, cognome_rapp_legale text, sesso_rapp_legale text, nazione_nascita_rapp_legale text, "comune_nascita_rapp_legaleLabel" text, comune_nascita_estero_rapp_legale text, data_nascita_rapp_legale text, cf_rapp_legale text, email_rapp_legale text, telefono_rapp_legale text, nazione_residenza_rapp_legale text, provincia_residenza_rapp_legale text, comune_residenza_rapp_legale text, comune_residenza_estero_rapp_legale text, toponimo_residenza_rapp_legale text, via_residenza_rapp_legale text, civico_residenza_rapp_legale text, cap_residenza_rapp_legale text, nazione_sede_legale text, provincia_sede_legale text, comune_sede_legale text, comune_estero_sede_legale text, toponimo_sede_legale text, via_sede_legale text, civico_sede_legale text, cap_sede_legale text, nazione_stabilimento text, provincia_stabilimento text, comune_stabilimento text, toponimo_stabilimento text, via_stabilimento text, civico_stabilimento text, cap_stabilimento text, lat_stabilimento text, long_stabilimento text, numero_registrazione_stabilimento text, asl_stabilimento text, presenza_cani text, presenza_gatti text, capacita_struttura_mq text, presenza_altre_specie text, documento_identita text, note_stabilimento text, lat_sede_legale text, long_sede_legale text)
 LANGUAGE plpgsql
 STRICT
AS $function$
DECLARE
r RECORD;	
BEGIN
FOR 

ragione_sociale_impresa  ,
partita_iva_impresa  ,
codice_fiscale_impresa  ,
tipo_impresa  ,
email_impresa  ,
telefono_impresa  ,
nome_rapp_legale  ,
cognome_rapp_legale  ,
sesso_rapp_legale  ,
nazione_nascita_rapp_legale  ,
"comune_nascita_rapp_legaleLabel"  ,
comune_nascita_estero_rapp_legale,
data_nascita_rapp_legale  ,
cf_rapp_legale  ,
email_rapp_legale  ,
telefono_rapp_legale  ,
nazione_residenza_rapp_legale  ,
provincia_residenza_rapp_legale  ,
comune_residenza_rapp_legale  ,
comune_residenza_estero_rapp_legale,
toponimo_residenza_rapp_legale  ,
via_residenza_rapp_legale  ,
civico_residenza_rapp_legale  ,
cap_residenza_rapp_legale  ,
nazione_sede_legale  ,
provincia_sede_legale  ,
comune_sede_legale  ,
comune_estero_sede_legale,
toponimo_sede_legale  ,
via_sede_legale  ,
civico_sede_legale  ,
cap_sede_legale  ,
nazione_stabilimento  ,
provincia_stabilimento  ,
comune_stabilimento  ,
toponimo_stabilimento  ,
via_stabilimento  ,
civico_stabilimento  ,
cap_stabilimento  ,
lat_stabilimento  ,
long_stabilimento,
numero_registrazione_stabilimento,
asl_stabilimento,
presenza_cani,
presenza_gatti,
capacita_struttura_mq,
presenza_altre_specie,
documento_identita, 
note_stabilimento,
lat_sede_legale, 
long_sede_legale
in
select distinct
replace(o.ragione_sociale, 'è', 'e''') as ragione_sociale_impresa,
o.partita_iva as partita_iva_impresa,
o.codice_fiscale_impresa as codice_fiscale_impresa,
--lti.description as tipo_impresa,
case 
	when length(lti.description) > 0 then lti.description
	when o.tipo_impresa = 1 then 'IMPRESA INDIVIDUALE'
	else (select description from lookup_tipo_impresa_societa where code=o.tipo_impresa)
end as tipo_impresa,
o.domicilio_digitale as email_impresa,
'' as telefono_impresa,
CASE WHEN ml8.codice ilike 'VET-AMBV-PU' or ml8.codice ilike 'VET-CLIV-PU' or ml8.codice ilike 'VET-OSPV-PU' 
	THEN concat('DIRETTORE GENERALE ASL ', ls.description) 
	ELSE sogg.nome 
	END as nome_rapp_legale,
sogg.cognome as cognome_rapp_legale,
sogg.sesso as sesso_rapp_legale,
CASE WHEN sogg.provenienza_estera THEN naz.description ELSE 'ITALIA' END as nazione_nascita_rapp_legale,
sogg.comune_nascita as "comune_nascita_rapp_legaleLabel",
CASE WHEN sogg.provenienza_estera THEN sogg.comune_nascita ELSE '' END as comune_nascita_estero_rapp_legale,
to_char(sogg.data_nascita, 'dd/MM/yyyy') as data_nascita_rapp_legale,
sogg.codice_fiscale as cf_rapp_legale,
sogg.email as email_rapp_legale,
sogg.telefono as telefono_rapp_legale,

soggind.nazione as nazione_residenza_rapp_legale,
CASE WHEN soggind.nazione ilike 'ITALIA' then soggprov.description else '' end as provincia_residenza_rapp_legale,
case when soggind.comune > 0 and soggind.nazione ilike 'ITALIA' then soggcom.nome else soggind.comune_testo end as comune_residenza_rapp_legale,
case when soggind.nazione ilike 'ITALIA' then '' else soggind.comune_testo end as comune_residenza_estero_rapp_legale,
CASE WHEN soggind.nazione ilike 'ITALIA' then soggtop.description else '' end as toponimo_residenza_rapp_legale,
CASE WHEN soggind.nazione ilike 'ITALIA' then soggind.via else '' end as via_residenza_rapp_legale,
CASE WHEN soggind.nazione ilike 'ITALIA' then soggind.civico else '' end as civico_residenza_rapp_legale,
CASE WHEN soggind.nazione ilike 'ITALIA' then soggind.cap else '' end as cap_residenza_rapp_legale,

opind.nazione as nazione_sede_legale,
CASE WHEN opind.nazione ilike 'ITALIA' then opprov.description else '' end as provincia_sede_legale,
case when opind.comune > 0 and opind.nazione ilike 'ITALIA' then opcom.nome else opind.comune_testo end as comune_sede_legale,
case when opind.nazione ilike 'ITALIA' then '' else opind.comune_testo end as comune_estero_sede_legale,
CASE WHEN opind.nazione ilike 'ITALIA' then optop.description else '' end as toponimo_sede_legale,
CASE WHEN opind.nazione ilike 'ITALIA' then opind.via else '' end as via_sede_legale,
CASE WHEN opind.nazione ilike 'ITALIA' then opind.civico else '' end as civico_sede_legale,
CASE WHEN opind.nazione ilike 'ITALIA' then opind.cap else '' end as cap_sede_legale,

stabind.nazione as  nazione_stabilimento,
stabprov.description as provincia_stabilimento,
stabcom.nome as comune_stabilimento,
stabtop.description as toponimo_stabilimento,
stabind.via as via_stabilimento,
stabind.civico as civico_stabilimento,
stabind.cap as cap_stabilimento,
stabind.latitudine as lat_stabilimento,
stabind.longitudine as long_stabilimento,
s.numero_registrazione,
ls.description as asl_stabilimento,
case when aads.flag_presenza_cani = true then 'SI' else 'NO' end as presenza_cani ,
case when aads.flag_presenza_gatti = true then 'SI' else 'NO' end as presenza_gatti ,
aads.capacita_struttura_mq as capacita_struttura_mq,
case when aads.flag_presenza_altre_specie = true then 'SI' else 'NO' end as presenza_altre_specie ,
sogg.documento_identita as documento_identita, 
s.note as note_stabilimento,
opind.latitudine as lat_sede_legale, 
opind.longitudine as long_sede_legale

from opu_stabilimento s
join opu_operatore o on o.id = s.id_operatore and o.trashed_date is null
join opu_rel_operatore_soggetto_fisico relosf on relosf.id_operatore = o.id and relosf.enabled and relosf.data_fine is null
left join opu_soggetto_fisico sogg on sogg.id = relosf.id_soggetto_fisico --and sogg.trashed_date is null
join opu_indirizzo stabind on stabind.id = s.id_indirizzo
left join opu_indirizzo opind on opind.id = o.id_indirizzo
left join opu_indirizzo soggind on soggind.id = sogg.indirizzo_id
join opu_relazione_stabilimento_linee_produttive rel on rel.id_stabilimento = s.id and rel.enabled
left join struttura_detenzione_dati_sinaaf aads on rel.id = aads.id_rel_stab 
join ml8_linee_attivita_nuove_materializzata ml8 on rel.id_linea_produttiva = ml8.id_nuova_linea_attivita

left join lookup_tipo_impresa_societa lti on lti.code = o.tipo_societa

left join lookup_province soggprov on soggprov.code::text = soggind.provincia
left join comuni1 soggcom on soggcom.id = soggind.comune
left join lookup_toponimi soggtop on soggtop.code = soggind.toponimo

left join lookup_province opprov on opprov.code::text = opind.provincia
left join comuni1 opcom on opcom.id = opind.comune
left join lookup_toponimi optop on optop.code = opind.toponimo

left join lookup_province stabprov on stabprov.code::text = stabind.provincia
left join comuni1 stabcom on stabcom.id = stabind.comune
left join lookup_toponimi stabtop on stabtop.code = stabind.toponimo

left join lookup_nazioni naz on naz.code = sogg.id_nazione_nascita
left join lookup_site_id ls on s.id_asl = ls.code

where s.alt_id = _altid

    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$function$
;


drop table struttura_detenzione_dati_sinaaf;

CREATE TABLE struttura_detenzione_dati_sinaaf (
	id serial4 NOT NULL,
	id_rel_stab int4 NOT NULL,
	flag_presenza_cani boolean NULL,
	flag_presenza_gatti boolean NULL,
	capacita_struttura_mq varchar NUll,
	flag_presenza_altre_specie boolean NULL
);



--obsoleta
CREATE OR REPLACE FUNCTION public.insert_gestione_anagrafica(campi_fissi hstore, campi_estesi hstore, utente_in integer, id_tipo_pratica_in integer, numero_pratica_in text, id_comune_in integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE 

	_id_indirizzo_sede_legale integer;
	_id_indirizzo_stabilimento integer;
	_id_indirizzo_sogg_fis integer;
	_id_sogg_fis integer;
	_id_operatore integer;
	_id_stabilimento integer;
	_comune_nascita_testo text;
	_data_inizio text;
	_data_fine text;
	_num_riconoscimento text;
	_tipo_carattere text;
	r integer;
	_id_suap_operatore integer;
	_id_suap_stabilimento integer;
	_alt_id_suap_stabilimento integer;
	_id_suap_sogg_fis integer;
	_n_categorizzabili integer;
	_categoria_rischio_default integer;
	_numero_registrazione_osa text;
	_alt_id integer;
	_id_evento integer;
	_id_pratica integer;
	_tipo_attivita integer; --Modifica: aggiunto campo
	_id_linea text; --Modifica: aggiunto campo
	_stato_linea integer;
	_id_linea_attivita_ml text;
	_id_rel_stab_lp integer;
        
BEGIN	

_n_categorizzabili := -1;
_id_indirizzo_stabilimento := -1;
_id_indirizzo_sede_legale := -1;

--fare le assegnazioni alla variabili dichiarate sopra sia nel caso di dati recuperati che di nuovo inserimento

	_tipo_attivita := -1;
	IF (campi_fissi ->'tipo_linee_attivita' is not null and length(trim(campi_fissi ->'tipo_linee_attivita')) <> 0) THEN	--Modifica: aggiunto recupero tipo impresa
		_tipo_attivita := (campi_fissi -> 'tipo_linee_attivita')::integer;
        end if;
		
	IF (length(trim(campi_fissi ->'id_impresa_recuperata')) <> 0) THEN	
		_id_operatore := (campi_fissi -> 'id_impresa_recuperata')::integer;
		--update opu_operatore
		update opu_operatore 
			set codice_fiscale_impresa = campi_fissi -> 'codice_fiscale', partita_iva = campi_fissi -> 'partita_iva',
			    ragione_sociale = campi_fissi -> 'ragione_sociale', domicilio_digitale = campi_fissi -> 'email_impresa',
			    tipo_societa = (campi_fissi -> 'tipo_impresa')::integer 
			where id = _id_operatore;
			
		IF (length(trim(campi_fissi ->'via_sede_legale')) <> 0 OR (campi_fissi -> 'nazione_sede_legale')::integer <> 106) THEN
			--inserisci indirizzo impresa
			_id_indirizzo_sede_legale := insert_opu_noscia_indirizzo((campi_fissi -> 'nazione_sede_legale')::integer, campi_fissi -> 'cod_provincia_sede_legale',
								       (campi_fissi -> 'cod_comune_sede_legale')::integer, campi_fissi -> 'comune_estero_sede_legale', 
								       (campi_fissi -> 'toponimo_sede_legale')::integer, campi_fissi -> 'via_sede_legale', campi_fissi -> 'cap_leg', campi_fissi -> 'civico_sede_legale',
								       (campi_fissi -> 'latitudine_leg')::double precision, (campi_fissi -> 'longitudine_leg')::double precision,
								       campi_fissi -> 'presso_sede_legale');
			--update id indirizzo impresa
			update opu_operatore set id_indirizzo = _id_indirizzo_sede_legale where id = _id_operatore;
			
		END IF;

		IF (length(trim(campi_fissi ->'id_rapp_legale_recuperato')) <> 0) THEN
			_id_sogg_fis := (campi_fissi -> 'id_rapp_legale_recuperato')::integer;
			--update opu_soggetto_fisico
			--gestione nel caso di provenienza estera
			IF (campi_fissi -> 'nazione_nascita_rapp_leg') = '106' THEN
				select nome into _comune_nascita_testo from comuni1 where id = (campi_fissi -> 'comune_nascita_rapp_leg')::integer limit 1;
				update opu_soggetto_fisico 
					set cognome = campi_fissi -> 'cognome_rapp_leg', nome = campi_fissi -> 'nome_rapp_leg',
					    comune_nascita = _comune_nascita_testo, codice_fiscale = campi_fissi -> 'codice_fiscale_rappresentante',
					    sesso = campi_fissi -> 'sesso_rapp_leg', telefono = campi_fissi -> 'telefono_rapp_leg',
					    email = campi_fissi -> 'email_rapp_leg', data_nascita = (campi_fissi -> 'data_nascita_rapp_leg')::timestamp without time zone, 
					    provenienza_estera = false, id_nazione_nascita = (campi_fissi -> 'nazione_nascita_rapp_leg')::integer, 
					    id_comune_nascita = (campi_fissi -> 'comune_nascita_rapp_leg')::integer
				        where id = _id_sogg_fis;
			ELSIF (length(trim(campi_fissi ->'nazione_nascita_rapp_leg')) <> 0) THEN
				update opu_soggetto_fisico 
					set cognome = campi_fissi -> 'cognome_rapp_leg', nome = campi_fissi -> 'nome_rapp_leg',
					    comune_nascita = campi_fissi -> 'comune_nascita_rapp_leg', codice_fiscale = campi_fissi -> 'codice_fiscale_rappresentante',
					    sesso = campi_fissi -> 'sesso_rapp_leg', telefono = campi_fissi -> 'telefono_rapp_leg',
					    email = campi_fissi -> 'email_rapp_leg', data_nascita = (campi_fissi -> 'data_nascita_rapp_leg')::timestamp without time zone, 
					    provenienza_estera = true, id_nazione_nascita = (campi_fissi -> 'nazione_nascita_rapp_leg')::integer
				        where id = _id_sogg_fis;
				
			END IF;
			IF (length(trim(campi_fissi -> 'documento_identita')) <> 0) THEN
				update opu_soggetto_fisico set documento_identita = campi_fissi -> 'documento_identita' where id = _id_sogg_fis;
			END IF;
				    
			IF (length(trim(campi_fissi ->'via_soggfis')) <> 0 OR (campi_fissi -> 'nazione_soggfis')::integer <> 106) THEN
				--insert indirizzo soggetto fisico
				_id_indirizzo_sogg_fis := insert_opu_noscia_indirizzo((campi_fissi -> 'nazione_soggfis')::integer, campi_fissi -> 'cod_provincia_soggfis',
								       (campi_fissi -> 'cod_comune_soggfis')::integer, campi_fissi -> 'comune_residenza_estero_soggfis',
								       (campi_fissi -> 'toponimo_soggfis')::integer, campi_fissi -> 'via_soggfis', campi_fissi -> 'cap_soggfis', campi_fissi -> 'civico_soggfis',
								       (campi_fissi -> 'latitudine_soggfis')::double precision, (campi_fissi -> 'longitudine_soggfis')::double precision,
								       campi_fissi -> 'presso_soggfis');
				--update id indirizzo soggetto fisico
				update opu_soggetto_fisico set indirizzo_id = _id_indirizzo_sogg_fis where id = _id_sogg_fis;
			END IF;
		ELSE
			--inserisci indirizzo soggetto fisico
			IF (length(trim(campi_fissi ->'via_soggfis')) <> 0 OR (campi_fissi -> 'nazione_soggfis')::integer <> 106) THEN
				_id_indirizzo_sogg_fis := insert_opu_noscia_indirizzo((campi_fissi -> 'nazione_soggfis')::integer, campi_fissi -> 'cod_provincia_soggfis',
									       (campi_fissi -> 'cod_comune_soggfis')::integer, campi_fissi -> 'comune_residenza_estero_soggfis',
									       (campi_fissi -> 'toponimo_soggfis')::integer, campi_fissi -> 'via_soggfis', campi_fissi -> 'cap_soggfis', campi_fissi -> 'civico_soggfis',
									       (campi_fissi -> 'latitudine_soggfis')::double precision, (campi_fissi -> 'longitudine_soggfis')::double precision,
									       campi_fissi -> 'presso_soggfis');
		        END IF;
			--inserisci soggetto fisico
			IF (length(trim(campi_fissi ->'codice_fiscale_rappresentante')) <> 0 OR (campi_fissi -> 'nazione_nascita_rapp_leg')::integer <> 106) THEN
				_id_sogg_fis := insert_opu_noscia_soggetto_fisico(campi_fissi -> 'nome_rapp_leg', campi_fissi -> 'cognome_rapp_leg', (campi_fissi -> 'nazione_nascita_rapp_leg')::integer,
									  campi_fissi -> 'codice_fiscale_rappresentante', campi_fissi -> 'sesso_rapp_leg', utente_in, 
									  campi_fissi -> 'telefono_rapp_leg', campi_fissi -> 'email_rapp_leg', _id_indirizzo_sogg_fis,
									  campi_fissi -> 'comune_nascita_rapp_leg', (campi_fissi -> 'data_nascita_rapp_leg')::timestamp without time zone,
									  campi_fissi -> 'documento_identita');
		        END IF;
			--inserisci relazione operatore-soggettofisico
			--inserimento relazione opu_rel_operatore_soggetto_fisico
			IF _id_sogg_fis is not null AND _id_operatore is not null THEN
				perform insert_opu_noscia_rel_impresa_soggfis(_id_sogg_fis, _id_operatore);
			END IF;
		END IF;
	ELSE
		--inserisciti impresa e soggetto fisico ex novo (indirizzi compresi)
		--inserimento indirizzo soggetto fisico/rapp legale
		IF (length(trim(campi_fissi ->'via_soggfis')) <> 0 OR (campi_fissi -> 'nazione_soggfis')::integer <> 106) THEN
			_id_indirizzo_sogg_fis := insert_opu_noscia_indirizzo((campi_fissi -> 'nazione_soggfis')::integer, campi_fissi -> 'cod_provincia_soggfis',
									       (campi_fissi -> 'cod_comune_soggfis')::integer, campi_fissi -> 'comune_residenza_estero_soggfis',
									       (campi_fissi -> 'toponimo_soggfis')::integer, campi_fissi -> 'via_soggfis', campi_fissi -> 'cap_soggfis', campi_fissi -> 'civico_soggfis',
									       (campi_fissi -> 'latitudine_soggfis')::double precision, (campi_fissi -> 'longitudine_soggfis')::double precision,
									       campi_fissi -> 'presso_soggfis');
		END IF;

		--inserimento indirizzo sede legale/impresa
		IF (length(trim(campi_fissi ->'via_sede_legale')) <> 0 OR (campi_fissi -> 'nazione_sede_legale')::integer <> 106) THEN
			_id_indirizzo_sede_legale := insert_opu_noscia_indirizzo((campi_fissi -> 'nazione_sede_legale')::integer, campi_fissi -> 'cod_provincia_sede_legale',
									       (campi_fissi -> 'cod_comune_sede_legale')::integer, campi_fissi -> 'comune_estero_sede_legale', 
									       (campi_fissi -> 'toponimo_sede_legale')::integer, campi_fissi -> 'via_sede_legale', campi_fissi -> 'cap_leg', campi_fissi -> 'civico_sede_legale',
									       (campi_fissi -> 'latitudine_leg')::double precision, (campi_fissi -> 'longitudine_leg')::double precision,
									       campi_fissi -> 'presso_sede_legale');
		END IF;

		--inserimento soggetto fisico/rapp legale		
		_id_sogg_fis := insert_opu_noscia_soggetto_fisico(campi_fissi -> 'nome_rapp_leg', campi_fissi -> 'cognome_rapp_leg', (campi_fissi -> 'nazione_nascita_rapp_leg')::integer,
								  campi_fissi -> 'codice_fiscale_rappresentante', campi_fissi -> 'sesso_rapp_leg', utente_in, 
								  campi_fissi -> 'telefono_rapp_leg', campi_fissi -> 'email_rapp_leg', _id_indirizzo_sogg_fis,
								  campi_fissi -> 'comune_nascita_rapp_leg', (campi_fissi -> 'data_nascita_rapp_leg')::timestamp without time zone,
								  campi_fissi -> 'documento_identita');


		--inserimento impresa/ operatore
		_id_operatore := insert_opu_noscia_impresa(campi_fissi -> 'codice_fiscale', campi_fissi -> 'partita_iva', campi_fissi -> 'ragione_sociale',
							   utente_in, campi_fissi -> 'email_impresa', (campi_fissi -> 'tipo_impresa')::integer, _id_indirizzo_sede_legale);

		--inserimento relazione opu_rel_operatore_soggetto_fisico
		IF _id_sogg_fis is not null AND _id_operatore is not null THEN
			perform insert_opu_noscia_rel_impresa_soggfis(_id_sogg_fis, _id_operatore);
		END IF;
	END IF;

	--gestione stabilimento
	--inserimento indirizzo stabilimento
	--_id_indirizzo_stabilimento := _id_indirizzo_sede_legale;
	IF (length(trim(campi_fissi ->'via_stab')) <> 0) THEN
		_id_indirizzo_stabilimento := insert_opu_noscia_indirizzo(106, campi_fissi -> 'cod_provincia_stab',
								       (campi_fissi -> 'cod_comune_stab')::integer, null, (campi_fissi -> 'toponimo_stab')::integer,
								       campi_fissi -> 'via_stab', campi_fissi -> 'cap_stab', campi_fissi -> 'civico_stab',
								       (campi_fissi -> 'latitudine_stab')::double precision, (campi_fissi -> 'longitudine_stab')::double precision,
								       campi_fissi -> 'presso_stab');
	END IF;
	
	--inserisci stabilimento e recupero id stabilimento inserito
	--IF _id_indirizzo_stabilimento = _id_indirizzo_sede_legale THEN
	IF _id_indirizzo_stabilimento <= 0 THEN
		_numero_registrazione_osa := genera_numero_registrazione_da_comune((campi_fissi -> 'cod_comune_sede_legale')::integer);
	ELSE 
		_numero_registrazione_osa := genera_numero_registrazione_da_comune((campi_fissi -> 'cod_comune_stab')::integer);
	END IF;

	_stato_linea := campi_fissi -> concat('lineaattivita_0_stato');
	if(_stato_linea is null) then 
		_stato_linea := 0 ;
	end if;
	
	
	IF _id_indirizzo_stabilimento is not null THEN
		SELECT distinct(split_part(key,'_',2)) into r FROM each(campi_fissi) where key ilike '%lineaattivita_%' || '%_id_linea_attivita_ml%' limit 1;
		_id_linea_attivita_ml := campi_fissi -> concat('lineaattivita_', r,'_id_linea_attivita_ml');
		_id_stabilimento := insert_opu_noscia_stabilimento(_id_operatore, _id_indirizzo_stabilimento, utente_in, _id_linea_attivita_ml, _numero_registrazione_osa, _tipo_attivita, _stato_linea); --Modifica: aggiunto tipo_attivita
		update opu_stabilimento set note = campi_fissi -> 'note_stabilimento' where id = _id_stabilimento;  
	END IF;

	--IF _id_indirizzo_stabilimento = _id_indirizzo_sede_legale THEN
	IF _id_indirizzo_stabilimento <= 0 THEN
		update opu_stabilimento set id_asl = (select codiceistatasl::integer from comuni1 where id = (campi_fissi -> 'cod_comune_sede_legale')::integer) where id = _id_stabilimento;
	END IF;


	--inserimento relazione stabilimento linea di attivita
	FOR r IN SELECT distinct(split_part(key,'_',2)) FROM each(campi_fissi) where key ilike '%lineaattivita_%'
	    LOOP
	        _id_linea := coalesce(campi_fissi -> concat('lineaattivita_', r,'_id_linea_attivita_ml'), campi_fissi -> concat('idLineaVecchiaMasterlist', r)); --Modifica: aggiunta recupero id_linea
		_id_linea := coalesce(_id_linea, '-1');
		_data_inizio := campi_fissi -> concat('lineaattivita_', r,'_data_inizio_attivita');
		_data_fine := campi_fissi -> concat('lineaattivita_', r,'_data_fine_attivita');
		_num_riconoscimento := campi_fissi -> concat('lineaattivita_', r,'_num_riconoscimento');
		_tipo_carattere := campi_fissi -> concat('lineaattivita_', r,'_tipo_carattere_attivita');
		if(length(trim(campi_fissi -> concat('lineaattivita_', r,'_stato')))<>0) then
			_stato_linea := campi_fissi -> concat('lineaattivita_', r,'_stato');
		else
			_stato_linea := 0;
		end if;
		
		IF (_id_stabilimento is not null AND _id_linea::integer >0) THEN
			_id_rel_stab_lp := insert_opu_noscia_rel_stabilimento_linea(_id_stabilimento, '', _num_riconoscimento, utente_in, 
									_data_inizio::timestamp without time zone, _data_fine::timestamp without time zone,
									_tipo_carattere::integer,
									_id_linea::integer, --Modifica aggiunta linea
									_stato_linea );


		insert into struttura_detenzione_dati_sinaaf(id_rel_stab ,flag_presenza_cani,flag_presenza_gatti,capacita_struttura_mq,flag_presenza_altre_specie) values(_id_rel_stab_lp, 
		(case when (campi_fissi -> 'presenza_cani')::text = 'on' then true else false end),
		(case when (campi_fissi -> 'presenza_gatti')::text = 'on' then true else false end),
		(campi_fissi -> 'capacita_struttura_mq')::text,
		(case when (campi_fissi -> 'presenza_altre_specie')::text = 'on' then true else false end)
		);	
		
		END IF;	
	    END LOOP;

	IF (_id_stabilimento is not null) THEN
		update opu_stabilimento set data_inizio_attivita = (select min(data_inizio) from opu_relazione_stabilimento_linee_produttive where id_stabilimento = _id_stabilimento and enabled) where id = _id_stabilimento;    
	END IF; 

	select count(ml8.*), max(categoria_rischio_default) into _n_categorizzabili, _categoria_rischio_default 
		from opu_relazione_stabilimento_linee_produttive rel join ml8_linee_attivita_nuove_materializzata ml8 on ml8.id_nuova_linea_attivita = rel.id_linea_produttiva 
			left join master_list_flag_linee_attivita flag on flag.id_linea = ml8.id_nuova_linea_attivita
		where flag.categorizzabili and rel.enabled and rel.id_stabilimento = _id_stabilimento;

	IF (_n_categorizzabili > 0 and id_tipo_pratica_in <> 16) THEN
	   update opu_stabilimento set categoria_rischio = COALESCE(_categoria_rischio_default, 3) where id = _id_stabilimento;
	END IF;
	

	perform refresh_anagrafica(_id_stabilimento, 'opu');

	raise WARNING 'id finali: id stab %, id operatore %, id sogg fis %s, id indi stab %, id ind impresa %s, id ind sogg fis %', 
			_id_stabilimento, _id_operatore, _id_sogg_fis, _id_indirizzo_stabilimento, _id_indirizzo_sede_legale, _id_indirizzo_sogg_fis;



--gestione eventi - pratiche
select alt_id into _alt_id from opu_stabilimento where id = _id_stabilimento;

--inserisci dati evento
insert into eventi_su_osa(id_stabilimento, alt_id, id_tipo_operazione, entered, enteredby)
values(_id_stabilimento, _alt_id, id_tipo_pratica_in, now(), utente_in)  returning id into _id_evento;

--se non e una pratica suap prima inserisce la pratica
IF (campi_fissi -> 'id_causale') <> '1' THEN

	--inserisci pratica non suap
	IF _id_indirizzo_stabilimento <= 0 THEN
		select comune into id_comune_in from opu_indirizzo where id = _id_indirizzo_sede_legale;
	ELSE
		select comune into id_comune_in from opu_indirizzo where id = _id_indirizzo_stabilimento;
	END IF;
	id_comune_in := coalesce(id_comune_in, -1);
	
	numero_pratica_in := '';
	IF (campi_fissi -> 'id_causale') = '2' THEN
		numero_pratica_in := campi_fissi -> 'numero_pratica';
	END IF;
	select inserisci_pratica into numero_pratica_in from inserisci_pratica(utente_in, campi_fissi -> 'data_pratica', id_comune_in, id_tipo_pratica_in, numero_pratica_in, (campi_fissi -> 'id_causale')::integer, campi_fissi -> 'nota_pratica');
		
END IF;

--recupero id pratica
select id into _id_pratica from pratiche_gins 
	where numero_pratica ilike numero_pratica_in and id_comune_richiedente = id_comune_in and id_causale = (campi_fissi -> 'id_causale')::integer and trashed_date is null;

--inserisci dati relazione pratica evento
insert into rel_eventi_pratiche(id_evento,id_pratica,entered,enteredby)
values(_id_evento, _id_pratica, now(), utente_in);

return _id_stabilimento;
	
END;
$function$
;



insert into configuratore_template_no_scia (id, html_label,html_enabled,html_ordine,html_type,html_name,mapping_field) values ((select max(id) + 1 from configuratore_template_no_scia),'Presenza cani?',true,'dm','checkbox','presenza_cani','presenza_cani');

insert into schema_anagrafica(id,codice_univoco_ml,id_gruppo_template,id_campo_configuratore,campo_esteso,enabled) values ((select max(id) + 1 from schema_anagrafica),'ASSANIM-ASSANIM-ASSANIM',4,607,false,true);

insert into schema_anagrafica(id,codice_univoco_ml,id_gruppo_template,id_campo_configuratore,campo_esteso,enabled) values ((select max(id) + 1 from schema_anagrafica),'ASSANIM-ASSANIM-ASSANIM',4,609,false,true);
insert into schema_anagrafica(id,codice_univoco_ml,id_gruppo_template,id_campo_configuratore,campo_esteso,enabled) values ((select max(id) + 1 from schema_anagrafica),'ASSANIM-ASSANIM-ASSANIM',4,608,false,true);
insert into schema_anagrafica(id,codice_univoco_ml,id_gruppo_template,id_campo_configuratore,campo_esteso,enabled) values ((select max(id) + 1 from schema_anagrafica),'ASSANIM-ASSANIM-ASSANIM',4,610,false,true);





INSERT INTO public.configuratore_template_no_scia
(id, html_label, html_enabled, sql_campo, sql_origine, sql_condizione, html_ordine, html_type, sql_campo_lookup, sql_origine_lookup, sql_condizione_lookup, html_name, mapping_field, oid_parent, html_style, html_event)
VALUES(610, 'Presenza animali altre specie?', true, NULL, NULL, NULL, 'dp', 'select', 'code,description', '(SELECT ''on''::text AS code,''SI''::text AS description UNION SELECT  ''off''::text AS code ,''NO''::text AS description) tab', '1=1', 'presenza_altre_specie', '_b_presenza_altre_specie', NULL, 'required="true"', NULL);
INSERT INTO public.configuratore_template_no_scia
(id, html_label, html_enabled, sql_campo, sql_origine, sql_condizione, html_ordine, html_type, sql_campo_lookup, sql_origine_lookup, sql_condizione_lookup, html_name, mapping_field, oid_parent, html_style, html_event)
VALUES(609, 'Capacita'' della struttura (mq)', true, NULL, NULL, NULL, 'dm', 'number', NULL, NULL, NULL, 'capacita_struttura_mq', '_b_capacita_struttura_mq', NULL, 'required="true"', NULL);
INSERT INTO public.configuratore_template_no_scia
(id, html_label, html_enabled, sql_campo, sql_origine, sql_condizione, html_ordine, html_type, sql_campo_lookup, sql_origine_lookup, sql_condizione_lookup, html_name, mapping_field, oid_parent, html_style, html_event)
VALUES(608, 'Presenza gatti?', true, NULL, NULL, NULL, 'dm', 'select', 'code,description', '(SELECT ''on''::text AS code,''SI''::text AS description UNION SELECT  ''off''::text AS code ,''NO''::text AS description) tab', '1=1', 'presenza_gatti', '_b_presenza_gatti', NULL, 'required="true"', NULL);
INSERT INTO public.configuratore_template_no_scia
(id, html_label, html_enabled, sql_campo, sql_origine, sql_condizione, html_ordine, html_type, sql_campo_lookup, sql_origine_lookup, sql_condizione_lookup, html_name, mapping_field, oid_parent, html_style, html_event)
VALUES(607, 'Presenza cani?', true, NULL, NULL, NULL, 'dm', 'select', 'code,description', '(SELECT ''on''::text AS code,''SI''::text AS description UNION SELECT  ''off''::text AS code ,''NO''::text AS description) tab', '1=1', 'presenza_cani', '_b_presenza_cani', NULL, 'required="true"', NULL);
--fine obsoleti

update master_list_flag_linee_attivita set incompatibilita = null where id = 1618;





  
  
--BDU
CREATE FOREIGN TABLE public.lookup_associazioni_animaliste (
	code int4 NULL,
	description text NULL,
	default_item bool NULL,
	"level" int4 NULL,
	asl int4 NULL,
	enabled bool NULL,
	entered timestamp NULL,
	modified timestamp NULL,
	partita_iva text NULL,
	indirizzo text NULL,
	id_specie int4 NULL,
	ragione_sociale text NULL
)
SERVER foreign_server_gisa
OPTIONS (schema_name 'public', table_name 'associazioni_view');
  
    CREATE TABLE public.opu_informazioni_privato (
	id_privato int4 NULL,
	id_associazione int4 NULL
);


--70   il code
insert into lookup_tipologia_registrazione(code,description,default_item,enabled,entered,modified,fuori_asl,effettuabile_con_animale_fuori_dominio_asl_da_asl_proprietaria,
effettuabile_con_animale_fuori_dominio_asl_da_asl_in_carico,effettuabile_con_animale_fuori_dominio_asl_da_asl_diversa, propagazione_sinaaf,enabled_estrazione
) values 
( 70, 'Adozione in affido temporaneo',true,true,current_timestamp,current_timestamp,false,true,true,false,true,true) returning code;


--104: Randagio/in affido temporaneo
insert into lookup_tipologia_stato(description,default_item,level,enabled,entered,modified,isgroup,title,randagio) 
values ('Randagio/in affido temporaneo', false,3,true,current_timestamp,current_timestamp,false,
'Cani randagi affidati temporaneamente a membri di associazioni animaliste, non sterilizzati e senza ulteriori registrazioni che ne potrebbero modificare lo stato', true) returning code;

--105: Randagio/sterilizzato/in affido temporaneo
insert into lookup_tipologia_stato(description,default_item,level,enabled,entered,modified,isgroup,title,randagio) 
values ('Randagio/sterilizzato/in affido temporaneo', false,3,true,current_timestamp,current_timestamp,false,
'Cani randagi affidati temporaneamente a membri di associazioni animaliste, sterilizzati e senza ulteriori registrazioni che ne potrebbero modificare lo stato', true) returning code;




insert into mapping_registrazioni_specie_animale (id_registrazione,id_specie) values (70,1);
insert into mapping_registrazioni_specie_animale (id_registrazione,id_specie) values (70,2);
insert into mapping_registrazioni_specie_animale (id_registrazione,id_specie) values (70,3);

select 'insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,' || id_registrazione ||',' || case when id_prossimo_stato = 3 then 89 else id_prossimo_stato end ||',' || only_hd||');' from registrazioni_wk where id_stato = 3
union
select 'insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,' || id_registrazione ||',' || case when id_prossimo_stato = 9 then 90 else id_prossimo_stato end ||',' || only_hd||');' from registrazioni_wk where id_stato = 9;

insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,23,36,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,54,90,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,45,90,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,19,20,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,68,90,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,22,90,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,48,89,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,48,90,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,40,61,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,38,89,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,23,37,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,54,89,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,19,19,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,11,15,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,41,89,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,36,90,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,68,89,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,32,48,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,6,89,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,9,40,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,13,19,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,56,90,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,41,90,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,40,59,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,61,20,true);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,38,90,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,4,16,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,53,79,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,31,90,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,32,49,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,22,89,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,45,89,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,2,9,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,31,89,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,46,72,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,61,19,true);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,21,90,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,9,41,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,67,8,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,6,90,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,11,14,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,53,80,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,36,89,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,21,89,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,56,89,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,46,71,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (104,13,20,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (103,67,2,false);




--delete from evento_html_fields where id_tipologia_evento = 70;

insert into evento_html_fields (id_tipologia_evento,nome_campo,tipo_campo,label_campo,javascript_function,javascript_function_evento,ordine_campo,valore_campo,tipo_controlli_date,label_campo_controlli_date,
only_hd,label_link,select_size,select_multiple,no_order) 
values (70,'idVecchioDetentore','hidden','',null,null,5,-1,null,null,0,null,1,false,false);

insert into evento_html_fields (id_tipologia_evento,nome_campo,tipo_campo,label_campo,javascript_function,javascript_function_evento,ordine_campo,valore_campo,tipo_controlli_date,label_campo_controlli_date,
only_hd,label_link,select_size,select_multiple,no_order) 
values (70,'idDetentore','hidden','',null,null,4,null,null,null,0,null,1,false,false);

insert into evento_html_fields (id_tipologia_evento,nome_campo,tipo_campo,label_campo,javascript_function,javascript_function_evento,ordine_campo,valore_campo,tipo_controlli_date,label_campo_controlli_date,
only_hd,label_link,select_size,select_multiple,no_order) 
values (70,'idDetentoreLink','link','Seleziona socio','popUp(''OperatoreAction.do?command=SearchForm&tipologiaSoggetto=2&popup=true&tipoRegistrazione=70&idLineaProduttiva1=1&socio=true'')','href',6
,null,null,null,0,'',1,false,false);

insert into evento_html_fields (id_tipologia_evento,nome_campo,tipo_campo,label_campo,javascript_function,javascript_function_evento,ordine_campo,valore_campo,tipo_controlli_date,label_campo_controlli_date,
only_hd,label_link,select_size,select_multiple,no_order) 
values (70,'dataAdozione','data','Data adozione','calenda(''dataAdozione'','''',''0'')',null,1
,null,'T2,T21,T25','Data adozione',0,null,1,false,false);

insert into evento_html_fields (id_tipologia_evento,nome_campo,tipo_campo,label_campo,javascript_function,javascript_function_evento,ordine_campo,valore_campo,tipo_controlli_date,label_campo_controlli_date,
only_hd,label_link,select_size,select_multiple,no_order) 
values (70,'nuovoDetentore','link','Inserisci nuovo socio','popUp(''OperatoreAction.do?command=Add&popup=true&tipologiaSoggetto=2&tipologiaRegistrazione=70&idLineaProduttiva=1&in_regione=si&socio=true'')',null,19
,null,null,null,0,'',1,false,false);

insert into evento_html_fields (id_tipologia_evento,nome_campo,tipo_campo,label_campo,javascript_function,javascript_function_evento,ordine_campo,valore_campo,tipo_controlli_date,label_campo_controlli_date,
only_hd,label_link,select_size,select_multiple,no_order) 
values (70,'nomeAnimale','text','Nome animale',null,null,20
,null,null,null,0,null,1,false,false);


CREATE SEQUENCE public.evento_adozione_affido_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 5047
  CACHE 1;
ALTER TABLE public.evento_adozione_affido_id_seq
  OWNER TO postgres;



CREATE TABLE public.evento_adozione_affido
(
  id integer NOT NULL DEFAULT nextval('evento_adozione_affido_id_seq'::regclass),
  id_evento integer NOT NULL,
  data_adozione timestamp without time zone,
  id_associazione integer,
  id_vecchio_detentore integer,
  id_asl_destinataria_adozione integer,
  id_detentore integer,
  CONSTRAINT evento_adozione_affido_pkey PRIMARY KEY (id),
  CONSTRAINT evento_adozione_da_canile_id_evento_fkey FOREIGN KEY (id_evento)
      REFERENCES public.evento (id_evento) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT evento_adozione_affido_id_detentore_fk FOREIGN KEY (id_detentore)
      REFERENCES public.opu_relazione_stabilimento_linee_produttive (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT evento_adozione_affido_id_vecchio_detentore_fkey FOREIGN KEY (id_vecchio_detentore)
      REFERENCES public.opu_relazione_stabilimento_linee_produttive (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.evento_adozione_affido
  OWNER TO postgres;


ALTER TABLE public.animale DROP CONSTRAINT congruenza_stati_flag_decesso;

ALTER TABLE public.animale
  ADD CONSTRAINT congruenza_stati_flag_decesso CHECK (stato = '-1'::integer OR 
  (flag_decesso = true AND (stato = ANY (ARRAY[102, 101, 39, 10, 11, 24, 40, 7, 38, 41, 45, 54, 73, 82, 83, 84, 85, 86, 87, 88, 89,90,  91, 92, 93, 94, 95, 96, 97, 98, 99, 100]))) OR 
  (flag_decesso = false AND (stato <> ALL (ARRAY[102, 101, 39, 10, 11, 24, 40, 7, 38, 41, 45, 54, 73, 82, 83, 84, 85, 86, 87, 88,89, 90
  ,  91, 92, 93, 94, 95, 96, 97, 98, 99, 100]))));


  
--SINAC

-- DROP FUNCTION public.sinaaf_trasferimento_animale_get_dati_envelope(integer);
CREATE OR REPLACE FUNCTION public.sinaaf_trasferimento_animale_get_dati_envelope(IN _idevento integer)
  RETURNS TABLE(eveid text, ubiid text, anmnome text, anmtatuaggio text, anmmicrochip text, evedtdenuncia text, evedtcomunicazione text, evedtverbale text, evenumverbale text, peridfiscale text, cancodice text, ubivar text, ubicodice text, ubiindirizzo text, ubicomistat text, ubiprosigla text, ubicap text, eveiscid text, tiucodice text, dtultimamodifica text) AS
$BODY$

 BEGIN
    
   RETURN QUERY     
 
    
select
'' as eveId,
case when e.id_tipologia_evento = 12 and (select id_detentore_dopo_ritrovamento<>id_detentore_old from evento_ritrovamento where id_evento = _idevento ) then e.id_sinaaf_secondario 
else e.id_sinaaf
end as ubiId,
coalesce(an.nome, '')::text as anmNome,
case
	when an.tatuaggio is not null and an.tatuaggio <> '' and length(an.tatuaggio) <> 15 then coalesce(tatuaggio, '')::text
	else ''
end as anmTatuaggio,
case
	when an.tatuaggio is not null and an.tatuaggio <> '' and length(an.tatuaggio) = 15 then coalesce(tatuaggio, '')::text
	else coalesce(an.microchip, '')::text
end as anmMicrochip,
case
when  e.id_tipologia_evento in(18,45,31,56,24,41,12,70) then coalesce(to_char(evt_cambio_det.data_cambio_detentore , 'dd-mm-yyyy'), '')::text 
else '' end as eveDtDenuncia,
case
when  e.id_tipologia_evento in(18,45,31,56,24,41,12,70) then coalesce(to_char(evt_cambio_det.data_cambio_detentore , 'dd-mm-yyyy'), '')::text  
else '' end as eveDtComunicazione,
'' as eveDtVerbale,
'' as eveNumVerbale,
case when l_det_evttra.id_linea_produttiva = 1 then coalesce(osf_det_evttra.codice_fiscale_fittizio_sinaaf, osf_det_evttra.codice_fiscale)::text  else '' end  as perIdFiscale,
case  when l_det_evttra.id_linea_produttiva in (4, 5,6,8) or evt_cambio_det.codice_struttura_fuori_reg is not null then coalesce(l_det_evttra.codice_sinaaf::text, evt_cambio_det.codice_struttura_fuori_reg::text) else '' end as canCodice,
'S' as ubiVar,
'003' as ubiCodice,
case 
	when evt_cambio_det.indirizzo_struttura_fuori_reg is not null then evt_cambio_det.indirizzo_struttura_fuori_reg
	else regexp_replace(public.unaccent(coalesce(oi_det_evttra.via,'') ),'[\°\\''\²\/]',' ','g')
end as ubiIndirizzo,
case 
     when evt_cambio_det.comune_struttura_fuori_reg is not null then evt_cambio_det.comune_struttura_fuori_reg
     when upper(prov_det_evttra.cod_provincia)::text = 'ES' then '000' 
     else c_det_evttra.cod_comune::text 
end as ubiComIstat,
case 
	when evt_cambio_det.provincia_struttura_fuori_reg is not null then evt_cambio_det.provincia_struttura_fuori_reg
	when upper(prov_det_evttra.cod_provincia)::text = 'ES' then 'EE' 
	else upper(prov_det_evttra.cod_provincia)::text 
end as ubiProSigla ,
case 
	when evt_cambio_det.cap_struttura_fuori_reg is not null then evt_cambio_det.cap_struttura_fuori_reg
	when oi_det_evttra.cap::text not ilike '%n.d%' then oi_det_evttra.cap::text else c_det_evttra.cap::text 
end as ubiCap ,
'' as eveIscId,
case when e.id_tipologia_evento = 45 then '010' when e.id_tipologia_evento = 70 then '002' else '008' end as tiuCodice,
coalesce(to_char(e.modified, 'dd-mm-yyyy'), '')::text as dtUltimaModifica
from  evento  e
join animale an on e.id_animale =an.id
join lookup_tipologia_registrazione t on t.code = e.id_tipologia_evento
LEFT join
(
select  id_evento ,ecd.data_cambio_detentore data_cambio_detentore ,ecd.id_detentore::TEXT id_nuovo_detentore,null as comune_struttura_fuori_reg, null as provincia_struttura_fuori_reg,null as cap_struttura_fuori_reg,null as indirizzo_struttura_fuori_reg, null as codice_struttura_fuori_reg from evento_cambio_detentore ecd   -- tipologia 18
union
select  id_evento ,adoz_affido.data_adozione data_cambio_detentore ,adoz_affido.id_detentore::TEXT id_nuovo_detentore,null as comune_struttura_fuori_reg, null as provincia_struttura_fuori_reg,null as cap_struttura_fuori_reg,null as indirizzo_struttura_fuori_reg, null as codice_struttura_fuori_reg from evento_adozione_affido adoz_affido   -- tipologia 70
union
select  id_evento ,erap.data_restituzione data_cambio_detentore ,erap.id_detentore::TEXT id_nuovo_detentore,null as comune_struttura_fuori_reg, null as provincia_struttura_fuori_reg,null as cap_struttura_fuori_reg,null as indirizzo_struttura_fuori_reg, null as codice_struttura_fuori_reg from evento_restituzione_a_proprietario erap   -- tipologia 45
union
select id_evento ,etc.data_trasferimento_canile data_cambio_detentore ,etc.id_canile_detentore::TEXT id_nuovo_detentore, etc.comune_struttura_fuori_reg, etc.provincia_struttura_fuori_reg,etc.cap_struttura_fuori_reg,etc.indirizzo_struttura_fuori_reg, codice_struttura as codice_struttura_fuori_reg   from evento_trasferimento_canile etc  -- tipologia 31
union 
select id_evento ,rnd.data_ritrovamento_nd data_cambio_detentore ,rnd.id_detentore_dopo_ritrovamento_nd::TEXT id_nuovo_detentore,null as comune_struttura_fuori_reg, null as provincia_struttura_fuori_reg,null as cap_struttura_fuori_reg,null as indirizzo_struttura_fuori_reg, null as codice_struttura_fuori_reg   from evento_ritrovamento_non_denunciato rnd  -- tipologia 31
union  
select id_evento ,rit.data_ritrovamento data_cambio_detentore ,rit.id_detentore_dopo_ritrovamento::TEXT id_nuovo_detentore,null as comune_struttura_fuori_reg, null as provincia_struttura_fuori_reg,null as cap_struttura_fuori_reg,null as indirizzo_struttura_fuori_reg, null as codice_struttura_fuori_reg   from evento_ritrovamento rit  -- tipologia 12
union  
select id_evento ,cat.data_cattura data_cambio_detentore ,cat.id_detentore_cattura::TEXT id_nuovo_detentore,null as comune_struttura_fuori_reg, null as provincia_struttura_fuori_reg,null as cap_struttura_fuori_reg,null as indirizzo_struttura_fuori_reg, null as codice_struttura_fuori_reg   from evento_cattura cat  -- tipologia 24
)
evt_cambio_det on evt_cambio_det.id_evento=e.id_evento
left join opu_relazione_stabilimento_linee_produttive l_det_evttra  on l_det_evttra.id::text =evt_cambio_det.id_nuovo_detentore
left join opu_stabilimento os_det_evttra on os_det_evttra.id =l_det_evttra.id_stabilimento  
left join opu_soggetto_fisico osf_det_evttra on osf_det_evttra.id =os_det_evttra.id_soggetto_fisico
left join opu_indirizzo oi_det_evttra on oi_det_evttra.id =os_det_evttra.id_indirizzo
left join comuni1 c_det_evttra on c_det_evttra.id= oi_det_evttra.comune
left join lookup_province prov_det_evttra on prov_det_evttra.code::integer = c_det_evttra.cod_provincia::integer
left join opu_relazione_stabilimento_linee_produttive l_evtcsm on l_evtcsm.id =e.id_proprietario_corrente
left join opu_stabilimento os_evtcsm on os_evtcsm.id =l_evtcsm.id_stabilimento
left join opu_soggetto_fisico osf_evtcsm on osf_evtcsm.id =os_evtcsm.id_soggetto_fisico
left join opu_indirizzo oi_prop_os_evtcsm on os_evtcsm.id_indirizzo =oi_prop_os_evtcsm.id
left join comuni1 c_evtcsm on c_evtcsm.id= oi_prop_os_evtcsm.comune
left join lookup_province prov_evtcsm on prov_evtcsm.code::integer = c_evtcsm.cod_provincia::integer
left join opu_relazione_stabilimento_linee_produttive l_det_evtcsm on l_det_evtcsm.id::text =evt_cambio_det.id_nuovo_detentore
left join opu_stabilimento os_det_evtcsm on os_det_evtcsm.id =l_det_evtcsm.id_stabilimento  
left join opu_soggetto_fisico osf_det_evtcsm on osf_det_evtcsm.id =os_det_evtcsm.id_soggetto_fisico
left join opu_indirizzo oi_det_evtcsm on oi_det_evtcsm.id =os_det_evtcsm.id_indirizzo
left join comuni1 c_det_evtcsm on c_det_evtcsm.id= oi_det_evtcsm.comune
left join lookup_province prov_det_evtcsm on prov_det_evtcsm.code::integer = c_det_evtcsm.cod_provincia::integer

where e.data_cancellazione is null and  e.trashed_date is null
and  e.id_tipologia_evento in (18,31,56,24,41,45,12,70) and e.id_evento = _idevento;  

 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.sinaaf_trasferimento_animale_get_dati_envelope(integer)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.sinaaf_trasferimento_animale_get_dati_envelope(integer) TO public;
GRANT EXECUTE ON FUNCTION public.sinaaf_trasferimento_animale_get_dati_envelope(integer) TO postgres;





delete from registrazioni_wk where id_stato in (103,104) and id_registrazione = 23


--Modifiche BDU dopo la call del 23/10
delete from registrazioni_wk where id_stato in (103,104) and id_registrazione = 70;
delete from evento_html_fields where label_campo ilike '%Inserisci nuovo socio%';


--Modifiche dopo la riunione del 22/11
INSERT INTO public.configuratore_template_no_scia
(id, html_label, html_enabled, sql_campo, sql_origine, sql_condizione, html_ordine, html_type, sql_campo_lookup, sql_origine_lookup, sql_condizione_lookup, html_name, mapping_field, oid_parent, html_style, html_event)
VALUES(612, 'DOMICILIO DIGITALE (PEC)', true, NULL, NULL, NULL, 'bt', 'text', NULL, NULL, NULL, 'email_rapp_legale', '_b_email_rapp_leg', NULL, 'size="50" maxlength="50" required="true"', NULL);
INSERT INTO public.configuratore_template_no_scia
(id, html_label, html_enabled, sql_campo, sql_origine, sql_condizione, html_ordine, html_type, sql_campo_lookup, sql_origine_lookup, sql_condizione_lookup, html_name, mapping_field, oid_parent, html_style, html_event)
VALUES(611, 'DOMICILIO DIGITALE (PEC)', true, 'email_impresa', NULL, NULL, 'ae', 'text', NULL, NULL, NULL, 'email_impresa', '_b_email_impresa', NULL, 'size="50" maxlength="50" required="true"', NULL);
update schema_anagrafica set id_campo_configuratore=611 where codice_univoco_ml ilike'%assanim%' and id_campo_configuratore=5;
update schema_anagrafica set id_campo_configuratore=612 where codice_univoco_ml ilike'%assanim%' and id_campo_configuratore=24;

update schema_anagrafica set enabled = false where codice_univoco_ml ilike'%assanim%' and id_gruppo_template=4;




--Disattivazione in collaudo
update schema_anagrafica set enabled = false where codice_univoco_ml = 'ASSANIM-ASSANIM-ASSANIM';

update master_list_macroarea set trashed_date = now() where codice_sezione ilike 'ASSANIM';
update master_list_aggregazione set trashed_date = now() where codice_attivita ilike 'ASSANIM';
update master_list_linea_attivita set trashed_date = now() where codice_prodotto_specie ilike 'ASSANIM';


delete from ml8_linee_attivita_nuove_materializzata where id_nuova_linea_attivita =  (select id from master_list_linea_attivita where codice_prodotto_specie ilike 'ASSANIM');

update lookup_tipologia_registrazione set enabled = false where code = 70;

update lookup_tipologia_stato  set enabled = false where description ilike '%in affido%';

delete from  registrazioni_wk where id_registrazione = 70;

--Riattivazione in collaudo
update schema_anagrafica set enabled = true where codice_univoco_ml = 'ASSANIM-ASSANIM-ASSANIM';

update master_list_macroarea set trashed_date = null where codice_sezione ilike 'ASSANIM';
update master_list_aggregazione set trashed_date = null where codice_attivita ilike 'ASSANIM';
update master_list_linea_attivita set trashed_date = null where codice_prodotto_specie ilike 'ASSANIM';

SELECT * FROM refresh_ml_materializzata((select id from master_list_linea_attivita where codice_prodotto_specie ilike 'ASSANIM'));


update lookup_tipologia_registrazione set enabled = true where code = 70;

update lookup_tipologia_stato  set enabled = true where description ilike '%in affido%';

insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (3,70,104,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (9,70,105,false);

--Disattivazione in ufficiale
update lookup_tipologia_registrazione set enabled = false where code = 70;

update lookup_tipologia_stato  set enabled = false where description ilike '%in affido%';

--Attivazione in ufficiale
INSERT INTO schema_anagrafica
SELECT nextval('schema_anagrafica_id_seq'),'ASSANIM-ASSANIM-ASSANIM' as codice_univoco_ml,id_gruppo_template, id_campo_configuratore, campo_esteso, enabled, data_scadenza FROM schema_anagrafica
WHERE  codice_univoco_ml = 'FARM-FARM-FARMVET';

insert into master_list_macroarea(codice_sezione, codice_norma, norma, macroarea, id_norma,rev, entered, enteredby) values ('ASSANIM', 'Altro','Altra normativa','Associazione  animalista',
(select code from opu_lookup_norme_master_list where description = 'Altra normativa'),11,now(),6567) returning id;


insert into master_list_aggregazione (id_macroarea, codice_attivita, aggregazione, id_flusso_originale,rev,entered, enteredby) values 
(?, 'ASSANIM', 'ASSOCIAZIONE ANIMALISTA', 5,11,now(),6567) returning id

insert into master_list_linea_attivita (id_aggregazione, codice_prodotto_specie, linea_attivita, codice_univoco,rev,entered, enteredby) values 
(?, 'ASSANIM', 'ASSOCIAZIONE ANIMALISTA', 'ASSANIM-ASSANIM-ASSANIM',11,now(),6567) returning id; --41450

INSERT INTO master_list_flag_linee_attivita(id, codice_univoco,mobile, fisso, apicoltura, registrabili, riconoscibili, sintesis, bdu, vam,no_scia, categorizzabili, operatore_mercato, compatibilita_noscia, rev, entered, enteredby, id_linea, visibilita_asl, visibilita_regione, incompatibilita)
    SELECT nextval('master_list_flag_linee_attivita_id_seq'),'ASSANIM-ASSANIM-ASSANIM' as codice_univoco,
    mobile, fisso, apicoltura, registrabili, riconoscibili, sintesis, bdu, vam,no_scia, categorizzabili, operatore_mercato, compatibilita_noscia,11, now(),6567, id_linea, visibilita_asl, visibilita_regione, incompatibilita 
    FROM master_list_flag_linee_attivita
    WHERE  codice_univoco = 'FARM-FARM-FARMVET' and rev=11;
    
update master_list_flag_linee_attivita set categoria_rischio_default  = 2 where codice_univoco = 'ASSANIM-ASSANIM-ASSANIM';



update  master_list_flag_linee_attivita set  id_linea= ? where codice_univoco='ASSANIM-ASSANIM-ASSANIM';

update  master_list_flag_linee_attivita set operatore_mercato=false, compatibilita_noscia =null where codice_univoco='ASSANIM-ASSANIM-ASSANIM';

SELECT * FROM refresh_ml_materializzata(null);


CREATE OR REPLACE VIEW public.associazioni_view
AS SELECT o.id AS code,
    concat(oo.ragione_sociale, ' - ', oo.partita_iva, ' - ', 'VIA ', oi.via, ' ', oi.comune_testo, ' ', TRIM(BOTH FROM oi.cap), ' (', lp.description, ')') AS description,
    false AS default_item,
    1 AS level,
    os.id_asl AS asl,
    o.enabled,
    o.entered,
    o.modified,
    oo.partita_iva,
    concat('VIA: ', oi.via, '  COMUNE: ', oi.comune_testo, ' ', TRIM(BOTH FROM oi.cap), ' (', lp.description, ')') AS indirizzo,
    NULL::text AS id_specie,
    oo.ragione_sociale
   FROM opu_relazione_stabilimento_linee_produttive o
     JOIN opu_stabilimento os ON o.id_stabilimento = os.id
     JOIN opu_operatore oo ON os.id_operatore = oo.id
     JOIN opu_indirizzo oi ON oi.id = oo.id_indirizzo
     JOIN lookup_province lp ON oi.provincia::text = lp.code::text
  WHERE o.id_linea_produttiva = 46260 AND o.trashed_date IS NULL AND (o.data_fine > now() OR o.data_fine IS NULL);
  
   update lookup_tipologia_registrazione set enabled = true where id = 70;

   update lookup_tipologia_stato  set enabled = true where description ilike '%in affido%';

   insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (3,70,104,false);
insert into registrazioni_wk (id_stato,id_registrazione,id_prossimo_stato,only_hd) values (9,70,105,false);
  