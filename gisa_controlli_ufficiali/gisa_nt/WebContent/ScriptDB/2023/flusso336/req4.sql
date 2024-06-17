CREATE TABLE public.struttura_detenzione_dati_sinaaf (
	id serial4 NOT NULL,
	id_rel_stab int4 NOT NULL,
	flag_presenza_cani boolean NULL,
	flag_presenza_gatti boolean NULL,
	capacita_struttura_mq varchar NUll,
	flag_presenza_altre_specie boolean NULL

);





CREATE OR REPLACE VIEW public.sinaaf_strutture_detenzione
AS SELECT DISTINCT ''::text AS cancodicenazionale,
    lps.id AS cancodiceregionale,
    op.ragione_sociale AS candenominazione,
    ''::text AS canpartitaiva,
        CASE
            WHEN ml.codice_univoco = 'IUV-CAN-RIFRIC'::text THEN 'TC01'::text
            WHEN ml.codice_univoco = 'IUV-CAN-RIFSAN'::text THEN 'TC02'::text
            WHEN ml.codice_univoco = 'IUV-CAN-PEN'::text THEN 'TC07'::text
            WHEN ml.codice_univoco = 'IUV-ADCA-ADCA'::text THEN 'TC09'::text
            WHEN ml.codice_univoco = ANY (ARRAY['IUV-CODAC-VEDCG'::text, 'IUV-COIAC-VEICG'::text, 'IUV-CODAC-DET'::text, 'IUV-COIAC-INGINF'::text, 'IUV-COIAC-INGSUP'::text]) THEN 'TC06'::text
            WHEN ml.codice_univoco = ANY (ARRAY['IUV-CAN-AAF'::text, 'IUV-CAN-ALLGAT'::text, 'IUV-CAN-ALLCAN'::text]) THEN 'TC03'::text
            WHEN ml.codice_univoco = 'IUV-CF-CF'::text THEN 'TC11'::text
            ELSE 'TC00'::text
        END AS ticcodice,
    sogg.codice_fiscale AS prpidfiscale,
    ''::text AS prpcomistat,
    ''::text AS prpprosigla,
    sogg.codice_fiscale AS gesidfiscale,
    com_stab.cod_comune AS comistat,
    provsedestab.cod_provincia AS prosigla,
    COALESCE(NULLIF(ind_stab.cap, ''::bpchar), com_stab.cap::bpchar) AS comcap,
    ind_stab.via AS canindirizzo,
    ''::text AS candtregistrazione,
    COALESCE(to_char(lps.data_inizio, 'dd/mm/yyyy'::text), ''::text) AS candtinizioattivita,
    COALESCE(to_char(lps.data_fine, 'dd/mm/yyyy'::text), ''::text) AS candtfineattivita,
    lps.telefono1 AS cannumtelfisso,
    lps.telefono2 AS cannumtelmobile,
    ''::text AS cannumfax,
    lps.mail1 AS canemail,
    fields_value.valore_campo AS cancapacita,
    ''::text AS canlatitudine,
    ''::text AS canlongitudine,
    sogg.codice_fiscale AS vetidfiscale,
    'S'::text AS flagprivato,
    ''::text AS numdecreto,
    ''::text AS flagpresenzacani,
    ''::text AS flagpresenzagatti,
    ''::text AS flagpresenzaaltrianimali,
    ''::text AS cannote
   FROM opu_operatore op
     LEFT JOIN opu_rel_operatore_soggetto_fisico rel_sogg ON rel_sogg.id_operatore = op.id AND (rel_sogg.enabled OR rel_sogg.enabled IS NULL) AND (rel_sogg.data_fine IS NULL OR rel_sogg.data_fine > CURRENT_TIMESTAMP)
     LEFT JOIN opu_soggetto_fisico sogg ON sogg.id = rel_sogg.id_soggetto_fisico
     JOIN opu_stabilimento stab ON op.id = stab.id_operatore
     LEFT JOIN opu_indirizzo ind_stab ON ind_stab.id = stab.id_indirizzo
     LEFT JOIN comuni1 com_stab ON com_stab.id = ind_stab.comune
     LEFT JOIN lookup_province provsedestab ON provsedestab.code = com_stab.cod_provincia::integer
     JOIN opu_relazione_stabilimento_linee_produttive lps ON lps.id_stabilimento = stab.id
     JOIN master_list_linea_attivita ml ON lps.id_linea_produttiva = ml.id AND ml.trashed_date IS NULL AND ml.enabled AND (ml.codice_univoco = ANY (ARRAY['IUV-CAN-RIFRIC'::text, 'IUV-CAN-RIFSAN'::text, 'IUV-CAN-PEN'::text, 'IUV-ADCA-ADCA'::text, 'IUV-CODAC-VEDCG'::text, 'IUV-COIAC-VEICG'::text, 'IUV-CODAC-DET'::text, 'IUV-COIAC-INGINF'::text, 'IUV-COIAC-INGSUP'::text, 'IUV-CAN-AAF'::text, 'IUV-CAN-ALLGAT'::text, 'IUV-CAN-ALLCAN'::text, 'IUV-CF-CF'::text]))
     LEFT JOIN linee_mobili_html_fields fields ON fields.codice_raggruppamento ~~* 'SUPSUPSUP'::text AND fields.id_linea = ml.id AND fields.enabled
     LEFT JOIN linee_mobili_fields_value fields_value ON fields_value.id_linee_mobili_html_fields = fields.id AND fields_value.enabled AND (fields_value.id_rel_stab_linea = lps.id OR fields_value.id_opu_rel_stab_linea = lps.id)
  WHERE op.trashed_date IS NULL;




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




CREATE OR REPLACE FUNCTION public.sinaaf_strutture_detenzione_get_dati_envelope(_idstruttura text)
 RETURNS TABLE(canid text, cancodice text, cancodiceregione text, canragionesociale text, ticcodice text, prpidfiscale text, canprpdtinizioattivita text, prpcomistat text, prpprosigla text, gesidfiscale text, cangesdtinizioattivita text, comistat text, prosigla text, canindirizzo text, comcap text, candtregistrazione text, candtinizioattivita text, candtfineattivita text, canflagfineattivita text, cannumtelfisso text, cannumtelmobile text, cannumfax text, canemail text, cancapacita text, canlatitudine text, canlongitudine text, canflagprivato text, cannumdecreto text, flagpresenzacani text, flagpresenzagatti text, flagpresenzaaltrianimali text, flagstrutturabloccata text, aslcodice text, note text)
 LANGUAGE plpgsql
AS $function$

 BEGIN
    
   RETURN QUERY
select distinct lps.id_sinaaf as canId,
       lps.codice_sinaaf::text as canCodice,
       lps.id::text as canCodiceRegione,
 op.ragione_sociale::text as canRagioneSociale,
 case 
       when lps.id_linea_produttiva=41453 then
       codice_tipologia_struttura_sinac::text
       end  as ticCodice,
        case 
       when lps.id_linea_produttiva=41453 then
       sogg.codice_fiscale
       else ''::text end as prpIdFiscale,
       coalesce(to_char(lps.data_inizio, 'dd-mm-yyyy'), '')::text as canPrpDtInizioAttivita,
      case 
       when lps.id_linea_produttiva=41453 then
       case when com_stab.cod_comune != '-1' then com_stab.cod_comune::text else '' end
       else ''
       end as prpComIstat,
case 
       when lps.id_linea_produttiva=41453 then
       sogg.provincia_nascita
       else '' 
       end as prpProSigla,
        case when sogg.codice_fiscale in ('N.D.Amb.Isc', 'N.D', '00000000000') then '' 
            else sogg.codice_fiscale::text
       end as gesIdFiscale,
coalesce(to_char(lps.data_inizio, 'dd-mm-yyyy'), '')::text as canGesDtInizioAttivita,
        case when com_stab.cod_comune != '-1' then com_stab.cod_comune::text else '' end as comIstat,
       upper(provsedestab.cod_provincia)::text as proSigla,
regexp_replace(public.unaccent(coalesce(ind_stab.via, '') ),'[\°\\''\²\/]',' ','g') as canIndirizzo,
 coalesce( case when com_stab.cap != 'N.D' then com_stab.cap else null end  , case when ind_stab.cap != 'N.D' then ind_stab.cap else null end )::text as comCap,
'' as canDtRegistrazione,
coalesce(to_char(lps.data_inizio, 'dd-mm-yyyy'), to_char(op.entered, 'dd-mm-yyyy')) as canDtInizioAttivita,
       coalesce(to_char(lps.data_fine, 'dd-mm-yyyy'), '') as canDtFineAttivita,
 '' as canFlagFineAttivita,
sogg.telefono::text as canNumTelFisso,
       lps.telefono2::text as canNumTelMobile,
       '' as canNumFax,
       lps.mail1 as canEmail,
       LEAST(aads.capacita_struttura_mq::integer / 3.5, 350)::numeric::integer::text
        as canCapacita,
substring(ind_stab.latitudine::text,1,8)  as canLatitudine,
 substring(ind_stab.longitudine::text,1,8) as canLongitudine,
 'N' as canFlagPrivato,
'' as canNumDecreto,
case when 
aads.flag_presenza_cani = true then 'S' else 'N'   end as flagPresenzaCani,
  case when 
aads.flag_presenza_gatti = true then 'S' else 'N'       end as flagPresenzaGatti,
       'N' as flagPresenzaAltriAnimali,
'N' as flagStrutturaBloccata,
'R' || asl.codiceistat as aslCodice,	
       '' as canNote
from opu_operatore op 
left join opu_rel_operatore_soggetto_fisico rel_sogg on rel_sogg.id_operatore = op.id and (rel_sogg.enabled or rel_sogg.enabled is null) and (rel_sogg.data_fine is null or rel_sogg.data_fine > current_timestamp)
left join opu_soggetto_fisico sogg on sogg.id = rel_sogg.id_soggetto_fisico and sogg.trashed_date is null 
left join opu_stabilimento stab on op.id = stab.id_operatore
left join opu_indirizzo ind_stab on ind_stab.id = stab.id_indirizzo
left join comuni1 com_stab on com_stab.id = ind_stab.comune 
left join lookup_site_id asl on asl.code::text = com_stab.codiceistatasl
left join lookup_province provsedestab ON provsedestab.code = com_stab.cod_provincia::integer
left join opu_relazione_stabilimento_linee_produttive lps on lps.id_stabilimento = stab.id 
left join struttura_detenzione_dati_sinaaf aads on lps.id = aads.id_rel_stab 
left join master_list_flag_linee_attivita pp2 on pp2.id_linea = lps.id_linea_produttiva 
where op.trashed_date is null and lps.id::text = _idstruttura and pp2.rev=11 ;   
 END;
$function$
;



CREATE OR REPLACE FUNCTION public.sinaaf_strutture_detenzione_get_envelope(_idstruttura text)
 RETURNS text
 LANGUAGE plpgsql
 STRICT
AS $function$
DECLARE
	ret text;
BEGIN
select 
concat('{"canId": "', canId,
'","canCodice": "', canCodice, 
'","canCodiceRegione": "', canCodiceRegione,
'","canRagioneSociale": "', canRagioneSociale,
'","ticCodice": "', ticCodice,
'","prpIdFiscale": "', prpIdFiscale,
'","canPrpDtInizioAttivita": "', canPrpDtInizioAttivita,
'","prpComIstat": "', prpComIstat,
'","prpProSigla": "', prpProSigla,
'","gesIdFiscale": "', gesIdFiscale,
'","canGesDtInizioAttivita": "', canGesDtInizioAttivita,
'","comIstat": "', comIstat,
'","proSigla": "', proSigla,
'","canIndirizzo": "', canIndirizzo,
'","comCap": "', comCap,
'","canDtRegistrazione": "', canDtRegistrazione,
'","aslCodice": "', aslCodice,
'","canDtInizioAttivita": "', canDtInizioAttivita,
'","canDtFineAttivita": "', canDtFineAttivita,
'", "canFlagFineAttivita": "', canFlagFineAttivita, 
'", "canNumTelFisso": "', canNumTelFisso, 
'", "canNumTelMobile": "', canNumTelMobile, 
'", "canNumFax": "', canNumFax, 
'", "canEmail": "', canEmail, 
'", "canCapacita": "', canCapacita, 
'", "canLatitudine": "', canLatitudine, 
'", "canLongitudine": "', canLongitudine, 
'", "canFlagPrivato": "', canFlagPrivato, 
'", "canNumDecreto": "', canNumDecreto, 
'", "flagPresenzaCani": "', flagPresenzaCani, 
'", "flagPresenzaGatti": "', flagPresenzaGatti,
'", "flagPresenzaAltriAnimali": "', flagPresenzaAltriAnimali,
'", "flagStrutturaBloccata": "', flagStrutturaBloccata,
'","note": "', note,'"}') into ret

from sinaaf_strutture_detenzione_get_dati_envelope(_idstruttura);

 RETURN ret;
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

CREATE OR REPLACE FUNCTION public.g2b_get_info_ws(_identita text, entita text)
 RETURNS TABLE(propagazione_bdu boolean, nome_app text, dbi_g2b text, id_tabella text, tabella text, sincronizzato boolean, cancellato boolean, id_struttura text)
 LANGUAGE plpgsql
AS $function$
DECLARE
propagazione_sinaaf_return boolean;
_id_tipologia_evento integer;
nome_ws_return text;
dbi_get_envelope_return text;
_id_linea_produttiva integer;
_id_stabilimento_gisa integer;
is_struttura_vet boolean;
is_struttura_detenzione boolean;
id_tabella_return text;
tabella_return text;
dipendenze_return text;
nome_campo_id_sinaaf_return text;
nome_campo_codice_sinaaf_get_return text;
nome_campo_codice_sinaaf_return text;
presente_in_gisa_return text;
_numero_microchip_assegnato text;
_id_proprietario_corrente integer;
_id_detentore_corrente integer;
_mc_esiste_in_sinaaf boolean;
_prop_esiste_in_sinaaf boolean;
_det_esiste_in_sinaaf boolean;
sincronizzato_to_return boolean;
id_sinaaf_to_return text;
id_sinaaf_secondario_to_return text;
codice_sinaaf_to_return text;
_id_proprietario text;
_controllo_detentore_cambiato boolean;
cancellato_return boolean;
codice_semantico_to_return text;
_cambio_proprietario boolean;

id_persona text;
 BEGIN
	propagazione_sinaaf_return:=false;
	sincronizzato_to_return:=false;
	



if(entita='struttura')then
_id_linea_produttiva:=(select id_linea_produttiva from opu_relazione_stabilimento_linee_produttive where id =  _identita::integer);
		tabella_return:='opu_stabilimento';
			id_tabella:='id';
			propagazione_bdu:=(select * from g2b_get_propagabilita(_identita,entita));
			nome_app:='2bdu';
			dbi_g2b:='public_functions.suap_inserisci_canile_bdu';
			id_struttura := (select os.id from opu_relazione_stabilimento_linee_produttive orslp join opu_stabilimento os on os.id = orslp.id_stabilimento where orslp.id=_identita::integer);
		--_det_esiste_in_bdu :=(select ws.data is not null and ws.data >= t1.modified_sinaaf and t1.modified_sinaaf is not null from opu_relazione_stabilimento_linee_produttive as t1, ws_storico_chiamate ws where ws.id_tabella = t1.id::text and ws.tabella = 'opu_relazione_stabilimento_linee_produttive' and ws.esito= 'OK' and t1.id = _id_detentore_corrente order by ws.id desc limit 1);
					--f _det_esiste_in_sinaaf is null then _det_esiste_in_sinaaf:=false; end if;
			--select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
			--select orosf.id_soggetto_fisico into id_persona from opu_relazione_stabilimento_linee_produttive orslp join opu_stabilimento os on orslp.id_stabilimento=os.id join opu_rel_operatore_soggetto_fisico orosf on os.id_operatore = orosf.id_operatore where orslp.id =  _identita::integer;
end if;
	





				
				--select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
					

	
   RETURN QUERY     
	select propagazione_bdu boolean, nome_app text, dbi_g2b text, id_tabella text, tabella_return text, sincronizzato boolean, cancellato boolean,id_struttura text;    
 END;
$function$
;




CREATE OR REPLACE FUNCTION public.g2b_get_propagabilita(id_stab text, entita text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$

DECLARE
propagazione_bdu_return boolean;
_id_linea_produttiva integer;
id_registrazione_inserimento_bdu integer;
_controllo_detentore_cambiato boolean;

 begin
	 /*
	linea_sindaco := (select * from get_id_linea_produttiva('sindaco'));
	linea_sindaco_fr := (select * from get_id_linea_produttiva('sindaco fuori regione'));
        propagazione_sinaaf_return:=false;
        	*/	
	if(entita='struttura') then
		_id_linea_produttiva:=(select id_linea_produttiva from opu_relazione_stabilimento_linee_produttive r where r.id=id_stab::integer );
		if(select distinct bdu from master_list_flag_linee_attivita where id_linea = _id_linea_produttiva::integer)then
			propagazione_bdu_return:=true; 
		end if;
	end if;


        RETURN propagazione_bdu_return;   
 END;
$function$
;



CREATE OR REPLACE FUNCTION public.gisa_bdu_is_sincronizzato(_identita text, entita text, nomeidtabella text)
 RETURNS TABLE(sincronizzato boolean, id_bdu text, cancellato boolean)
 LANGUAGE plpgsql
AS $function$
DECLARE
sincronizzato_return boolean;
id_bdu text;
query text;
id_base text;
 begin
	 if (entita = 'struttura') then
	 entita = 'opu_relazione_stabilimento_linee_produttive';
	 select * into _identita from opu_relazione_stabilimento_linee_produttive orslp  where orslp.id =_identita::integer;
	end if;
	query := '  select (
           (id_bdu is not null ) and 
           (
             (ws.data is not null and ws.data >= GREATEST (t1.modified_sinaaf,trashed_date)) or
             (t1.sinaaf_estrazione_invio_pregresso_ok is not null and t1.sinaaf_estrazione_invio_pregresso_ok >= GREATEST (t1.modified_sinaaf,trashed_date))
           )
          ),id_bdu, t1.trashed_date is not null as cancellato from ' || entita || ' as t1 left join ws_storico_chiamate ws on ws.id_tabella = t1.' || nomeidtabella ||'::text and ws.tabella = ''' || entita || ''' and ws.esito= ''OK'' and (ws.metodo is null or upper(ws.metodo) <> ''GET'')    where  t1.' || nomeidtabella || '::text = ''' || _identita || ''' order by ws.id desc limit 1';
	raise info 'query costruita per verificare if entita is sincronizzato: %', query;	
	EXECUTE query INTO  sincronizzato_return,id_bdu,cancellato;
	if sincronizzato_return is null then sincronizzato_return:=false; end if;	

	RETURN QUERY     
	select sincronizzato_return,id_bdu,cancellato;    
 END;
$function$
;


-- Drop table

-- DROP TABLE public.storico_chiamate_g2b;

CREATE TABLE public.storico_chiamate_g2b (
	id serial4 NOT NULL,
	url varchar NULL,
	request_dbi varchar NULL,
	response varchar NULL,
	"data" timestamp NULL,
	id_tabella varchar NULL,
	tabella varchar NULL,
	caller varchar NULL,
	endpoint varchar NULL,
	esito varchar NULL
);


ALTER TABLE public.opu_relazione_stabilimento_linee_produttive ADD id_sinaaf text NULL;

ALTER TABLE public.opu_relazione_stabilimento_linee_produttive ADD codice_sinaaf varchar(200) NULL;

ALTER TABLE public.opu_relazione_stabilimento_linee_produttive ADD modified_sinaaf timestamp NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE public.opu_relazione_stabilimento_linee_produttive ADD trashed_date timestamp NULL;

ALTER TABLE public.opu_relazione_stabilimento_linee_produttive ADD sinaaf_estrazione_invio_pregresso_ok timestamp NULL;

ALTER TABLE public.opu_relazione_stabilimento_linee_produttive ADD id_bdu varchar NULL;


CREATE OR REPLACE FUNCTION public.sinaaf_get_step_allineamento_entita(token_input text, method_input text DEFAULT NULL::text, step_input integer DEFAULT 1, token_principale_input text DEFAULT NULL::text, forza_allineamento text DEFAULT 'false'::text)
 RETURNS TABLE(campo_id_sinaaf_da_aggiornare_bdu text, propagazione_sinaaf_return text, nome_ws_return text, dbi_get_envelope_return text, id_tabella_return text, tabella_return text, dipendenze_return text, nome_campo_id_sinaaf_return text, presente_in_gisa_return text, sincronizzato_return text, id_sinaaf_return text, nome_campo_codice_sinaaf_get_return text, nome_campo_codice_sinaaf_return text, codice_sinaaf_return text, method text, envelope text, token text, step integer, nome_ws_get_return text)
 LANGUAGE plpgsql
AS $function$
DECLARE
i integer;
identita text;
entita text;
identita_temp text;
entita_temp text;
sincronizzato_temp text;
propagazione_sinaaf_return text;
dbi_get_envelope_return text;
dipendenze_return text;
presente_in_gisa_return text;
sincronizzato_return text;
nome_ws_return text;
nome_ws_get_return text;
nome_ws_get_return_secondario text;
query_string text;
id_tabella_return text;
tabella_return text;
nome_campo_id_sinaaf_return text;
id_sinaaf_return text;
nome_campo_codice_sinaaf_get_return text;
nome_campo_codice_sinaaf_return text;
codice_sinaaf_return text;
nome_ws_return_secondario text;
dbi_get_envelope_return_secondario text;
nome_campo_id_sinaaf_return_secondario text;
nome_campo_codice_sinaaf_get_return_secondario text;
nome_campo_codice_sinaaf_return_secondario text;
cancellato_return boolean;

 BEGIN
	if(step_input=1) then
		delete from sinaaf_step_allineamenti_entita t1 where t1.token_principale = token_input;
		token_principale_input:=token_input;
	end if;

	identita:=split_part(token_input,'@', 1);
	entita:=split_part(token_input,'@', 2);
	
	select propagazione_sinaaf,       nome_ws ,      dbi_get_envelope ,      id_tabella ,      tabella ,       dipendenze ,       nome_campo_id_sinaaf ,       presente_in_gisa ,      sincronizzato ,       id_sinaaf ,       nome_campo_codice_sinaaf_get ,        nome_campo_codice_sinaaf ,        codice_sinaaf, cancellato
          into propagazione_sinaaf_return,nome_ws_return,dbi_get_envelope_return,id_tabella_return,tabella_return, dipendenze_return, nome_campo_id_sinaaf_return, presente_in_gisa_return,sincronizzato_return, id_sinaaf_return, nome_campo_codice_sinaaf_get_return , nome_campo_codice_sinaaf_return , codice_sinaaf_return, cancellato_return from sinaaf_get_info_ws(identita, entita,method_input) as t;
	

	select nome_ws into nome_ws_get_return from sinaaf_get_info_ws(identita, entita,'GET') as t;
	
	if(position(';' in nome_ws_return)>0) then
		nome_ws_return_secondario:=split_part( nome_ws_return,';', 2);
		nome_ws_return:=split_part( nome_ws_return,';', 1);
		dbi_get_envelope_return_secondario:=split_part( dbi_get_envelope_return,';', 2);
		dbi_get_envelope_return:=split_part( dbi_get_envelope_return,';', 1);
		nome_campo_id_sinaaf_return_secondario:=split_part( nome_campo_id_sinaaf_return,';', 2);
		nome_campo_id_sinaaf_return:=split_part( nome_campo_id_sinaaf_return,';', 1);
		nome_campo_codice_sinaaf_get_return_secondario:=split_part( nome_campo_codice_sinaaf_get_return,';', 2);
		nome_campo_codice_sinaaf_get_return:=split_part( nome_campo_codice_sinaaf_get_return,';', 1);
		nome_campo_codice_sinaaf_return_secondario:=split_part( nome_campo_codice_sinaaf_get_return,';', 2);
		nome_campo_codice_sinaaf_return:=split_part( nome_campo_codice_sinaaf_get_return,';', 1);
		nome_ws_get_return_secondario:=split_part( nome_ws_get_return,';', 2);
		nome_ws_get_return:=split_part( nome_ws_get_return,';', 1);
	end if;
	
	
	--in base al tipo di sincronizzazione
	if(method_input is not null) then
		method:= method_input;
	elsif(sincronizzato_return = 'false' and cancellato_return is true) then
		method:='DELETE';
	elsif(id_sinaaf_return is not null) then
		method:='PUT';
	else
		method:='POST';
	end if;

	if(nome_ws_get_return ilike '%passaport%') then
		method:='PUT';
	end if;

	if method in ('POST','PUT') and dbi_get_envelope_return is not null then
		raise info 'query per envelope, parametri: dbi_get_envelope_return = %, identita = % ',  dbi_get_envelope_return , identita;
		raise info 'query per envelope: %', 'select * from ' || dbi_get_envelope_return || '(''' || identita || ''');';
		EXECUTE 'select * from ' || dbi_get_envelope_return || '(''' || identita || ''');' INTO envelope;
	end if;

	raise info 'verifico se posso inserire in step_allineamenti: % % % % % ', propagazione_sinaaf_return, sincronizzato_return , forza_allineamento, presente_in_gisa_return, method;
	if ((propagazione_sinaaf_return='true' and (sincronizzato_return ='false' or forza_allineamento='true')  and presente_in_gisa_return is null ) or method  in ('DELETE','GET')) then
		insert into sinaaf_step_allineamenti_entita(token, ws, method, envelope, step,token_principale,propagazione_sinaaf,dbi_get_envelope,id_tabella,tabella, dipendenze, nome_campo_id_sinaaf, presente_in_gisa,sincronizzato, id_sinaaf, nome_campo_codice_sinaaf_get , nome_campo_codice_sinaaf , codice_sinaaf, cancellato, ws_get) values(identita || '@' || entita, nome_ws_return, method ,envelope, step_input,token_principale_input,propagazione_sinaaf_return,dbi_get_envelope_return,id_tabella_return,tabella_return, dipendenze_return, nome_campo_id_sinaaf_return, presente_in_gisa_return,sincronizzato_return, id_sinaaf_return, nome_campo_codice_sinaaf_get_return , nome_campo_codice_sinaaf_return , codice_sinaaf_return, cancellato_return,nome_ws_get_return);
		if nome_ws_return_secondario is not null then
			raise info 'query per envelope secondario: %', 'select * from ' || dbi_get_envelope_return_secondario || '(''' || identita || ''');' ;
			EXECUTE 'select * from ' || dbi_get_envelope_return_secondario || '(''' || identita || ''');' INTO envelope;
			insert into sinaaf_step_allineamenti_entita(campo_id_sinaaf_da_aggiornare_bdu, token, ws, method, envelope, step,token_principale,propagazione_sinaaf,dbi_get_envelope,id_tabella,tabella, dipendenze, nome_campo_id_sinaaf, presente_in_gisa,sincronizzato, id_sinaaf, nome_campo_codice_sinaaf_get , nome_campo_codice_sinaaf , codice_sinaaf, cancellato, ws_get) 
			values('id_sinaaf_secondario',identita || '@' || entita, nome_ws_return_secondario, method ,envelope, step_input,token_principale_input,propagazione_sinaaf_return,dbi_get_envelope_return_secondario,id_tabella_return,tabella_return, dipendenze_return, nome_campo_id_sinaaf_return_secondario, presente_in_gisa_return,sincronizzato_return, id_sinaaf_return, nome_campo_codice_sinaaf_get_return_secondario , nome_campo_codice_sinaaf_return_secondario , codice_sinaaf_return, cancellato_return, nome_ws_get_return_secondario);
		end if;
	end if;


        i:=1;
	if(dipendenze_return is not null and dipendenze_return<>'' and method <>'GET' and method <>'DELETE') then
	
		while split_part(dipendenze_return,';', i) is not null and split_part(dipendenze_return,';', i)<>'' loop
			identita_temp:=split_part(dipendenze_return,';', i);
			entita_temp:=split_part(dipendenze_return,';', i+1);
			sincronizzato_temp:=split_part(dipendenze_return,';', i+2);
			query_string :=  concat('select * from sinaaf_get_step_allineamento_entita(''', identita_temp,'@',entita_temp , ''',null,' , step_input+1 , ',''' , coalesce(token_principale_input, 'null') ,''',''', 'false', ''');');
			raise info 'query step allineamenti su dipendenze: %', concat('select * from sinaaf_get_step_allineamento_entita(''', identita_temp,'@',entita_temp , ''',null,' , step_input+1 , ',''' , coalesce(token_principale_input, 'null') ,''',''', 'false', ''');');
			EXECUTE query_string;
			
		i:=i+3;
		end loop;
	end if;
	
	RETURN QUERY select t2.campo_id_sinaaf_da_aggiornare_bdu, propagazione_sinaaf,t2.ws,dbi_get_envelope,id_tabella,tabella, dipendenze, nome_campo_id_sinaaf, presente_in_gisa,sincronizzato, id_sinaaf, nome_campo_codice_sinaaf_get , nome_campo_codice_sinaaf , codice_sinaaf, t2.method,t2.envelope, t2.token, t2.step, t2.ws_get from sinaaf_step_allineamenti_entita t2 where t2.token_principale = token_principale_input order by t2.step desc;    
	                    
	if(step=1) then
		delete from sinaaf_step_allineamenti_entita t3 where t3.token = identita || '@' || entita;
	end if;	
	
	
    END;
$function$
;

CREATE OR REPLACE FUNCTION public.sinaaf_is_sincronizzato(_identita text, entita text, nomeidtabella text)
 RETURNS TABLE(sincronizzato boolean, id_sinaaf text, codice_sinaaf text, cancellato boolean, id_sinaaf_secondario text)
 LANGUAGE plpgsql
AS $function$
DECLARE
sincronizzato_return boolean;
id_sinaaf text;
query text;
id_base text;
 begin
	 if (entita = 'struttura') then
	 entita = 'opu_relazione_stabilimento_linee_produttive';
	 select * into _identita from opu_relazione_stabilimento_linee_produttive orslp  where orslp.id =_identita::integer;
	end if;
	query := '  select (
           (id_sinaaf is not null or codice_sinaaf is not null) and 
           (
             (ws.data is not null and ws.data >= GREATEST (t1.modified_sinaaf,trashed_date)) or
             (t1.sinaaf_estrazione_invio_pregresso_ok is not null and t1.sinaaf_estrazione_invio_pregresso_ok >= GREATEST (t1.modified_sinaaf,trashed_date))
           )
          ),id_sinaaf,codice_sinaaf, t1.trashed_date is not null as cancellato from ' || entita || ' as t1 left join ws_storico_chiamate ws on ws.id_tabella = t1.' || nomeidtabella ||'::text and ws.tabella = ''' || entita || ''' and ws.esito= ''OK'' and (ws.metodo is null or upper(ws.metodo) <> ''GET'')    where  t1.' || nomeidtabella || '::text = ''' || _identita || ''' order by ws.id desc limit 1';
	raise info 'query costruita per verificare if entita is sincronizzato: %', query;	
	EXECUTE query INTO  sincronizzato_return,id_sinaaf,codice_sinaaf,cancellato;
	if sincronizzato_return is null then sincronizzato_return:=false; end if;	

	RETURN QUERY     
	select sincronizzato_return,id_sinaaf,codice_sinaaf,cancellato,'';    
 END;
$function$
;
;


CREATE OR REPLACE FUNCTION public.sinaaf_iscrizione_animale_get_dati_envelope(_idevento integer)
 RETURNS TABLE(anmid text, movid text, apmid text, traid text, ubiid text, anmnome text, anmtatuaggio text, anmmicrochip text, motivoingresso text, tzacodice text, anmdtnascita text, flagdtpresuntanascita text, flagnascitacanile text, anmsesso text, specodice text, razzacodice text, razzavarieta text, flagincrocio text, colcodice text, pelcodice text, tagcodice text, prpjson text, vetidfiscale text, nominativovetnonpresente text, anmdtapplicazionechip text, anmflagapplchip text, anmdtiscrizione text, dtevento text, dtultimamodifica text)
 LANGUAGE plpgsql
AS $function$

 BEGIN
    
   RETURN QUERY     
select distinct
ev.id_sinaaf as anmId,
'' as movId,
'' as apmId,
'' as traId,
'' as ubiId,
coalesce(an.nome, '')::text as anmNome, 
coalesce(tatuaggio, '')::text as anmTatuaggio, 
coalesce(an.microchip, '')::text as anmMicrochip , 
case
    when flag_anagrafe_fr then 'ACQ' 
    when flag_anagrafe_fr is false or flag_anagrafe_fr is null then 'ISC'
    else '' end as motivoIngresso,
'Z99' as tzaCodice,
coalesce(to_char(an.data_nascita, 'dd-mm-yyyy'), '') as anmDtNascita,
case
   when flag_data_nascita_presunta then 'S'
   when flag_data_nascita_presunta is false then 'N' 
   else '' end as flagDtPresuntaNascita,
case
   when l_prop.id_linea_produttiva = 5 and l_det.id_linea_produttiva = 5 then 'S'
   else 'N' end as flagNascitaCanile,
upper(coalesce(an.sesso,''))::text  as anmSesso ,
case 
  when an.id_specie = 1 then 'C'
  when an.id_specie = 2 then 'G' 
  when an.id_specie = 3 then 'F'
  else '' end as speCodice,
case 
  when an.id_specie in( 1,2) then dec_razza.codice_sinaf::text
  else 'F04' end as razzacodice,           
dec_razza.varieta_sinaf::text AS razzavarieta,
case 
  when (raz.description ilike '%METICCIO%' and an.id_specie = 1) then 'S'
  when ( an.id_specie = 1) then 'N'
  else '' end  as flagIncrocio,
coalesce(dec_mantello.codice_sinaf,'')::text as colCodice,
'P99' as pelCodice, --rif.: mail di brunetti del 22/02: nel manuale non era ancora aggiornato alla data della mail
case 
  when tag.code = 1 then '01'  
  when tag.code = 2 then '02' 
  when tag.code = 3 then '03' 
  when tag.code = 5 then '04' 
  else '99' end as tagCodice, --rif.: mail di brunetti del 22/02: nel manuale non era ancora aggiornato alla data della mail
 (select * from sinaaf_proprietario_get_envelope( ev.id_evento)) as prpJson,
 case
  when flag_anagrafe_fr then  ''
  when char_length(NULLIF(contact_utente_ins_microchip.codice_fiscale, ''))=16 and NULLIF(contact_utente_ins_microchip.codice_fiscale, '') not in  ('CF', 'n.d', '1111111111111111','1231231234324325','234234234234234e','test111111111111','nnnnnnnndddddddd','nddddddddddddddd','N.D.DDDDDDDDDDDD' )   then NULLIF(contact_utente_ins_microchip.codice_fiscale, '')
  when char_length(NULLIF(contact_ins_reg.codice_fiscale, ''))=16 and NULLIF(contact_ins_reg.codice_fiscale, '') not in  ('CF', 'n.d', '1111111111111111','1231231234324325','234234234234234e','test111111111111','nnnnnnnndddddddd','nddddddddddddddd','N.D.DDDDDDDDDDDD' )   then NULLIF(contact_ins_reg.codice_fiscale, '')
  else '' end as vetIdFiscale,
case
  when flag_anagrafe_fr then 'ANIMALE MICROCHIPPATO DA ALTRA REGIONE' 
  else ''
end as nominativoVetNonPresente,
  coalesce(to_char(ev_ins_microchip.data_inserimento_microchip , 'dd-mm-yyyy'), '')::text as anmDtApplicazioneChip,
  'S' as anmFlagApplChip,
  coalesce(to_char(ev_bdu.data_registrazione, 'dd-mm-yyyy'), '')::text as anmDtIscrizione,
    coalesce(to_char(ev_bdu.data_registrazione, 'dd-mm-yyyy'), '')::text as dtEvento,
    coalesce(to_char(ev.modified, 'dd-mm-yyyy'), '')::text as dtUltimaModifica
 from animale an
left join evento ev on ev.id_animale = an.id and ev.id_tipologia_evento = 1 and ev.data_cancellazione is null and ev.trashed_date is null
left join evento_registrazione_bdu ev_bdu on ev_bdu.id_evento = ev.id_evento
left join evento ev2 on ev2.id_animale = an.id and ev2.id_tipologia_evento = 3 and ev2.data_cancellazione is null and ev2.trashed_date is null
left join evento_inserimento_microchip ev_ins_microchip on ev_ins_microchip.id_evento = ev2.id_evento
left join access_ utente_ins_microchip on utente_ins_microchip.user_id= ev_ins_microchip.id_veterinario_privato_inserimento_microchip
left join contact_ contact_utente_ins_microchip on contact_utente_ins_microchip.contact_id= utente_ins_microchip.contact_id
left join access_ utente_ins_reg on utente_ins_reg.user_id = ev.id_utente_inserimento  
left join contact_ contact_ins_reg on contact_ins_reg.contact_id= utente_ins_reg.contact_id 
left join lookup_razza raz on raz.code = an.id_razza and raz.enabled and raz.id_specie = an.id_specie
left join sinaff_razza_decode dec_razza on dec_razza.encicode_bdu=raz.enci_code ::text and raz.id_specie =dec_razza.id_specie 
left join lookup_taglia tag on tag.code = an.id_taglia and tag.enabled  
left join lookup_mantello mantello on mantello.code=an.id_tipo_mantello and mantello.enabled 
left join sinaff_mantello_decode dec_mantello on dec_mantello.id_specie =mantello.id_specie and mantello.code::text=dec_mantello.encicode_bdu 
left join opu_relazione_stabilimento_linee_produttive l_prop on l_prop.id =ev_bdu.id_proprietario 
left join opu_relazione_stabilimento_linee_produttive l_det on l_det.id =ev_bdu.id_detentore_registrazione_bdu 
--left join sinaff_mantello_decode dec_mantello on dec_mantello.id_specie =mantello.id_specie and mantello.description=dec_mantello.description 
--left join sinaff_razza_decode dec_razza on dec_razza.encicode_bdu=raz.enci_code ::text 
where an.data_cancellazione is null and  an.trashed_date is null and ev.id_evento = _idevento;    
 END;
$function$
;


CREATE OR REPLACE FUNCTION public.sinaaf_persone_get_dati_envelope(_idproprietario integer)
 RETURNS TABLE(perid text, percognome text, pernome text, peridfiscale text, perflagtipologia text, perdtnascita text, nascitacomistat text, nascitaprosigla text, nascitastatoisocode text, perindirizzo text, comistat text, prosigla text, comcap text, domperindirizzo text, domcomistat text, domprosigla text, domcomcap text, pernumtelfisso text, pernumtelmobile text, permail text, dtaccprivacy text, flagconsenservizi text, dtconsensoservizi text, tipoidfiscale text, dtultimamodifica text)
 LANGUAGE plpgsql
AS $function$

 BEGIN
   RETURN QUERY     
select rel_stab_linea.id_sinaaf as perId, 
sogg.cognome as perCognome,
sogg.nome as perNome,
case
when length(sogg.codice_fiscale) <> 16 or  _cf_check_char("substring"(sogg.codice_fiscale, 1, 15)) <> substring(sogg.codice_fiscale, 16, 16) then sogg.codice_fiscale_fittizio_sinaaf
when naz.codice_iso_alpha2 = 'IT' then sogg.codice_fiscale::text
when naz.codice_iso_alpha2 is not null and naz.codice_iso_alpha2 != 'IT' then sogg.codice_fiscale::text
when (naz.codice_iso_alpha2 is null and _cf_check_char("substring"(sogg.codice_fiscale, 1, 15)) = substring(sogg.codice_fiscale, 16, 16))  then sogg.codice_fiscale::text
else sogg.codice_fiscale_fittizio_sinaaf::text
end as perIdFiscale,
'F' as perFlagTipologia,
coalesce(to_char(sogg.data_nascita, 'dd-mm-yyyy'), '')::text as perDtNascita,
com_nascita.cod_comune::text as nascitaComIstat,
upper(prov_nascita.cod_provincia)::text as nascitaProSigla,
--'' as nascitaStatoCodiceBelfiore,
coalesce(naz.codice_iso_alpha2,'')::text as nascitaStatoIsoCode,
regexp_replace(public.unaccent(coalesce(ind.via, '') ),'[\°\\''\²\/]',' ','g') as perIndirizzo, 
case when upper(prov_residenza.cod_provincia)::text = 'ES' then '000' else
com_residenza.cod_comune::text end as comIstat,
case when upper(prov_residenza.cod_provincia)::text = 'ES' then 'EE' else 
upper(prov_residenza.cod_provincia)::text end as proSigla ,
case 
	when ind.cap::text not ilike '%n.d%' then ind.cap::text 
	when com_residenza.cap is not null and com_residenza.cap <> '' then  com_residenza.cap::text 
	else '00000'
end as comCap ,
regexp_replace(public.unaccent(coalesce(ind.via, '') ),'[\°\\''\²\/]',' ','g') as domPerIndirizzo, 
case when upper(prov_residenza.cod_provincia)::text = 'ES' then '000' else
com_residenza.cod_comune::text end as domComIstat ,
case when upper(prov_residenza.cod_provincia)::text = 'ES' then 'EE' else 
upper(prov_residenza.cod_provincia)::text end as domProSigla ,
case 
	when ind.cap::text not ilike '%n.d%' then ind.cap::text 
	when com_residenza.cap is not null and com_residenza.cap <> '' then  com_residenza.cap::text 
	else '00000'
end as domComCap ,
coalesce(rel_stab_linea.telefono1,sogg.telefono,'N.D.')::text as perNumTelFisso ,
coalesce(rel_stab_linea.telefono2,sogg.telefono1,'N.D.')::text as perNumTelMobile,
sogg.email::text as perMail ,
coalesce(to_char(current_timestamp, 'dd-mm-yyyy'), '')::text as dtAccPrivacy ,
'S' as flagConsenServizi,
coalesce(to_char(current_timestamp, 'dd-mm-yyyy'), '')::text as dtConsensoServizi,
case
when length(sogg.codice_fiscale) <> 16 or  _cf_check_char("substring"(sogg.codice_fiscale, 1, 15)) <> substring(sogg.codice_fiscale, 16, 16) then 'N'
when naz.codice_iso_alpha2 = 'IT' then 'I'
when naz.codice_iso_alpha2 is not null and naz.codice_iso_alpha2 != 'IT' then 'E'
when (naz.codice_iso_alpha2 is null and _cf_check_char("substring"(sogg.codice_fiscale, 1, 15)) = substring(sogg.codice_fiscale, 16, 16))  then 'I'
else 'N'
end as tipoIdFiscale,
coalesce(to_char(current_timestamp, 'dd-mm-yyyy'), '')::text as dtUltimaModifica
from opu_soggetto_fisico sogg
left join opu_rel_operatore_soggetto_fisico rel_op_sogg on rel_op_sogg.id_soggetto_fisico = sogg.id and rel_op_sogg.stato_ruolo = 1 and (rel_op_sogg.enabled or rel_op_sogg.enabled is null)
left join opu_operatore op on op.id = rel_op_sogg.id_operatore and op.trashed_date is null
left join opu_stabilimento st on st.id_operatore = op.id 
left join opu_relazione_stabilimento_linee_produttive rel_stab_linea on rel_stab_linea.id_stabilimento = st.id and rel_stab_linea.trashed_date is null 
left join comuni1 com_nascita on upper(com_nascita.nome) = upper(sogg.comune_nascita)   
left join lookup_province prov_nascita ON prov_nascita.code::integer = com_nascita.cod_provincia::integer
left join opu_indirizzo ind on ind.id = sogg.indirizzo_id 
left join comuni1 com_residenza on com_residenza.id = ind.comune
left join lookup_province prov_residenza ON prov_residenza.code::integer = com_residenza.cod_provincia::integer
left join sinaaf_nazioni_codici_iso naz on ind.nazione ilike naz.denominazione_it 
where sogg.trashed_date is null and sogg.id = _idproprietario;    
 END;
$function$
;

CREATE OR REPLACE FUNCTION public.sinaaf_persone_get_dati_envelope(_idproprietario integer, _cf text)
 RETURNS TABLE(perid text, percognome text, pernome text, peridfiscale text, perflagtipologia text, perdtnascita text, nascitacomistat text, nascitaprosigla text, nascitastatoisocode text, perindirizzo text, comistat text, prosigla text, comcap text, domperindirizzo text, domcomistat text, domprosigla text, domcomcap text, pernumtelfisso text, pernumtelmobile text, permail text, dtaccprivacy text, flagconsenservizi text, dtconsensoservizi text, tipoidfiscale text, dtultimamodifica text)
 LANGUAGE plpgsql
AS $function$

 begin

    
   RETURN QUERY     
select rel_stab_linea.id_sinaaf as perId, 
sogg.cognome as perCognome,
sogg.nome as perNome,
case
when naz.codice_iso_alpha2 = 'IT' then sogg.codice_fiscale::text
when naz.codice_iso_alpha2 is not null and naz.codice_iso_alpha2 != 'IT' then sogg.codice_fiscale::text
when (naz.codice_iso_alpha2 is null and _cf_check_char("substring"(sogg.codice_fiscale, 1, 15)) = substring(sogg.codice_fiscale, 16, 16))  then sogg.codice_fiscale::text
else ''
end as perIdFiscale,
'F' as perFlagTipologia,
coalesce(to_char(sogg.data_nascita, 'dd-mm-yyyy'), '')::text as perDtNascita,
com_nascita.cod_comune::text as nascitaComIstat,
upper(prov_nascita.cod_provincia)::text as nascitaProSigla,
--'' as nascitaStatoCodiceBelfiore,
coalesce(naz.codice_iso_alpha2,'')::text as nascitaStatoIsoCode,
regexp_replace(public.unaccent(coalesce(ind.via, '') ),'[\°\\''\²\/]',' ','g') as perIndirizzo, 
com_residenza.cod_comune::text as comIstat,
upper(prov_residenza.cod_provincia)::text as proSigla ,
case when ind.cap::text not ilike '%n.d%' then ind.cap::text else com_residenza.cap::text end as comCap ,
regexp_replace(public.unaccent(coalesce(ind.via, '') ),'[\°\\''\²\/]',' ','g') as domPerIndirizzo, 
com_residenza.cod_comune::text as domComIstat ,
upper(prov_residenza.cod_provincia)::text as domProSigla ,
case when ind.cap::text not ilike '%n.d%' then ind.cap::text else com_residenza.cap::text end as domComCap ,
coalesce(rel_stab_linea.telefono1,sogg.telefono,'N.D.')::text as perNumTelFisso ,
coalesce(rel_stab_linea.telefono2,sogg.telefono1,'N.D.')::text as perNumTelMobile,
sogg.email::text as perMail ,
coalesce(to_char(current_timestamp, 'dd-mm-yyyy'), '')::text as dtAccPrivacy ,
'S' as flagConsenServizi,
coalesce(to_char(current_timestamp, 'dd-mm-yyyy'), '')::text as dtConsensoServizi,
case
when naz.codice_iso_alpha2 = 'IT' then 'I'
when naz.codice_iso_alpha2 is not null and naz.codice_iso_alpha2 != 'IT' then 'E'
when (naz.codice_iso_alpha2 is null and _cf_check_char("substring"(sogg.codice_fiscale, 1, 15)) = substring(sogg.codice_fiscale, 16, 16))  then 'I'
else 'N'
end as tipoIdFiscale,
coalesce(to_char(current_timestamp, 'dd-mm-yyyy'), '')::text as dtUltimaModifica
from opu_soggetto_fisico sogg
left join opu_rel_operatore_soggetto_fisico rel_op_sogg on rel_op_sogg.id_soggetto_fisico = sogg.id and rel_op_sogg.stato_ruolo = 1 and (rel_op_sogg.enabled or rel_op_sogg.enabled is null)
left join opu_operatore op on op.id = rel_op_sogg.id_operatore and op.trashed_date is null
left join opu_stabilimento st on st.id_operatore = op.id 
left join opu_relazione_stabilimento_linee_produttive rel_stab_linea on rel_stab_linea.id_stabilimento = st.id 
left join comuni1 com_nascita on com_nascita.nome ilike sogg.comune_nascita
left join lookup_province prov_nascita ON prov_nascita.code::integer = com_nascita.cod_provincia::integer
left join opu_indirizzo ind on ind.id = st.id_indirizzo 
left join comuni1 com_residenza on com_residenza.id = ind.comune
left join lookup_province prov_residenza ON prov_residenza.code::integer = com_residenza.cod_provincia::integer
left join sinaaf_nazioni_codici_iso naz on ind.nazione ilike naz.denominazione_it  or (_cf_check_char("substring"(sogg.codice_fiscale, 1, 15)) = substring(sogg.codice_fiscale, 16, 16) and SUBSTRING(sogg.codice_fiscale,12,4) ilike naz.codice_at)
where sogg.trashed_date is null and (sogg.id = _idproprietario)  ; 
 


END;


$function$
;


CREATE OR REPLACE FUNCTION public.sinaaf_persone_get_envelope(_idproprietario text)
 RETURNS text
 LANGUAGE plpgsql
 STRICT
AS $function$
DECLARE
	ret text;
BEGIN	
	
	
select 
concat('{"perId": "', perId,
'","perCognome": "', perCognome, 
'","perNome": "', perNome, 
'","perIdFiscale": "', perIdFiscale, 
'","perFlagTipologia": "', perFlagTipologia, 
'","perDtNascita": "', perDtNascita, 
'","nascitaComIstat": "', nascitaComIstat, 
'","nascitaProSigla": "', nascitaProSigla, 
--'","nascitaStatoCodiceBelfiore": "', nascitaStatoCodiceBelfiore, 
'","nascitaStatoIsoCode": "', nascitaStatoIsoCode, 
'","perIndirizzo": "', perIndirizzo, 
'","comIstat": "', comIstat, 
'","proSigla": "', proSigla, 
'","comCap": "', comCap, 
'","domPerIndirizzo": "', domPerIndirizzo, 
'","domComIstat": "', domComIstat, 
'","domProSigla": "', domProSigla, 
'","domComCap": "', domComCap,  
'","perNumTelFisso": "', perNumTelFisso, 
'","perNumTelMobile": "', perNumTelMobile, 
'","perMail": "', perMail, 
'","dtAccPrivacy": "', dtAccPrivacy,
'","flagConsenServizi": "', flagConsenServizi,
'","dtConsensoServizi": "', dtConsensoServizi,
 --'", "dtUltimaModifica": "', dtUltimaModifica, 
'","tipoIdFiscale": "', tipoIdFiscale,'"}') into ret

from sinaaf_persone_get_dati_envelope(_idproprietario::integer);


 RETURN ret;
 END;
$function$
;


CREATE OR REPLACE FUNCTION public.sinaaf_proprietario_get_dati_envelope(_idevento integer)
 RETURNS TABLE(tipoprp text, peridfiscaleprp text, cancodiceprp text, comistatprp text, prosiglaprp text, tipodet text, cancodicedet text, peridfiscaledet text, ubiindirizzo text, ubicomistat text, ubiprosigla text, ubicap text, ubidtinizio text, conferimentoperidfiscale text)
 LANGUAGE plpgsql
AS $function$

 BEGIN
    
   RETURN QUERY     
select 
case 
	when rel_stab_linea_prop.id_linea_produttiva = 1 then 'PER'
	when rel_stab_linea_prop.id_linea_produttiva in (4,5,6,8) then 'CAN'
        when rel_stab_linea_prop.id_linea_produttiva in (3,7) then 'COM'
end as tipoPrp,
case 
	when rel_stab_linea_prop.id_linea_produttiva = 1 then upper(coalesce(sogg_prop.codice_fiscale_fittizio_sinaaf, rel_stab_linea_prop.codice_sinaaf, sogg_prop.codice_fiscale))::text
	else ''
end as perIdFiscalePrp, 
case 
        when rel_stab_linea_prop.id_linea_produttiva in (4,5,6,8) then rel_stab_linea_prop.codice_sinaaf::text
        else ''
end as canCodicePrp, 
case 
        when rel_stab_linea_prop.id_linea_produttiva in (3,7) then com_prop.cod_comune::text
        else ''
end as comIstatPrp, 
case 
        when rel_stab_linea_prop.id_linea_produttiva in (3,7) then upper(prov_prop.cod_provincia)::text
        else ''
end as proSiglaPrp, 
case 
	when rel_stab_linea_det.id = rel_stab_linea_prop.id then 'PROP'
	when rel_stab_linea_det.id_linea_produttiva = 1 then 'PER' 
	when rel_stab_linea_det.id_linea_produttiva in (4,5,6,8) then 'CAN'
        when rel_stab_linea_det.id_linea_produttiva in (3,7) then 'COM'
end as tipoDet, 
case 
	when rel_stab_linea_det.id = rel_stab_linea_prop.id then '' 
        when rel_stab_linea_det.id_linea_produttiva in (4,5,6,8) then rel_stab_linea_det.codice_sinaaf::text
        else ''
end as canCodiceDet, 
case 
	when rel_stab_linea_det.id = rel_stab_linea_prop.id then '' 
	when rel_stab_linea_det.id_linea_produttiva = 1 then upper(coalesce(sogg_det.codice_fiscale_fittizio_sinaaf, rel_stab_linea_det.codice_sinaaf, sogg_det.codice_fiscale))::text
	else ''
end as perIdFiscaleDet, 
case 
	when rel_stab_linea_det.id_linea_produttiva in (4,5,6,8) then regexp_replace(public.unaccent(coalesce(ind_det_can.via, '') ),'[\°\\''\²\/]',' ','g')
	else regexp_replace(public.unaccent(coalesce(ind_det.via, '') ),'[\°\\''\²\/]',' ','g') end as ubiIndirizzo, 
case 
	when rel_stab_linea_det.id_linea_produttiva in (4,5,6,8) then com_det_can.cod_comune::text
	else com_det.cod_comune::text end as ubiComIstat, 
case 
	when rel_stab_linea_det.id_linea_produttiva in (4,5,6,8) then upper(prov_det_can.cod_provincia)::text
	else upper(prov_det.cod_provincia)::text end as ubiProSigla,
case 
	when rel_stab_linea_det.id_linea_produttiva in (4,5,6,8) then case when ind_det_can.cap::text not ilike '%n.d%' then ind_det_can.cap::text else com_det_can.cap::text end 
	else case when ind_det.cap::text not ilike '%n.d%' then ind_det.cap::text else com_det.cap::text end  end as ubiCap,
 case when e_cattura.id_evento is not null then coalesce(to_char(e_cattura.data_cattura, 'dd-mm-yyyy'), '')::text 
       else coalesce(to_char(ev_bdu.data_registrazione, 'dd-mm-yyyy'), '')::text
  end  as ubiDtInizio,

  
'' as conferimentoPerIdFiscale
from evento ev
left join evento_registrazione_bdu ev_bdu on ev_bdu.id_evento = ev.id_evento 
left join opu_relazione_stabilimento_linee_produttive rel_stab_linea_prop on rel_stab_linea_prop.id = case when ev.id_proprietario_corrente is not null and ev.id_proprietario_corrente > 0 then ev.id_proprietario_corrente else ev_bdu.id_proprietario end  and rel_stab_linea_prop.trashed_date is null 
left join opu_relazione_stabilimento_linee_produttive rel_stab_linea_det on rel_stab_linea_det.id = case when ev.id_detentore_corrente is not null and ev.id_detentore_corrente > 0 then ev.id_detentore_corrente else ev_bdu.id_detentore_registrazione_bdu end and rel_stab_linea_det.trashed_date is null 
left join opu_stabilimento st_prop on st_prop.id = rel_stab_linea_prop.id_stabilimento
left join opu_stabilimento st_det  on st_det.id =  rel_stab_linea_det.id_stabilimento
left join opu_operatore op_prop on op_prop.id = st_prop.id_operatore and op_prop.trashed_date is null
left join opu_operatore op_det on op_det.id = st_det.id_operatore and op_det.trashed_date is null
left join opu_rel_operatore_soggetto_fisico rel_op_sogg_prop on rel_op_sogg_prop.id_operatore = op_prop.id and rel_op_sogg_prop.stato_ruolo = 1 and (rel_op_sogg_prop.enabled or rel_op_sogg_prop.enabled is null)
left join opu_rel_operatore_soggetto_fisico rel_op_sogg_det on rel_op_sogg_det.id_operatore = op_det.id and rel_op_sogg_det.stato_ruolo = 1 and (rel_op_sogg_det.enabled or rel_op_sogg_det.enabled is null)
left join opu_soggetto_fisico sogg_prop on sogg_prop.id = rel_op_sogg_prop.id_soggetto_fisico and sogg_prop.trashed_date is null 
left join opu_soggetto_fisico sogg_det on sogg_det.id = rel_op_sogg_det.id_soggetto_fisico and sogg_det.trashed_date is null
left join opu_indirizzo ind_prop on ind_prop.id = sogg_prop.indirizzo_id 
left join opu_indirizzo ind_det on ind_det.id = sogg_det.indirizzo_id 
left join opu_indirizzo ind_det_can on ind_det_can.id = st_det.id_indirizzo 
left join comuni1 com_prop on com_prop.id = ind_prop.comune
left join comuni1 com_det on com_det.id = ind_det.comune
left join comuni1 com_det_can on com_det_can.id = ind_det_can.comune
left join lookup_province prov_prop ON prov_prop.code::integer = com_prop.cod_provincia::integer
left join lookup_province prov_det ON prov_det.code::integer = com_det.cod_provincia::integer
left join lookup_province prov_det_can ON prov_det_can.code::integer = com_det_can.cod_provincia::integer
left join evento ev_cattura on ev_cattura.id_animale = ev.id_animale and ev_cattura.id_tipologia_evento = 5 and ev_cattura.data_cancellazione is null and ev_cattura.trashed_date is null and rel_stab_linea_prop.id_linea_produttiva in (3,7)
left join evento_cattura e_cattura on e_cattura.id_evento = ev_cattura.id_evento
where ev.trashed_date is null and ev.data_cancellazione is null and ev.id_evento = _idevento; 
 END;
$function$
;

CREATE OR REPLACE FUNCTION public.sinaaf_proprietario_get_envelope(_idevento integer)
 RETURNS text
 LANGUAGE plpgsql
 STRICT
AS $function$
DECLARE
	ret text;
BEGIN

select 
concat('{\"tipoPrp\": \"', tipoPrp,
'\",\"perIdFiscalePrp\": \"', perIdFiscalePrp, 
'\",\"canCodicePrp\": \"', canCodicePrp, 
'\",\"comIstatPrp\": \"', comIstatPrp, 
'\",\"proSiglaPrp\": \"', proSiglaPrp, 
'\",\"tipoDet\": \"', tipoDet, 
'\",\"canCodiceDet\": \"', canCodiceDet, 
'\",\"perIdFiscaleDet\": \"', perIdFiscaleDet, 
'\",\"ubiIndirizzo\": \"', ubiIndirizzo, 
'\",\"ubiComIstat\": \"', ubiComIstat, 
'\",\"ubiProSigla\": \"', ubiProSigla, 
'\",\"ubiCap\": \"', ubiCap, 
'\", \"ubiDtInizio\": \"', ubiDtInizio, 
'\", \"conferimentoPerIdFiscale\": \"', conferimentoPerIdFiscale, '\"}') into ret
from sinaaf_proprietario_get_dati_envelope(_idevento);

 RETURN ret;
 END;
$function$
;



CREATE OR REPLACE FUNCTION public.update_stato(tabella text, id_ws text, response json, campo_id_sinaaf_da_aggiornare_bdu text, valore_id_sinaaf_da_ws text, valore_codice_sinaaf_da_ws text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
declare 
tabella_ws text;
valore1 text;
valore2 text;
id_tabella1 text;
query text;
eveId text;
traId text;
ubiId text;
tab_strutt text;
BEGIN
	
if(tabella = 'evento')
then
tabella_ws = 'evento';
end if;	
	
if(tabella = 'opu_soggetto_fisico')
then
tabella_ws = 'proprietario';
end if;

if(tabella = 'microchips')
then
tabella_ws = 'giacenza';
end if;
 RAISE NOTICE 'tabella_ws: %', tabella_ws;

		
if(tabella = 'struttura')
then
tabella_ws = 'opu_relazione_stabilimento_linee_produttive';
tabella = 'opu_relazione_stabilimento_linee_produttive';
tab_strutt = 'struttura';
end if;
 RAISE NOTICE 'tabella_ws: %', tabella_ws;


valore1 = response->valore_id_sinaaf_da_ws::text;
valore2 = response->valore_codice_sinaaf_da_ws::text;

eveId = response->'eveId';
traId = response->'traId';
ubiId = response->'ubiId';


 RAISE NOTICE 'VALORE: %', valore1;

if (tab_strutt = 'struttura')then

select id_tabella into id_tabella1 from sinaaf_get_info_ws(id_ws,tab_strutt);

else
select id_tabella into id_tabella1 from sinaaf_get_info_ws(id_ws,tabella_ws);

end if;
 RAISE NOTICE 'tabella: %', tabella;



 RAISE NOTICE 'id_aggiorn: %', campo_id_sinaaf_da_aggiornare_bdu;

select REPLACE(valore2,'"','') into valore2::text;

if (tabella = 'evento') then
query = concat('update ',tabella,' set ',campo_id_sinaaf_da_aggiornare_bdu,'=''',valore1::text,''',codice_sinaaf =''',valore2, '''id_sinaaf_tra_id= ''',traId ,''' ,id_sinaaf_ubi_id=''',ubiId ,''' ,id_sinaaf_eve_id=''',eveId ,''' where ',id_tabella1,'::text=''',id_ws,''';');

else
query = concat('update ',tabella,' set ',campo_id_sinaaf_da_aggiornare_bdu,'=''',valore1::text,''',codice_sinaaf =''',valore2,''' where ',id_tabella1,'::text=''',id_ws,''';');
end if;


 RAISE NOTICE 'string: %', query;


execute query;	
	END;
$function$
;


CREATE OR REPLACE FUNCTION public.update_stato(tabella text, id_ws text, response json)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
declare 
valore_id_sinaaf_da_ws text;
valore_codice_sinaaf_da_ws text;
tabella_ws text;
valore1 text;
valore2 text;
id_tabella1 text;
query text;
BEGIN
	
if(tabella = 'evento')
then
tabella_ws = 'evento';
end if;	
	
if(tabella = 'opu_relazione_stabilimento_linee_produttive')
then
tabella_ws = 'proprietario';
end if;

if(tabella = 'microchips')
then
tabella_ws = 'giacenza';
end if;
 RAISE NOTICE 'tabella_ws: %', tabella_ws;

		
select nome_campo_id_sinaaf into valore_id_sinaaf_da_ws from sinaaf_get_info_ws(id_ws,tabella_ws);
select nome_campo_codice_sinaaf into valore_codice_sinaaf_da_ws from sinaaf_get_info_ws(id_ws,tabella_ws);
 RAISE NOTICE 'nome_campo: %', valore_id_sinaaf_da_ws;
 RAISE NOTICE 'nome_campo_cod: %', valore_codice_sinaaf_da_ws;
valore1 = response->valore_id_sinaaf_da_ws::text;
valore2 = response->valore_codice_sinaaf_da_ws::text;

select id_tabella into id_tabella1 from sinaaf_get_info_ws(id_ws,tabella_ws);



select REPLACE(valore2,'"','') into valore2::text;


query = concat('update ',tabella,' set ','id_sinaaf =''',valore1::text,''',codice_sinaaf =''',valore2,''' where ',id_tabella1,'::text=''',id_ws,''';');



 RAISE NOTICE 'string: %', query;


execute query;	
	END;
$function$
;


CREATE OR REPLACE FUNCTION public.sinaaf_strutture_detenzione_get_dati_envelope(_idstruttura text)
 RETURNS TABLE(canid text, cancodice text, cancodiceregione text, canragionesociale text, ticcodice text, prpidfiscale text, canprpdtinizioattivita text, prpcomistat text, prpprosigla text, gesidfiscale text, cangesdtinizioattivita text, comistat text, prosigla text, canindirizzo text, comcap text, candtregistrazione text, candtinizioattivita text, candtfineattivita text, canflagfineattivita text, cannumtelfisso text, cannumtelmobile text, cannumfax text, canemail text, cancapacita text, canlatitudine text, canlongitudine text, canflagprivato text, cannumdecreto text, flagpresenzacani text, flagpresenzagatti text, flagpresenzaaltrianimali text, flagstrutturabloccata text, aslcodice text, note text)
 LANGUAGE plpgsql
AS $function$

 BEGIN
    
   RETURN QUERY
select distinct lps.id_sinaaf as canId,
       lps.codice_sinaaf::text as canCodice,
       lps.id::text as canCodiceRegione,
 op.ragione_sociale::text as canRagioneSociale,
       codice_tipologia_struttura_sinac::text
       as ticCodice,
        case 
       when lps.id_linea_produttiva=40957 then
       sogg.codice_fiscale
       else ''::text end as prpIdFiscale,
       coalesce(to_char(lps.data_inizio, 'dd-mm-yyyy'), '')::text as canPrpDtInizioAttivita,
      case 
       when lps.id_linea_produttiva=40957 then
       case when com_stab.cod_comune != '-1' then com_stab.cod_comune::text else '' end
       else ''
       end as prpComIstat,
case 
       when lps.id_linea_produttiva=40957 then
       sogg.provincia_nascita
       else '' 
       end as prpProSigla,
        case when sogg.codice_fiscale in ('N.D.Amb.Isc', 'N.D', '00000000000') then '' 
            else sogg.codice_fiscale::text
       end as gesIdFiscale,
coalesce(to_char(lps.data_inizio, 'dd-mm-yyyy'), '')::text as canGesDtInizioAttivita,
        case when com_stab.cod_comune != '-1' then com_stab.cod_comune::text else '' end as comIstat,
       upper(provsedestab.cod_provincia)::text as proSigla,
regexp_replace(public.unaccent(coalesce(ind_stab.via, '') ),'[\°\\''\²\/]',' ','g') as canIndirizzo,
 coalesce( case when com_stab.cap != 'N.D' then com_stab.cap else null end  , case when ind_stab.cap != 'N.D' then ind_stab.cap else null end )::text as comCap,
'' as canDtRegistrazione,
coalesce(to_char(lps.data_inizio, 'dd-mm-yyyy'), to_char(op.entered, 'dd-mm-yyyy')) as canDtInizioAttivita,
       coalesce(to_char(lps.data_fine, 'dd-mm-yyyy'), '') as canDtFineAttivita,
 '' as canFlagFineAttivita,
sogg.telefono::text as canNumTelFisso,
       lps.telefono2::text as canNumTelMobile,
       '' as canNumFax,
       lps.mail1 as canEmail,
       LEAST(aads.capacita_struttura_mq::integer / 3.5, 350)::numeric::integer::text
        as canCapacita,
substring(ind_stab.latitudine::text,1,8)  as canLatitudine,
 substring(ind_stab.longitudine::text,1,8) as canLongitudine,
 'N' as canFlagPrivato,
'' as canNumDecreto,
case when 
aads.flag_presenza_cani = true then 'S' else 'N'   end as flagPresenzaCani,
  case when 
aads.flag_presenza_gatti = true then 'S' else 'N'       end as flagPresenzaGatti,
       'N' as flagPresenzaAltriAnimali,
'N' as flagStrutturaBloccata,
'R' || asl.codiceistat as aslCodice,	
       '' as canNote
from opu_operatore op 
left join opu_rel_operatore_soggetto_fisico rel_sogg on rel_sogg.id_operatore = op.id and (rel_sogg.enabled or rel_sogg.enabled is null) and (rel_sogg.data_fine is null or rel_sogg.data_fine > current_timestamp)
left join opu_soggetto_fisico sogg on sogg.id = rel_sogg.id_soggetto_fisico and sogg.trashed_date is null 
left join opu_stabilimento stab on op.id = stab.id_operatore
left join opu_indirizzo ind_stab on ind_stab.id = stab.id_indirizzo
left join comuni1 com_stab on com_stab.id = ind_stab.comune 
left join lookup_site_id asl on asl.code::text = com_stab.codiceistatasl
left join lookup_province provsedestab ON provsedestab.code = com_stab.cod_provincia::integer
left join opu_relazione_stabilimento_linee_produttive lps on lps.id_stabilimento = stab.id 
left join struttura_detenzione_dati_sinaaf aads on lps.id = aads.id_rel_stab 
left join master_list_flag_linee_attivita pp2 on pp2.id_linea = lps.id_linea_produttiva 
where op.trashed_date is null and lps.id::text = _idstruttura;   
 END;
$function$
;


CREATE OR REPLACE FUNCTION public.ws_insert_storico_chiamate(url_input text, ws_request text, ws_response text, user_id integer, id_tabella_input text, tabella_input text, esito_input text, metodo_input text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
 BEGIN
       insert into ws_storico_chiamate(url, request, response, id_utente, data, id_tabella, tabella, esito,metodo) values (url_input, ws_request, ws_response, user_id, now(), id_tabella_input,case when tabella_input = 'struttura' then 'opu_relazione_stabilimento_linee_produttive' else tabella_input end,esito_input, metodo_input);
END;
$function$
;


ALTER TABLE public.master_list_flag_linee_attivita ADD codice_tipologia_struttura_sinac varchar NULL;

CREATE OR REPLACE FUNCTION public.unaccent(text)
 RETURNS text
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/unaccent', $function$unaccent_dict$function$
;

CREATE OR REPLACE FUNCTION public.unaccent(regdictionary, text)
 RETURNS text
 LANGUAGE c
 STABLE PARALLEL SAFE STRICT
AS '$libdir/unaccent', $function$unaccent_dict$function$
;

CREATE OR REPLACE FUNCTION public.insert_storico_chiamate_g2b(url_input text, request text, response_ text, id_tabella_ text, tabella_input text, caller_ text, endpoint_ text, esito_ text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
 begin
	 
       insert into storico_chiamate_g2b(url, request_dbi , response, "data", id_tabella, tabella, caller,endpoint,esito) values (url_input, request, response_,  now(), id_tabella_,case when tabella_input = 'struttura' then 'opu_relazione_stabilimento_linee_produttive' else tabella_input end,caller_, endpoint_,esito_);
END;
$function$
;


CREATE TABLE public.sinaaf_nazioni_codici_iso (
	denominazione_it varchar NULL,
	codice_at varchar NULL,
	codice_iso_alpha2 varchar NULL,
	codice_iso_alpha3 varchar NULL,
	code serial4 NOT NULL,
	default_item bool NULL DEFAULT false,
	"level" int4 NULL DEFAULT 0,
	enabled bool NULL DEFAULT true,
	entered timestamp NULL,
	modified timestamp NULL,
	CONSTRAINT sinaaf_nazioni_codici_istat PRIMARY KEY (code)
);


ALTER TABLE public.opu_soggetto_fisico ADD codice_fiscale_fittizio text NULL;



CREATE EXTENSION unaccent
  SCHEMA public
  VERSION "1.1";


ALTER TABLE public.opu_soggetto_fisico ADD codice_fiscale_fittizio_sinaaf text NULL;

ALTER TABLE public.opu_soggetto_fisico ADD id_sinaaf text NULL;

ALTER TABLE public.opu_soggetto_fisico ADD codice_sinaaf text NULL;

ALTER TABLE public.opu_soggetto_fisico ADD modified_sinaaf timestamp NULL;

ALTER TABLE public.opu_soggetto_fisico ADD sinaaf_estrazione_invio_pregresso_ok timestamp NULL;




CREATE OR REPLACE FUNCTION public_functions.suap_inserisci_canile_bdu(idstabilimentogisa integer)
 RETURNS integer
 LANGUAGE plpgsql
 STRICT
AS $function$
DECLARE
id_impresa integer;
id_soggetto_out integer;
id_stab_out integer;
id_stabl_out integer;
esito text;
esito_estesi text;
id_rel_stab_lp_gisa int ;
idStabBdu int ;
idLineaBdu int ;
idlineaGisa int ;
specieAnimaliOpComm text;
trasmettiBdu boolean;

codiceUnivoco text;

flagOpComm boolean ;
flagCanile boolean;
BEGIN


select st.id into idStabBdu from opu_stabilimento st join opu_operatore op on op.id=st.id_operatore 
where id_stabilimento_gisa =idstabilimentogisa and op.trashed_date is null;

flagCanile:=false;
flagOpComm:=false;
trasmettiBdu:=false;

for idLineaBdu , idlineaGisa in
select distinct on (id_linea_bdu) id_linea_bdu,id_linea_attivita 
from opu_operatori_denormalizzati_canili_opc_gisa v 
where v.id_stabilimento = idstabilimentogisa

loop

raise info 'id_linea_bdu %',idLineaBdu;
raise info 'id_linea_attivita gisa  %',idlineaGisa;

select ml.codice_attivita into codiceUnivoco from r_gisa_opu_relazione_stabilimento_linee_produttive rel join r_ml8_linee_attivita_nuove_materializzata ml on rel.id_linea_produttiva = ml.id_nuova_linea_attivita where rel.id = idlineaGisa;

raise info 'codiceUnivoco %',codiceUnivoco;


if codiceUnivoco in('IUV-CODAC-VEDCG','IUV-COIAC-VEICG', '349-93-ALPET-PRIV', '349-93-ALCAT-PRIV', '349-93-ALPET-ALTR', '349-93-ALCAT-ALTR', 
--new
'IUV-CODAC-DET', 'IUV-COIAC-INGINF', 'IUV-COIAC-INGSUP','ASSANIM')
then
trasmettiBdu:=true ;
flagOpComm:=true;
end if;

--aggiornamento per ml10: sono canili tutti quelli che hanno come aggregazione CAN più quelli già contemplati precedentemente
if codiceUnivoco in('IUV-CAN-CAN','VET-AMBV-PU','VET-CLIV-PU', 'VET-OSPV-PU','IUV-CAN-ALLGAT', 'IUV-CAN-ALLCAN', 'IUV-CAN-RIFRIC', 'IUV-CAN-RIFSAN', 'IUV-CAN-PEN','IUV-CAN-AAF','IUV-ADCA-ADCA','ASSANIM-ASSANIM-ASSANIM') 
then
trasmettiBdu:=true ;
flagCanile:=true;
end if;

/*if codiceUnivoco in('IUV-CODAC-VEDCG','IUV-COIAC-VEICG', '349-93-ALPET-ALTR', '349-93-ALCAT-ALTR')
then
trasmettiBdu:=true ;
flagOpComm:=true;
end if;

if codiceUnivoco in('IUV-CAN-CAN','VET-AMBV-PU','VET-CLIV-PU', 'VET-OSPV-PU') 
then
trasmettiBdu:=true ;
flagCanile:=true;
end if;*/

end loop ;


raise info 'presenti cani gatti o furetti ? %',trasmettiBdu;
raise info 'idStabBdu: %', idStabBdu;
if idStabBdu is null or idStabBdu <=0
then


raise info 'flagCanile: %', flagCanile;
if flagCanile =true or (flagOpComm=true and trasmettiBdu=true)
then
-- 1. soggetto fisico ed indirizzo rappresentante legale che ritorna id_soggetto fisico
id_soggetto_out := (select * from public_functions.insert_soggetto_fisico_bdu(idStabilimentoGisa));

--2 impresa in relazione al soggetto fisico e all'indirizzo restituisce una tupla con id operatore partita_iva, ragione sociale e cf...
id_impresa := (select id from public_functions.suap_insert_impresa_bdu(idStabilimentoGisa,id_soggetto_out));
-- 3 stabilimento restituisce l'id dello stabilimento
id_stab_out := (select * from public_functions.suap_inserisci_stabilimento_bdu(id_impresa,idStabilimentoGisa));
-- 4 linea produttiva, esegue una insert e restituisce un booleano. 5 è un canile, 6 l'operatore commerciale
raise info 'select * from public_functions.suap_insert_linea_produttiva(%,%)', id_stab_out,idStabilimentoGisa;
id_stabl_out := (select * from public_functions.suap_insert_linea_produttiva(id_stab_out,idStabilimentoGisa));
--aggiornamento del soggetto fisico responsabile della sede produttiva
--update opu_stabilimento set id_soggetto_fisico  = id_soggetto_out where id = id_stab_out;
--aggiornamento vista materializzato tramite id_impresa
--aggiornamento informazioni canile da gisa campi estesi a canili bdu


if  flagCanile =true 
then


id_rel_stab_lp_gisa:=(
select distinct on(id_linea_bdu) id_linea_attivita 
from opu_operatori_denormalizzati_canili_opc_gisa 
where id_linea_bdu = 5 
and id_stabilimento = idStabilimentoGisa
);



raise info '(select * from public_functions.aggiorna_info_canile(%,%,%))', id_rel_stab_lp_gisa::int, id_stab_out, id_stabl_out;
esito_estesi:= (select * from public_functions.aggiorna_info_canile(id_rel_stab_lp_gisa::int, id_stab_out, id_stabl_out));
end if;

if flagOpComm =true
then 
id_rel_stab_lp_gisa:=(select distinct on(id_linea_bdu) id_linea_attivita from opu_operatori_denormalizzati_canili_opc_gisa where id_linea_bdu=6 and id_stabilimento = idStabilimentoGisa);
esito_estesi:= (select * from public_functions.aggiorna_info_operatore(id_rel_stab_lp_gisa::int, id_stab_out));
end if;


delete from opu_operatori_denormalizzati where id_opu_operatore =id_impresa;
esito := (select * from public_functions.update_opu_materializato(id_impresa));

return id_impresa;
end if;
end if;
return id_impresa;
 END;
$function$
;


UPDATE public.master_list_flag_linee_attivita
SET  codice_tipologia_struttura_sinac='TC00'
WHERE id=1122;

















CREATE OR REPLACE VIEW public.opu_operatori_denormalizzati_view_bdu
AS SELECT opu_operatori_denormalizzati_view.flag_dia,
    opu_operatori_denormalizzati_view.id_opu_operatore,
    opu_operatori_denormalizzati_view.ragione_sociale,
    opu_operatori_denormalizzati_view.partita_iva,
    opu_operatori_denormalizzati_view.codice_fiscale_impresa,
    opu_operatori_denormalizzati_view.indirizzo_sede_legale,
    opu_operatori_denormalizzati_view.comune_sede_legale,
    opu_operatori_denormalizzati_view.istat_legale,
    opu_operatori_denormalizzati_view.cap_sede_legale,
    opu_operatori_denormalizzati_view.prov_sede_legale,
    opu_operatori_denormalizzati_view.note,
    opu_operatori_denormalizzati_view.entered,
    opu_operatori_denormalizzati_view.modified,
    opu_operatori_denormalizzati_view.enteredby,
    opu_operatori_denormalizzati_view.modifiedby,
    opu_operatori_denormalizzati_view.domicilio_digitale,
    opu_operatori_denormalizzati_view.flag_ric_ce,
    opu_operatori_denormalizzati_view.num_ric_ce,
    opu_operatori_denormalizzati_view.comune,
    opu_operatori_denormalizzati_view.id_asl,
    opu_operatori_denormalizzati_view.id_stabilimento,
    opu_operatori_denormalizzati_view.esito_import,
    opu_operatori_denormalizzati_view.data_import,
    opu_operatori_denormalizzati_view.cun,
    opu_operatori_denormalizzati_view.id_sinvsa,
    opu_operatori_denormalizzati_view.descrizione_errore,
    opu_operatori_denormalizzati_view.comune_stab,
    opu_operatori_denormalizzati_view.istat_operativo,
    opu_operatori_denormalizzati_view.indirizzo_stab,
    opu_operatori_denormalizzati_view.cap_stab,
    opu_operatori_denormalizzati_view.prov_stab,
    opu_operatori_denormalizzati_view.data_fine_dia,
    opu_operatori_denormalizzati_view.categoria_rischio,
    opu_operatori_denormalizzati_view.cf_rapp_sede_legale,
    opu_operatori_denormalizzati_view.nome_rapp_sede_legale,
    opu_operatori_denormalizzati_view.cognome_rapp_sede_legale,
    opu_operatori_denormalizzati_view.codice_registrazione,
    opu_operatori_denormalizzati_view.id_norma,
    opu_operatori_denormalizzati_view.cf_correntista,
    opu_operatori_denormalizzati_view.codice_attivita,
    opu_operatori_denormalizzati_view.primario,
    opu_operatori_denormalizzati_view.attivita,
    opu_operatori_denormalizzati_view.data_inizio,
    opu_operatori_denormalizzati_view.data_fine,
    opu_operatori_denormalizzati_view.numero_registrazione,
    opu_operatori_denormalizzati_view.indirizzo_rapp_sede_legale,
    opu_operatori_denormalizzati_view.stato,
    opu_operatori_denormalizzati_view.solo_attivita,
    opu_operatori_denormalizzati_view.data_inizio_attivita,
    opu_operatori_denormalizzati_view.data_fine_attivita,
    opu_operatori_denormalizzati_view.data_prossimo_controllo,
    opu_operatori_denormalizzati_view.id_stato,
    opu_operatori_denormalizzati_view.path_attivita_completo,
    opu_operatori_denormalizzati_view.id_indirizzo,
    opu_operatori_denormalizzati_view.linee_pregresse,
    opu_operatori_denormalizzati_view.flag_nuova_gestione,
    opu_operatori_denormalizzati_view.tipo_impresa,
    opu_operatori_denormalizzati_view.tipo_societa,
    opu_operatori_denormalizzati_view.codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.id_asl_stab,
    opu_operatori_denormalizzati_view.id_linea_attivita,
    opu_operatori_denormalizzati_view.data_mod_attivita,
    opu_operatori_denormalizzati_view.stab_entered,
    opu_operatori_denormalizzati_view.linea_numero_registrazione,
    opu_operatori_denormalizzati_view.linea_stato,
    opu_operatori_denormalizzati_view.linea_stato_text,
    opu_operatori_denormalizzati_view.linea_codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.stab_codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.id_indirizzo_operatore,
    opu_operatori_denormalizzati_view.import_opu,
    opu_operatori_denormalizzati_view.id_linea_attivita_stab,
    opu_operatori_denormalizzati_view.note_operatore,
    opu_operatori_denormalizzati_view.note_stabilimento,
    opu_operatori_denormalizzati_view.linea_codice_nazionale,
    opu_operatori_denormalizzati_view.flag_pnaa,
    opu_operatori_denormalizzati_view.stab_inserito_da,
    opu_operatori_denormalizzati_view.stab_id_attivita,
    opu_operatori_denormalizzati_view.stab_descrizione_attivita,
    opu_operatori_denormalizzati_view.stab_id_carattere,
    opu_operatori_denormalizzati_view.stab_descrizione_carattere,
    opu_operatori_denormalizzati_view.impresa_id_tipo_impresa,
    opu_operatori_denormalizzati_view.stab_asl,
    opu_operatori_denormalizzati_view.flag_clean,
    opu_operatori_denormalizzati_view.data_generazione_numero,
    opu_operatori_denormalizzati_view.lat_stab,
    opu_operatori_denormalizzati_view.long_stab,
    opu_operatori_denormalizzati_view.linea_entered,
    opu_operatori_denormalizzati_view.linea_modified,
    opu_operatori_denormalizzati_view.macroarea,
    opu_operatori_denormalizzati_view.aggregazione,
    opu_operatori_denormalizzati_view.attivita_xml,
    opu_operatori_denormalizzati_view.codiceistatasl_old,
    opu_operatori_denormalizzati_view.sigla_prov_operativa,
    opu_operatori_denormalizzati_view.sigla_prov_legale,
    opu_operatori_denormalizzati_view.sigla_prov_soggfisico,
    opu_operatori_denormalizzati_view.comune_residenza,
    opu_operatori_denormalizzati_view.data_nascita_rapp_sede_legale,
    opu_operatori_denormalizzati_view.impresa_id_tipo_societa,
    opu_operatori_denormalizzati_view.comune_nascita_rapp_sede_legale,
    opu_operatori_denormalizzati_view.sesso,
    opu_operatori_denormalizzati_view.civico,
    opu_operatori_denormalizzati_view.toponimo_residenza,
    opu_operatori_denormalizzati_view.id_toponimo_residenza,
    opu_operatori_denormalizzati_view.civico_sede_legale,
    opu_operatori_denormalizzati_view.tiponimo_sede_legale,
    opu_operatori_denormalizzati_view.toponimo_sede_legale,
    opu_operatori_denormalizzati_view.civico_sede_stab,
    opu_operatori_denormalizzati_view.tiponimo_sede_stab,
    opu_operatori_denormalizzati_view.toponimo_sede_stab,
    opu_operatori_denormalizzati_view.via_rapp_sede_legale,
    opu_operatori_denormalizzati_view.via_sede_legale,
    opu_operatori_denormalizzati_view.id_comune_richiesta,
    opu_operatori_denormalizzati_view.comune_richiesta,
    opu_operatori_denormalizzati_view.via_stabilimento_calcolata,
    opu_operatori_denormalizzati_view.civico_stabilimento_calcolato,
    opu_operatori_denormalizzati_view.cap_residenza,
    opu_operatori_denormalizzati_view.nazione_residenza,
    opu_operatori_denormalizzati_view.nazione_sede_legale,
    opu_operatori_denormalizzati_view.nazione_stab,
    opu_operatori_denormalizzati_view.id_lookup_tipo_linee_mobili,
    opu_operatori_denormalizzati_view.id_tipo_linea_produttiva,
    opu_operatori_denormalizzati_view.id_soggetto_fisico,
        CASE
            WHEN opu_operatori_denormalizzati_view.codice_attivita = ANY (ARRAY['IUV-CAN-PEN'::text, 'IUV-CAN-CAN'::text, 'VET-AMBV-PU'::text, 'VET-CLIV-PU'::text, 'VET-OSPV-PU'::text, 'IUV-CAN-ALLCAN'::text, 'IUV-CAN-ALLGAT'::text, 'IUV-ADCA-ADCA'::text, 'IUV-CAN-RIFRIC'::text, 'IUV-CAN-RIFSAN'::text, 'IUV-CAN-AAF'::text, 'ASSANIM-ASSANIM-ASSANIM'::text]) THEN 5
            WHEN opu_operatori_denormalizzati_view.codice_attivita = ANY (ARRAY['IUV-CODAC-VEDCG'::text, 'IUV-COIAC-VEICG'::text, '349-93-ALPET-PRIV'::text, '349-93-ALCAT-PRIV'::text, '349-93-ALPET-ALTR'::text, '349-93-ALCAT-ALTR'::text, 'IUV-CODAC-DET'::text, 'IUV-COIAC-INGINF'::text, 'IUV-COIAC-INGSUP'::text]) THEN 6
            ELSE NULL::integer
        END AS id_linea_bdu
   FROM opu_operatori_denormalizzati_view
     LEFT JOIN master_list_flag_linee_attivita ON master_list_flag_linee_attivita.id_linea = opu_operatori_denormalizzati_view.id_linea_attivita_stab
  WHERE master_list_flag_linee_attivita.bdu = true;




CREATE OR REPLACE VIEW public.opu_operatori_denormalizzati_view_canili_bdu
AS SELECT opu_operatori_denormalizzati_view.flag_dia,
    opu_operatori_denormalizzati_view.id_opu_operatore,
    opu_operatori_denormalizzati_view.ragione_sociale,
    opu_operatori_denormalizzati_view.partita_iva,
    opu_operatori_denormalizzati_view.codice_fiscale_impresa,
    opu_operatori_denormalizzati_view.indirizzo_sede_legale,
    opu_operatori_denormalizzati_view.comune_sede_legale,
    opu_operatori_denormalizzati_view.istat_legale,
    opu_operatori_denormalizzati_view.cap_sede_legale,
    opu_operatori_denormalizzati_view.prov_sede_legale,
    opu_operatori_denormalizzati_view.note,
    opu_operatori_denormalizzati_view.entered,
    opu_operatori_denormalizzati_view.modified,
    opu_operatori_denormalizzati_view.enteredby,
    opu_operatori_denormalizzati_view.modifiedby,
    opu_operatori_denormalizzati_view.domicilio_digitale,
    opu_operatori_denormalizzati_view.flag_ric_ce,
    opu_operatori_denormalizzati_view.num_ric_ce,
    opu_operatori_denormalizzati_view.comune,
    opu_operatori_denormalizzati_view.id_asl,
    opu_operatori_denormalizzati_view.id_stabilimento,
    opu_operatori_denormalizzati_view.esito_import,
    opu_operatori_denormalizzati_view.data_import,
    opu_operatori_denormalizzati_view.cun,
    opu_operatori_denormalizzati_view.id_sinvsa,
    opu_operatori_denormalizzati_view.descrizione_errore,
    opu_operatori_denormalizzati_view.comune_stab,
    opu_operatori_denormalizzati_view.istat_operativo,
    opu_operatori_denormalizzati_view.indirizzo_stab,
    opu_operatori_denormalizzati_view.cap_stab,
    opu_operatori_denormalizzati_view.prov_stab,
    opu_operatori_denormalizzati_view.data_fine_dia,
    opu_operatori_denormalizzati_view.categoria_rischio,
    opu_operatori_denormalizzati_view.cf_rapp_sede_legale,
    opu_operatori_denormalizzati_view.nome_rapp_sede_legale,
    opu_operatori_denormalizzati_view.cognome_rapp_sede_legale,
    opu_operatori_denormalizzati_view.codice_registrazione,
    opu_operatori_denormalizzati_view.id_norma,
    opu_operatori_denormalizzati_view.cf_correntista,
    opu_operatori_denormalizzati_view.codice_attivita,
    opu_operatori_denormalizzati_view.primario,
    opu_operatori_denormalizzati_view.attivita,
    opu_operatori_denormalizzati_view.data_inizio,
    opu_operatori_denormalizzati_view.data_fine,
    opu_operatori_denormalizzati_view.numero_registrazione,
    opu_operatori_denormalizzati_view.indirizzo_rapp_sede_legale,
    opu_operatori_denormalizzati_view.stato,
    opu_operatori_denormalizzati_view.solo_attivita,
    opu_operatori_denormalizzati_view.data_inizio_attivita,
    opu_operatori_denormalizzati_view.data_fine_attivita,
    opu_operatori_denormalizzati_view.data_prossimo_controllo,
    opu_operatori_denormalizzati_view.id_stato,
    opu_operatori_denormalizzati_view.path_attivita_completo,
    opu_operatori_denormalizzati_view.id_indirizzo,
    opu_operatori_denormalizzati_view.linee_pregresse,
    opu_operatori_denormalizzati_view.flag_nuova_gestione,
    opu_operatori_denormalizzati_view.tipo_impresa,
    opu_operatori_denormalizzati_view.tipo_societa,
    opu_operatori_denormalizzati_view.codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.id_asl_stab,
    opu_operatori_denormalizzati_view.id_linea_attivita,
    opu_operatori_denormalizzati_view.data_mod_attivita,
    opu_operatori_denormalizzati_view.stab_entered,
    opu_operatori_denormalizzati_view.linea_numero_registrazione,
    opu_operatori_denormalizzati_view.linea_stato,
    opu_operatori_denormalizzati_view.linea_stato_text,
    opu_operatori_denormalizzati_view.linea_codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.stab_codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.id_indirizzo_operatore,
    opu_operatori_denormalizzati_view.import_opu,
    opu_operatori_denormalizzati_view.id_linea_attivita_stab,
    opu_operatori_denormalizzati_view.note_operatore,
    opu_operatori_denormalizzati_view.note_stabilimento,
    opu_operatori_denormalizzati_view.linea_codice_nazionale,
    opu_operatori_denormalizzati_view.flag_pnaa,
    opu_operatori_denormalizzati_view.stab_inserito_da,
    opu_operatori_denormalizzati_view.stab_id_attivita,
    opu_operatori_denormalizzati_view.stab_descrizione_attivita,
    opu_operatori_denormalizzati_view.stab_id_carattere,
    opu_operatori_denormalizzati_view.stab_descrizione_carattere,
    opu_operatori_denormalizzati_view.impresa_id_tipo_impresa,
    opu_operatori_denormalizzati_view.stab_asl,
    opu_operatori_denormalizzati_view.flag_clean,
    opu_operatori_denormalizzati_view.data_generazione_numero,
    opu_operatori_denormalizzati_view.lat_stab,
    opu_operatori_denormalizzati_view.long_stab,
    opu_operatori_denormalizzati_view.linea_entered,
    opu_operatori_denormalizzati_view.linea_modified,
    opu_operatori_denormalizzati_view.macroarea,
    opu_operatori_denormalizzati_view.aggregazione,
    opu_operatori_denormalizzati_view.attivita_xml,
    opu_operatori_denormalizzati_view.codiceistatasl_old,
    opu_operatori_denormalizzati_view.sigla_prov_operativa,
    opu_operatori_denormalizzati_view.sigla_prov_legale,
    opu_operatori_denormalizzati_view.sigla_prov_soggfisico,
    opu_operatori_denormalizzati_view.comune_residenza,
    opu_operatori_denormalizzati_view.data_nascita_rapp_sede_legale,
    opu_operatori_denormalizzati_view.impresa_id_tipo_societa,
    opu_operatori_denormalizzati_view.comune_nascita_rapp_sede_legale,
    opu_operatori_denormalizzati_view.sesso,
    opu_operatori_denormalizzati_view.civico,
    opu_operatori_denormalizzati_view.toponimo_residenza,
    opu_operatori_denormalizzati_view.id_toponimo_residenza,
    opu_operatori_denormalizzati_view.civico_sede_legale,
    opu_operatori_denormalizzati_view.tiponimo_sede_legale,
    opu_operatori_denormalizzati_view.toponimo_sede_legale,
    opu_operatori_denormalizzati_view.civico_sede_stab,
    opu_operatori_denormalizzati_view.tiponimo_sede_stab,
    opu_operatori_denormalizzati_view.toponimo_sede_stab,
    opu_operatori_denormalizzati_view.via_rapp_sede_legale,
    opu_operatori_denormalizzati_view.via_sede_legale,
    opu_operatori_denormalizzati_view.id_comune_richiesta,
    opu_operatori_denormalizzati_view.comune_richiesta,
    opu_operatori_denormalizzati_view.via_stabilimento_calcolata,
    opu_operatori_denormalizzati_view.civico_stabilimento_calcolato,
    opu_operatori_denormalizzati_view.cap_residenza,
    opu_operatori_denormalizzati_view.nazione_residenza,
    opu_operatori_denormalizzati_view.nazione_sede_legale,
    opu_operatori_denormalizzati_view.nazione_stab,
    opu_operatori_denormalizzati_view.id_lookup_tipo_linee_mobili,
    opu_operatori_denormalizzati_view.id_tipo_linea_produttiva,
    opu_operatori_denormalizzati_view.id_soggetto_fisico,
        CASE
            WHEN opu_operatori_denormalizzati_view.codice_attivita = ANY (ARRAY['IUV-CAN-PEN'::text, 'IUV-CAN-CAN'::text, 'VET-AMBV-PU'::text, 'VET-CLIV-PU'::text, 'VET-OSPV-PU'::text, 'IUV-CAN-ALLCAN'::text, 'IUV-CAN-ALLGAT'::text, 'IUV-ADCA-ADCA'::text, 'IUV-CAN-RIFRIC'::text, 'IUV-CAN-RIFSAN'::text, 'IUV-CAN-AAF'::text, 'ASSANIM-ASSANIM-ASSANIM'::text]) THEN 5
            WHEN opu_operatori_denormalizzati_view.codice_attivita = ANY (ARRAY['IUV-CODAC-VEDCG'::text, 'IUV-COIAC-VEICG'::text, '349-93-ALPET-PRIV'::text, '349-93-ALCAT-PRIV'::text, '349-93-ALPET-ALTR'::text, '349-93-ALCAT-ALTR'::text, 'IUV-CODAC-DET'::text, 'IUV-COIAC-INGINF'::text, 'IUV-COIAC-INGSUP'::text]) THEN 6
            ELSE NULL::integer
        END AS id_linea_bdu
   FROM opu_operatori_denormalizzati_view
     LEFT JOIN master_list_flag_linee_attivita ON master_list_flag_linee_attivita.id_linea = opu_operatori_denormalizzati_view.id_linea_attivita_stab
  WHERE master_list_flag_linee_attivita.bdu = true AND (opu_operatori_denormalizzati_view.codice_attivita = ANY (ARRAY['IUV-CAN-PEN'::text, 'IUV-CAN-CAN'::text, 'IUV-CAN-ALLCAN'::text, 'IUV-CAN-ALLGAT'::text, 'IUV-ADCA-ADCA'::text, 'IUV-CAN-RIFRIC'::text, 'IUV-CAN-RIFSAN'::text, 'IUV-CAN-AAF'::text]));
       
     UPDATE public.configuratore_template_no_scia
SET html_label='INSERISCI INDIRIZZO', html_enabled=true, sql_campo=NULL, sql_origine=NULL, sql_condizione=NULL, html_ordine='bn', html_type='button', sql_campo_lookup=NULL, sql_origine_lookup=NULL, sql_condizione_lookup=NULL, html_name='ins_indirizzo_residenza_rapp_legale', mapping_field='ins_indirizzo_residenza_rapp_legale', oid_parent=17, html_style='required="true"', html_event='onclick="
		openCapWidget(''toponimo_residenza_rapp_legale'',''topIdResidenzaRappLegale'',
			      ''via_residenza_rapp_legale'',''civico_residenza_rapp_legale'',
			      ''comune_residenza_rapp_legale'',''comuneIdResidenzaRappLegale'',
			      ''cap_residenza_rapp_legale'',''provincia_residenza_rapp_legale'',
			      ''provinciaIdResidenzaRappLegale'')"'
WHERE id=87;







CREATE OR REPLACE VIEW public.opu_operatori_denormalizzati_view
AS SELECT DISTINCT
        CASE
            WHEN stab.flag_dia IS NOT NULL THEN stab.flag_dia
            ELSE false
        END AS flag_dia,
    o.id AS id_opu_operatore,
    o.ragione_sociale,
    o.partita_iva,
    o.codice_fiscale_impresa,
    (((
        CASE
            WHEN topsedeop.description IS NOT NULL THEN topsedeop.description
            ELSE ''::character varying
        END::text || ' '::text) || sedeop.via::text) || ' '::text) ||
        CASE
            WHEN sedeop.civico IS NOT NULL THEN sedeop.civico
            ELSE ''::text
        END AS indirizzo_sede_legale,
    comunisl.nome AS comune_sede_legale,
    comunisl.istat AS istat_legale,
    sedeop.cap AS cap_sede_legale,
    provsedeop.description AS prov_sede_legale,
    o.note,
    o.entered,
    o.modified,
    o.enteredby,
    o.modifiedby,
    o.domicilio_digitale,
    o.flag_ric_ce,
    o.num_ric_ce,
    i.comune,
    stab.id_asl,
    stab.id AS id_stabilimento,
    stab.esito_import,
    stab.data_import,
    stab.cun,
    stab.id_sinvsa,
    stab.descrizione_errore,
    comuni1.nome AS comune_stab,
    comuni1.istat AS istat_operativo,
    ((
        CASE
            WHEN topsedestab.description IS NOT NULL THEN topsedestab.description
            ELSE ''::character varying
        END::text || ' '::text) || sedestab.via::text) || ' '::text AS indirizzo_stab,
    sedestab.cap AS cap_stab,
    provsedestab.description AS prov_stab,
    stab.data_fine_dia,
    stab.categoria_rischio,
    soggsl.codice_fiscale AS cf_rapp_sede_legale,
    soggsl.nome AS nome_rapp_sede_legale,
    soggsl.cognome AS cognome_rapp_sede_legale,
    stab.numero_registrazione AS codice_registrazione,
    latt.id_norma,
    latt.codice_attivita AS cf_correntista,
    latt.codice AS codice_attivita,
    lps.primario,
    (((latt.macroarea || '->'::text) || latt.aggregazione) || '->'::text) || latt.attivita AS attivita,
    lps.data_inizio,
    lps.data_fine,
    stab.numero_registrazione,
    concat_ws(' '::text, topsoggind.description, soggind.via, soggind.civico,
        CASE
            WHEN comunisoggind.id > 0 THEN comunisoggind.nome::text
            ELSE soggind.comune_testo
        END, concat('(', provsoggind.cod_provincia, ')'), soggind.cap) AS indirizzo_rapp_sede_legale,
    stati.description AS stato,
    latt.attivita AS solo_attivita,
    stab.data_inizio_attivita,
    stab.data_fine_attivita,
    stab.data_prossimo_controllo,
    stab.stato AS id_stato,
    latt.path_descrizione AS path_attivita_completo,
    stab.id_indirizzo,
    stab.linee_pregresse,
    true AS flag_nuova_gestione,
    loti.description AS tipo_impresa,
    lotis.description AS tipo_societa,
    stab.codice_ufficiale_esistente,
    stab.id_asl AS id_asl_stab,
    lps.id AS id_linea_attivita,
    lps.modified AS data_mod_attivita,
    stab.entered AS stab_entered,
    lps.numero_registrazione AS linea_numero_registrazione,
    lps.stato AS linea_stato,
    statilinea.description AS linea_stato_text,
    lps.codice_ufficiale_esistente AS linea_codice_ufficiale_esistente,
    stab.codice_ufficiale_esistente AS stab_codice_ufficiale_esistente,
    sedeop.id AS id_indirizzo_operatore,
    stab.import_opu,
    lps.id_linea_produttiva AS id_linea_attivita_stab,
    o.note AS note_operatore,
    stab.note AS note_stabilimento,
    lps.codice_nazionale AS linea_codice_nazionale,
    latt.flag_pnaa,
    (con.namefirst::text || ' '::text) || con.namelast::text AS stab_inserito_da,
        CASE
            WHEN ml.fisso THEN 1
            WHEN stab.tipo_attivita = 1 THEN 1
            WHEN ml.mobile OR latt.codice_macroarea = 'MS.090'::text THEN 2
            WHEN stab.tipo_attivita = 2 THEN 2
            ELSE '-1'::integer
        END AS stab_id_attivita,
        CASE
            WHEN ml.fisso THEN 'Con Sede Fissa'::text
            WHEN stab.tipo_attivita = 1 THEN 'Con Sede Fissa'::text
            WHEN ml.mobile OR latt.codice_macroarea = 'MS.090'::text THEN 'Senza Sede Fissa'::text
            WHEN stab.tipo_attivita = 2 THEN 'Senza Sede Fissa'::text
            ELSE 'N.D.'::text
        END AS stab_descrizione_attivita,
    stab.tipo_carattere AS stab_id_carattere,
    lsc.description AS stab_descrizione_carattere,
    o.tipo_impresa AS impresa_id_tipo_impresa,
    asl.description AS stab_asl,
    o.flag_clean,
    stab.data_generazione_numero,
    sedestab.latitudine AS lat_stab,
    sedestab.longitudine AS long_stab,
    lps.entered AS linea_entered,
    lps.modified AS linea_modified,
    latt.macroarea,
    latt.aggregazione,
    latt.attivita AS attivita_xml,
    comuni1.codiceistatasl_old,
    provsedestab.cod_provincia AS sigla_prov_operativa,
    provsedeop.cod_provincia AS sigla_prov_legale,
    provsoggind.cod_provincia AS sigla_prov_soggfisico,
    comunisoggind.nome AS comune_residenza,
    soggsl.data_nascita AS data_nascita_rapp_sede_legale,
    lotis.code AS impresa_id_tipo_societa,
    soggsl.comune_nascita AS comune_nascita_rapp_sede_legale,
    soggsl.sesso,
    soggind.civico,
    topsoggind.description AS toponimo_residenza,
    soggind.toponimo AS id_toponimo_residenza,
    sedeop.civico AS civico_sede_legale,
    sedeop.toponimo AS tiponimo_sede_legale,
    topsedeop.description AS toponimo_sede_legale,
    sedestab.civico AS civico_sede_stab,
    sedestab.toponimo AS tiponimo_sede_stab,
    topsedestab.description AS toponimo_sede_stab,
    soggind.via AS via_rapp_sede_legale,
    sedeop.via AS via_sede_legale,
        CASE
            WHEN o.tipo_impresa = 1 AND stab.tipo_attivita = 1 THEN comuni1.id
            WHEN o.tipo_impresa = 1 AND stab.tipo_attivita = 2 THEN comunisoggind.id
            WHEN (o.tipo_impresa <> 1 OR o.tipo_impresa IS NULL) AND stab.tipo_attivita = 1 THEN comuni1.id
            WHEN (o.tipo_impresa <> 1 OR o.tipo_impresa IS NULL) AND stab.tipo_attivita = 2 THEN comunisl.id
            ELSE NULL::integer
        END AS id_comune_richiesta,
        CASE
            WHEN o.tipo_impresa = 1 AND stab.tipo_attivita = 1 THEN comuni1.nome
            WHEN o.tipo_impresa = 1 AND stab.tipo_attivita = 2 THEN comunisoggind.nome
            WHEN (o.tipo_impresa <> 1 OR o.tipo_impresa IS NULL) AND stab.tipo_attivita = 1 THEN comuni1.nome
            WHEN (o.tipo_impresa <> 1 OR o.tipo_impresa IS NULL) AND stab.tipo_attivita = 2 THEN comunisl.nome
            ELSE NULL::character varying
        END AS comune_richiesta,
        CASE
            WHEN o.tipo_societa = 1 AND stab.tipo_attivita = 1 THEN btrim(sedestab.via::text)::character varying
            WHEN o.tipo_societa = 1 AND stab.tipo_attivita = 2 THEN btrim(soggind.via::text)::character varying
            WHEN (o.tipo_societa <> 1 OR o.tipo_societa IS NULL) AND stab.tipo_attivita = 1 THEN btrim(sedestab.via::text)::character varying
            WHEN (o.tipo_societa <> 1 OR o.tipo_societa IS NULL) AND stab.tipo_attivita = 2 THEN btrim(sedeop.via::text)::character varying
            ELSE NULL::character varying
        END AS via_stabilimento_calcolata,
        CASE
            WHEN o.tipo_societa = 1 AND stab.tipo_attivita = 1 THEN btrim(sedestab.civico)::character varying
            WHEN o.tipo_societa = 1 AND stab.tipo_attivita = 2 THEN btrim(soggind.civico)::character varying
            WHEN (o.tipo_societa <> 1 OR o.tipo_societa IS NULL) AND stab.tipo_attivita = 1 THEN btrim(sedestab.civico)::character varying
            WHEN (o.tipo_societa <> 1 OR o.tipo_societa IS NULL) AND stab.tipo_attivita = 2 THEN btrim(sedeop.civico)::character varying
            ELSE NULL::character varying
        END AS civico_stabilimento_calcolato,
    soggind.cap AS cap_residenza,
    soggind.nazione AS nazione_residenza,
    sedeop.nazione AS nazione_sede_legale,
    sedestab.nazione AS nazione_stab,
    latt.id_lookup_tipo_linee_mobili,
    '-1'::integer AS id_tipo_linea_produttiva,
    rels.id_soggetto_fisico,
    lps.pregresso_o_import,
    stab.riferimento_org_id,
    latt.codice_macroarea,
    latt.codice_aggregazione,
    latt.codice_attivita AS codice_attivita_only,
    lps.codice_sinaaf as codice_sinaaf,
    lps.id_sinaaf as id_sinaaf
   FROM opu_operatore o
     JOIN opu_rel_operatore_soggetto_fisico rels ON rels.id_operatore = o.id AND rels.enabled
     JOIN opu_soggetto_fisico soggsl ON soggsl.id = rels.id_soggetto_fisico
     LEFT JOIN opu_indirizzo soggind ON soggind.id = soggsl.indirizzo_id
     LEFT JOIN comuni1 comunisoggind ON comunisoggind.id = soggind.comune
     LEFT JOIN opu_indirizzo sedeop ON sedeop.id = o.id_indirizzo
     LEFT JOIN comuni1 comunisl ON sedeop.comune = comunisl.id
     JOIN opu_stabilimento stab ON stab.id_operatore = o.id
     JOIN opu_relazione_stabilimento_linee_produttive lps ON lps.id_stabilimento = stab.id AND lps.enabled AND lps.escludi_ricerca IS NOT TRUE
     LEFT JOIN lookup_stato_lab stati ON stati.code = stab.stato
     JOIN ml8_linee_attivita_nuove_materializzata latt ON latt.id_nuova_linea_attivita = lps.id_linea_produttiva
     LEFT JOIN master_list_flag_linee_attivita ml ON ml.id_linea = latt.id_nuova_linea_attivita
     JOIN opu_indirizzo sedestab ON sedestab.id = stab.id_indirizzo
     LEFT JOIN comuni1 ON sedestab.comune = comuni1.id
     LEFT JOIN opu_indirizzo i ON i.id = stab.id_indirizzo
     LEFT JOIN lookup_province provsedestab ON provsedestab.code::text = sedestab.provincia::text
     LEFT JOIN lookup_province provsedeop ON provsedeop.code::text = sedeop.provincia::text
     LEFT JOIN lookup_province provsoggind ON provsoggind.code::text = soggind.provincia::text
     LEFT JOIN lookup_toponimi topsedeop ON sedeop.toponimo = topsedeop.code
     LEFT JOIN lookup_toponimi topsedestab ON sedestab.toponimo = topsedestab.code
     LEFT JOIN lookup_toponimi topsoggind ON soggind.toponimo = topsoggind.code
     LEFT JOIN lookup_opu_tipo_impresa loti ON loti.code = o.tipo_impresa
     LEFT JOIN lookup_opu_tipo_impresa_societa lotis ON lotis.code = o.tipo_societa
     LEFT JOIN lookup_stato_lab statilinea ON statilinea.code = lps.stato
     LEFT JOIN access acc ON acc.user_id = stab.entered_by
     LEFT JOIN contact con ON con.contact_id = acc.contact_id
     LEFT JOIN opu_lookup_tipologia_carattere lsc ON lsc.code = stab.tipo_carattere
     LEFT JOIN lookup_site_id asl ON asl.code = stab.id_asl
  WHERE o.trashed_date IS NULL AND stab.trashed_date IS NULL AND stab.trashed_date IS NULL;










ALTER TABLE public.r_gisa_opu_relazione_stabilimento_linee_produttive ADD codice_sinaaf text NULL;

ALTER TABLE public.r_gisa_opu_relazione_stabilimento_linee_produttive ADD id_sinaaf text NULL;


ALTER TABLE public.opu_operatori_denormalizzati_canili_opc_gisa ADD id_sinaaf text NULL;
ALTER TABLE public.opu_operatori_denormalizzati_canili_opc_gisa ADD codice_sinaaf text NULL;
























CREATE OR REPLACE VIEW public.opu_operatori_denormalizzati_view_bdu
AS SELECT opu_operatori_denormalizzati_view.flag_dia,
    opu_operatori_denormalizzati_view.id_opu_operatore,
    opu_operatori_denormalizzati_view.ragione_sociale,
    opu_operatori_denormalizzati_view.partita_iva,
    opu_operatori_denormalizzati_view.codice_fiscale_impresa,
    opu_operatori_denormalizzati_view.indirizzo_sede_legale,
    opu_operatori_denormalizzati_view.comune_sede_legale,
    opu_operatori_denormalizzati_view.istat_legale,
    opu_operatori_denormalizzati_view.cap_sede_legale,
    opu_operatori_denormalizzati_view.prov_sede_legale,
    opu_operatori_denormalizzati_view.note,
    opu_operatori_denormalizzati_view.entered,
    opu_operatori_denormalizzati_view.modified,
    opu_operatori_denormalizzati_view.enteredby,
    opu_operatori_denormalizzati_view.modifiedby,
    opu_operatori_denormalizzati_view.domicilio_digitale,
    opu_operatori_denormalizzati_view.flag_ric_ce,
    opu_operatori_denormalizzati_view.num_ric_ce,
    opu_operatori_denormalizzati_view.comune,
    opu_operatori_denormalizzati_view.id_asl,
    opu_operatori_denormalizzati_view.id_stabilimento,
    opu_operatori_denormalizzati_view.esito_import,
    opu_operatori_denormalizzati_view.data_import,
    opu_operatori_denormalizzati_view.cun,
    opu_operatori_denormalizzati_view.id_sinvsa,
    opu_operatori_denormalizzati_view.descrizione_errore,
    opu_operatori_denormalizzati_view.comune_stab,
    opu_operatori_denormalizzati_view.istat_operativo,
    opu_operatori_denormalizzati_view.indirizzo_stab,
    opu_operatori_denormalizzati_view.cap_stab,
    opu_operatori_denormalizzati_view.prov_stab,
    opu_operatori_denormalizzati_view.data_fine_dia,
    opu_operatori_denormalizzati_view.categoria_rischio,
    opu_operatori_denormalizzati_view.cf_rapp_sede_legale,
    opu_operatori_denormalizzati_view.nome_rapp_sede_legale,
    opu_operatori_denormalizzati_view.cognome_rapp_sede_legale,
    opu_operatori_denormalizzati_view.codice_registrazione,
    opu_operatori_denormalizzati_view.id_norma,
    opu_operatori_denormalizzati_view.cf_correntista,
    opu_operatori_denormalizzati_view.codice_attivita,
    opu_operatori_denormalizzati_view.primario,
    opu_operatori_denormalizzati_view.attivita,
    opu_operatori_denormalizzati_view.data_inizio,
    opu_operatori_denormalizzati_view.data_fine,
    opu_operatori_denormalizzati_view.numero_registrazione,
    opu_operatori_denormalizzati_view.indirizzo_rapp_sede_legale,
    opu_operatori_denormalizzati_view.stato,
    opu_operatori_denormalizzati_view.solo_attivita,
    opu_operatori_denormalizzati_view.data_inizio_attivita,
    opu_operatori_denormalizzati_view.data_fine_attivita,
    opu_operatori_denormalizzati_view.data_prossimo_controllo,
    opu_operatori_denormalizzati_view.id_stato,
    opu_operatori_denormalizzati_view.path_attivita_completo,
    opu_operatori_denormalizzati_view.id_indirizzo,
    opu_operatori_denormalizzati_view.linee_pregresse,
    opu_operatori_denormalizzati_view.flag_nuova_gestione,
    opu_operatori_denormalizzati_view.tipo_impresa,
    opu_operatori_denormalizzati_view.tipo_societa,
    opu_operatori_denormalizzati_view.codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.id_asl_stab,
    opu_operatori_denormalizzati_view.id_linea_attivita,
    opu_operatori_denormalizzati_view.data_mod_attivita,
    opu_operatori_denormalizzati_view.stab_entered,
    opu_operatori_denormalizzati_view.linea_numero_registrazione,
    opu_operatori_denormalizzati_view.linea_stato,
    opu_operatori_denormalizzati_view.linea_stato_text,
    opu_operatori_denormalizzati_view.linea_codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.stab_codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.id_indirizzo_operatore,
    opu_operatori_denormalizzati_view.import_opu,
    opu_operatori_denormalizzati_view.id_linea_attivita_stab,
    opu_operatori_denormalizzati_view.note_operatore,
    opu_operatori_denormalizzati_view.note_stabilimento,
    opu_operatori_denormalizzati_view.linea_codice_nazionale,
    opu_operatori_denormalizzati_view.flag_pnaa,
    opu_operatori_denormalizzati_view.stab_inserito_da,
    opu_operatori_denormalizzati_view.stab_id_attivita,
    opu_operatori_denormalizzati_view.stab_descrizione_attivita,
    opu_operatori_denormalizzati_view.stab_id_carattere,
    opu_operatori_denormalizzati_view.stab_descrizione_carattere,
    opu_operatori_denormalizzati_view.impresa_id_tipo_impresa,
    opu_operatori_denormalizzati_view.stab_asl,
    opu_operatori_denormalizzati_view.flag_clean,
    opu_operatori_denormalizzati_view.data_generazione_numero,
    opu_operatori_denormalizzati_view.lat_stab,
    opu_operatori_denormalizzati_view.long_stab,
    opu_operatori_denormalizzati_view.linea_entered,
    opu_operatori_denormalizzati_view.linea_modified,
    opu_operatori_denormalizzati_view.macroarea,
    opu_operatori_denormalizzati_view.aggregazione,
    opu_operatori_denormalizzati_view.attivita_xml,
    opu_operatori_denormalizzati_view.codiceistatasl_old,
    opu_operatori_denormalizzati_view.sigla_prov_operativa,
    opu_operatori_denormalizzati_view.sigla_prov_legale,
    opu_operatori_denormalizzati_view.sigla_prov_soggfisico,
    opu_operatori_denormalizzati_view.comune_residenza,
    opu_operatori_denormalizzati_view.data_nascita_rapp_sede_legale,
    opu_operatori_denormalizzati_view.impresa_id_tipo_societa,
    opu_operatori_denormalizzati_view.comune_nascita_rapp_sede_legale,
    opu_operatori_denormalizzati_view.sesso,
    opu_operatori_denormalizzati_view.civico,
    opu_operatori_denormalizzati_view.toponimo_residenza,
    opu_operatori_denormalizzati_view.id_toponimo_residenza,
    opu_operatori_denormalizzati_view.civico_sede_legale,
    opu_operatori_denormalizzati_view.tiponimo_sede_legale,
    opu_operatori_denormalizzati_view.toponimo_sede_legale,
    opu_operatori_denormalizzati_view.civico_sede_stab,
    opu_operatori_denormalizzati_view.tiponimo_sede_stab,
    opu_operatori_denormalizzati_view.toponimo_sede_stab,
    opu_operatori_denormalizzati_view.via_rapp_sede_legale,
    opu_operatori_denormalizzati_view.via_sede_legale,
    opu_operatori_denormalizzati_view.id_comune_richiesta,
    opu_operatori_denormalizzati_view.comune_richiesta,
    opu_operatori_denormalizzati_view.via_stabilimento_calcolata,
    opu_operatori_denormalizzati_view.civico_stabilimento_calcolato,
    opu_operatori_denormalizzati_view.cap_residenza,
    opu_operatori_denormalizzati_view.nazione_residenza,
    opu_operatori_denormalizzati_view.nazione_sede_legale,
    opu_operatori_denormalizzati_view.nazione_stab,
    opu_operatori_denormalizzati_view.id_lookup_tipo_linee_mobili,
    opu_operatori_denormalizzati_view.id_tipo_linea_produttiva,
    opu_operatori_denormalizzati_view.id_soggetto_fisico,
        CASE
            WHEN opu_operatori_denormalizzati_view.codice_attivita = ANY (ARRAY['IUV-CAN-PEN'::text, 'IUV-CAN-CAN'::text, 'VET-AMBV-PU'::text, 'VET-CLIV-PU'::text, 'VET-OSPV-PU'::text, 'IUV-CAN-ALLCAN'::text, 'IUV-CAN-ALLGAT'::text, 'IUV-ADCA-ADCA'::text, 'IUV-CAN-RIFRIC'::text, 'IUV-CAN-RIFSAN'::text, 'IUV-CAN-AAF'::text, 'ASSANIM-ASSANIM-ASSANIM'::text]) THEN 5
            WHEN opu_operatori_denormalizzati_view.codice_attivita = ANY (ARRAY['IUV-CODAC-VEDCG'::text, 'IUV-COIAC-VEICG'::text, '349-93-ALPET-PRIV'::text, '349-93-ALCAT-PRIV'::text, '349-93-ALPET-ALTR'::text, '349-93-ALCAT-ALTR'::text, 'IUV-CODAC-DET'::text, 'IUV-COIAC-INGINF'::text, 'IUV-COIAC-INGSUP'::text]) THEN 6
            ELSE NULL::integer
        END AS id_linea_bdu,
            opu_operatori_denormalizzati_view.id_sinaaf,
    opu_operatori_denormalizzati_view.codice_sinaaf
   FROM opu_operatori_denormalizzati_view
     LEFT JOIN master_list_flag_linee_attivita ON master_list_flag_linee_attivita.id_linea = opu_operatori_denormalizzati_view.id_linea_attivita_stab
  WHERE master_list_flag_linee_attivita.bdu = true;


















CREATE OR REPLACE FUNCTION public_functions.suap_insert_linea_produttiva(id_stabilimento_in integer, idstabgisa integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
declare
id_linea int;
idRelStabLpBdu int;
idLineaBdu int ;
id_sinaaf_ text;
codice_sinaaf_ text;
BEGIN



raise info 'select distinct id_linea_bdu from opu_operatori_denormalizzati_canili_opc_gisa v where v.id_stabilimento = % ', idstabgisa ;
for idLineaBdu in 
select distinct id_linea_bdu from opu_operatori_denormalizzati_canili_opc_gisa v where v.id_stabilimento = idStabGisa 
loop
insert into opu_relazione_stabilimento_linee_produttive (id_linea_produttiva,id_stabilimento)
values(idLineaBdu,id_stabilimento_in);
end loop ;
raise info 'select id from opu_relazione_stabilimento_linee_produttive rel where rel.id_linea_produttiva = % and rel.id_stabilimento = %', idLineaBdu, id_stabilimento_in;
idRelStabLpBdu := (select id from opu_relazione_stabilimento_linee_produttive rel where rel.id_linea_produttiva = idLineaBdu and rel.id_stabilimento = id_stabilimento_in);

select v.id_sinaaf,v.codice_sinaaf into id_sinaaf_,codice_sinaaf_ from opu_operatori_denormalizzati_canili_opc_gisa v where v.id_stabilimento = idStabGisa;
update opu_relazione_stabilimento_linee_produttive set id_sinaaf = id_sinaaf_::text , codice_sinaaf = codice_sinaaf_::text where id = idRelStabLpBdu;

return idRelStabLpBdu ;
 END;
$function$
;



CREATE OR REPLACE FUNCTION public.gisa_bdu_is_sincronizzato(_identita text, entita text, nomeidtabella text)
 RETURNS TABLE(sincronizzato boolean, id_bdu text, cancellato boolean)
 LANGUAGE plpgsql
AS $function$
DECLARE
sincronizzato_return boolean;
id_bdu text;
query text;
id_base text;
 begin
	 if (entita = 'struttura') then
	 entita = 'opu_relazione_stabilimento_linee_produttive';
	 select * into _identita from opu_relazione_stabilimento_linee_produttive orslp  where orslp.id =_identita::integer;
	end if;
	query := '  select (
           (id_bdu is not null ) and 
           (
             (ws.data is not null and ws.data >= GREATEST (t1.modified_sinaaf,trashed_date)) or
             (t1.sinaaf_estrazione_invio_pregresso_ok is not null and t1.sinaaf_estrazione_invio_pregresso_ok >= GREATEST (t1.modified_sinaaf,trashed_date))
           )
          ),id_bdu, t1.trashed_date is not null as cancellato from ' || entita || ' as t1 left join ws_storico_chiamate ws on ws.id_tabella = t1.' || nomeidtabella ||'::text and ws.tabella = ''' || entita || ''' and ws.esito= ''OK'' and (ws.metodo is null or upper(ws.metodo) <> ''GET'')    where  t1.' || nomeidtabella || '::text = ''' || _identita || ''' order by ws.id desc limit 1';
	raise info 'query costruita per verificare if entita is sincronizzato: %', query;	
	EXECUTE query INTO  sincronizzato_return,id_bdu,cancellato;
	if sincronizzato_return is null then sincronizzato_return:=false; end if;	

	RETURN QUERY     
	select sincronizzato_return,id_bdu,cancellato;    
 END;
$function$
;


-- Drop table

-- DROP TABLE public.storico_chiamate_g2b;

CREATE TABLE public.storico_chiamate_g2b (
	id serial4 NOT NULL,
	url varchar NULL,
	request_dbi varchar NULL,
	response varchar NULL,
	"data" timestamp NULL,
	id_tabella varchar NULL,
	tabella varchar NULL,
	caller varchar NULL,
	endpoint varchar NULL,
	esito varchar NULL
);



-- Drop table

-- DROP TABLE public.opu_relazione_stabilimento_linee_produttive;

ALTER TABLE public.opu_relazione_stabilimento_linee_produttive ADD id_sinaaf text NULL;

ALTER TABLE public.opu_relazione_stabilimento_linee_produttive ADD codice_sinaaf varchar(200) NULL;

ALTER TABLE public.opu_relazione_stabilimento_linee_produttive ADD modified_sinaaf timestamp NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE public.opu_relazione_stabilimento_linee_produttive ADD trashed_date timestamp NULL;

ALTER TABLE public.opu_relazione_stabilimento_linee_produttive ADD sinaaf_estrazione_invio_pregresso_ok timestamp NULL;

ALTER TABLE public.opu_relazione_stabilimento_linee_produttive ADD id_bdu varchar NULL;


drop table ws_storico_chiamate


CREATE TABLE public.ws_storico_chiamate (
	id serial4 NOT NULL,
	url text NULL,
	request text NULL,
	response text NULL,
	id_utente int4 NULL,
	"data" timestamp NULL DEFAULT now(),
	tabella text NULL,
	esito text NULL,
	id_tabella text NULL,
	metodo text NULL,
	CONSTRAINT ws_storico_chiamate_pkey PRIMARY KEY (id)
);





CREATE OR REPLACE FUNCTION public.sinaaf_get_propagabilita(_identita text, entita text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$

DECLARE
propagazione_sinaaf_return boolean;
_id_linea_produttiva integer;
prov_estera boolean;
ruolo_utente_inserimento integer;
prov_f_regione boolean;
_id_proprietario integer;
proprietario_inviabile boolean;
mc_inviabile boolean;
_version integer;
_id_tipologia_evento integer;
_microchip text;
linea_sindaco integer;
linea_sindaco_fr integer;
id_ruolo_llpp integer;
id_registrazione_inserimento_bdu integer;
dati_obbligatori_giacenza_presenti boolean;
_controllo_detentore_cambiato boolean;

 begin
	 /*
	linea_sindaco := (select * from get_id_linea_produttiva('sindaco'));
	linea_sindaco_fr := (select * from get_id_linea_produttiva('sindaco fuori regione'));
        propagazione_sinaaf_return:=false;
        	*/	
	if(entita='struttura') then
		_id_linea_produttiva:=(select id_linea_produttiva from opu_relazione_stabilimento_linee_produttive  where id =  _identita::integer);
		if(select sinac from master_list_flag_linee_attivita where id_linea = _id_linea_produttiva and rev=11)then
			propagazione_sinaaf_return:=true; 
		end if;
	end if;


        RETURN propagazione_sinaaf_return;   
 END;
$function$
;




CREATE TABLE public.sinaaf_step_allineamenti_entita (
	"token" text NULL,
	ws text NULL,
	"method" text NULL,
	envelope text NULL,
	step int4 NULL,
	token_principale text NULL,
	propagazione_sinaaf text NULL,
	dbi_get_envelope text NULL,
	id_tabella text NULL,
	tabella text NULL,
	dipendenze text NULL,
	nome_campo_id_sinaaf text NULL,
	presente_in_gisa text NULL,
	sincronizzato text NULL,
	id_sinaaf text NULL,
	nome_campo_codice_sinaaf_get text NULL,
	nome_campo_codice_sinaaf text NULL,
	codice_sinaaf text NULL,
	cancellato text NULL,
	ws_get text NULL,
	campo_id_sinaaf_da_aggiornare_bdu text NULL DEFAULT 'id_sinaaf'::text
);

ALTER TABLE public.master_list_flag_linee_attivita ADD codice_tipologia_struttura_sinac varchar NULL;

CREATE OR REPLACE FUNCTION public.unaccent(text)
 RETURNS text
 LANGUAGE c
 immutable PARALLEL SAFE STRICT
AS '$libdir/unaccent', $function$unaccent_dict$function$
;



drop function sinaaf_persone_get_dati_envelope(int4, text) 


CREATE OR REPLACE FUNCTION public.unaccent(regdictionary, text)
 RETURNS text
 LANGUAGE c
 immutable PARALLEL SAFE strict  
AS '$libdir/unaccent', $function$unaccent_dict$function$  
;

ALTER FUNCTION unaccent(regdictionary,text) IMMUTABLE


CREATE OR REPLACE FUNCTION public.insert_storico_chiamate_g2b(url_input text, request text, response_ text, id_tabella_ text, tabella_input text, caller_ text, endpoint_ text, esito_ text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
 begin
	 
       insert into storico_chiamate_g2b(url, request_dbi , response, "data", id_tabella, tabella, caller,endpoint,esito) values (url_input, request, response_,  now(), id_tabella_,case when tabella_input = 'struttura' then 'opu_relazione_stabilimento_linee_produttive' else tabella_input end,caller_, endpoint_,esito_);
END;
$function$;




CREATE TABLE public.sinaaf_nazioni_codici_iso (
	denominazione_it varchar NULL,
	codice_at varchar NULL,
	codice_iso_alpha2 varchar NULL,
	codice_iso_alpha3 varchar NULL,
	code serial4 NOT NULL,
	default_item bool NULL DEFAULT false,
	"level" int4 NULL DEFAULT 0,
	enabled bool NULL DEFAULT true,
	entered timestamp NULL,
	modified timestamp NULL,
	CONSTRAINT sinaaf_nazioni_codici_istat PRIMARY KEY (code)
);




select * from public.sinaaf_persone_get_dati_envelope(291041)


select * from g2b_get_info_ws('428152','struttura')


CREATE EXTENSION unaccent
  SCHEMA public
  VERSION "1.1";
 
 
 
 select * from g2b_get_info_ws('428156','struttura')

 
  select * from gisa_bdu_is_sincronizzato('428156','struttura')

 select * from sinaaf_is_sincronizzato('428163', 'struttura','id') 
  
 
 SELECT time '15:45' - interval '120 seconds';


 		select (
           (id_sinaaf is not null or codice_sinaaf is not null) and 
           (
             (ws.data is not null and ws.data >= GREATEST (t1.modified_sinaaf,trashed_date)) or
             (t1.sinaaf_estrazione_invio_pregresso_ok is not null and t1.sinaaf_estrazione_invio_pregresso_ok >= GREATEST (t1.modified_sinaaf,trashed_date))
           )
          ),id_sinaaf,codice_sinaaf, t1.trashed_date is not null as cancellato from opu_relazione_stabilimento_linee_produttive as t1 left join ws_storico_chiamate ws on ws.id_tabella = t1.id::text and ws.tabella = 'opu_relazione_stabilimento_linee_produttive' and ws.esito= 'OK' and (ws.metodo is null or upper(ws.metodo) <> 'GET')    where  t1.id::text = '428163' order by ws.id desc limit 1

 
 
 
  
  select
*       from sinaaf_get_step_allineamento_entita('428155@struttura',null,1,null,'false') order by step desc;



 select
*       from sinaaf_get_step_allineamento_entita('428159@struttura',null,1,null,'false') order by step desc;




 SELECT
        *
        FROM public.ws_insert_storico_chiamate('https://anagrafecaninatest.vetinfo.it/j_test_api_siraaf/api/v1/canile','{"canId": "","canCodice": "","canCodiceRegione": "428163","canRagioneSociale": "ok","ticCodice": "TC00","prpIdFiscale": "BSTSIX05L44H213F","canPrpDtInizioAttivita": "04-07-2023","prpComIstat": "066","prpProSigla": "","gesIdFiscale": "BSTSIX05L44H213F","canGesDtInizioAttivita": "04-07-2023","comIstat": "066","proSigla": "CE","canIndirizzo": "r","comCap": "81017","canDtRegistrazione": "","aslCodice": "R203","canDtInizioAttivita": "04-07-2023","canDtFineAttivita": "", "canFlagFineAttivita": "", "canNumTelFisso": "3522234222", "canNumTelMobile": "", "canNumFax": "", "canEmail": "", "canCapacita": "66", "canLatitudine": "41.37083", "canLongitudine": "14.24211", "canFlagPrivato": "N", "canNumDecreto": "", "flagPresenzaCani": "S", "flagPresenzaGatti": "N", "flagPresenzaAltriAnimali": "N", "flagStrutturaBloccata": "N","note": ""}','{"dtUltimaModifica":null,"anmId":null,"anmNome":null,"anmTatuaggio":null,"anmMicrochip":null,"erroriAsString":"","erroriUpload":null,"canId":3842,"canCodice":"SD-150CE007332","comId":null,"canRagioneSociale":"ok","canCodiceRegionale":null,"canPartitaIva":null,"ticCodice":"TC00","ticDescrizione":null,"prpDenominazionePersona":null,"gesIdFiscale":"BSTSIX05L44H213F","gesDenominazionePersona":null,"prpIdFiscale":"BSTSIX05L44H213F","prpComIstat":"066","prpProSigla":"","prpComDescrizione":null,"prpId":null,"prpNome":null,"prpCognome":null,"gesId":null,"gesNome":null,"gesCognome":null,"regCodice":null,"regDescrizione":null,"canIndirizzo":"r","comCap":"81017","comIstat":"066","comDescrizione":null,"proId":null,"proSigla":"CE","canDtRegistrazione":null,"canDtInizioAttivita":"04-07-2023","canDtFineAttivita":null,"canNumTelFisso":"3522234222","canNumTelMobile":"","canNumFax":"","canEmail":"","canCapacita":66,"canLatitudine":"41.37083","canLongitudine":"14.24211","vetIdFiscale":null,"vetCognome":null,"vetNome":null,"vetRagSociale":null,"canFlagPrivato":"N","canNumDecreto":"","flagPresenzaCani":"S","flagPresenzaGatti":"N","flagPresenzaAltriAnimali":"N","flagStrutturaBloccata":"N","flagPropNocomune":null,"canFlagFineAttivita":"","aslId":null,"aslCodice":"R203","aslDescrizione":null,"note":"","forzaDuplicato":null,"canPrpDtInizioAttivita":"04-07-2023","canGesDtInizioAttivita":"04-07-2023","numAutorizzazioneScorta":null,"dtInizioScorta":null,"dtFineScorta":null,"autorizzazioneScorta":null,"vetResponsabileScortaIdFiscale":null,"vetResponsabileScortaDenominazione":null,"cangESDtInizioAttivita":"04/07/2023"}',1,'428163','struttura','OK','POST');

       
       
       
       
       
       
       
       
       
       
       
       
       
CREATE OR REPLACE VIEW public.opu_operatori_denormalizzati_view_bdu
AS SELECT opu_operatori_denormalizzati_view.flag_dia,
    opu_operatori_denormalizzati_view.id_opu_operatore,
    opu_operatori_denormalizzati_view.ragione_sociale,
    opu_operatori_denormalizzati_view.partita_iva,
    opu_operatori_denormalizzati_view.codice_fiscale_impresa,
    opu_operatori_denormalizzati_view.indirizzo_sede_legale,
    opu_operatori_denormalizzati_view.comune_sede_legale,
    opu_operatori_denormalizzati_view.istat_legale,
    opu_operatori_denormalizzati_view.cap_sede_legale,
    opu_operatori_denormalizzati_view.prov_sede_legale,
    opu_operatori_denormalizzati_view.note,
    opu_operatori_denormalizzati_view.entered,
    opu_operatori_denormalizzati_view.modified,
    opu_operatori_denormalizzati_view.enteredby,
    opu_operatori_denormalizzati_view.modifiedby,
    opu_operatori_denormalizzati_view.domicilio_digitale,
    opu_operatori_denormalizzati_view.flag_ric_ce,
    opu_operatori_denormalizzati_view.num_ric_ce,
    opu_operatori_denormalizzati_view.comune,
    opu_operatori_denormalizzati_view.id_asl,
    opu_operatori_denormalizzati_view.id_stabilimento,
    opu_operatori_denormalizzati_view.esito_import,
    opu_operatori_denormalizzati_view.data_import,
    opu_operatori_denormalizzati_view.cun,
    opu_operatori_denormalizzati_view.id_sinvsa,
    opu_operatori_denormalizzati_view.descrizione_errore,
    opu_operatori_denormalizzati_view.comune_stab,
    opu_operatori_denormalizzati_view.istat_operativo,
    opu_operatori_denormalizzati_view.indirizzo_stab,
    opu_operatori_denormalizzati_view.cap_stab,
    opu_operatori_denormalizzati_view.prov_stab,
    opu_operatori_denormalizzati_view.data_fine_dia,
    opu_operatori_denormalizzati_view.categoria_rischio,
    opu_operatori_denormalizzati_view.cf_rapp_sede_legale,
    opu_operatori_denormalizzati_view.nome_rapp_sede_legale,
    opu_operatori_denormalizzati_view.cognome_rapp_sede_legale,
    opu_operatori_denormalizzati_view.codice_registrazione,
    opu_operatori_denormalizzati_view.id_norma,
    opu_operatori_denormalizzati_view.cf_correntista,
    opu_operatori_denormalizzati_view.codice_attivita,
    opu_operatori_denormalizzati_view.primario,
    opu_operatori_denormalizzati_view.attivita,
    opu_operatori_denormalizzati_view.data_inizio,
    opu_operatori_denormalizzati_view.data_fine,
    opu_operatori_denormalizzati_view.numero_registrazione,
    opu_operatori_denormalizzati_view.indirizzo_rapp_sede_legale,
    opu_operatori_denormalizzati_view.stato,
    opu_operatori_denormalizzati_view.solo_attivita,
    opu_operatori_denormalizzati_view.data_inizio_attivita,
    opu_operatori_denormalizzati_view.data_fine_attivita,
    opu_operatori_denormalizzati_view.data_prossimo_controllo,
    opu_operatori_denormalizzati_view.id_stato,
    opu_operatori_denormalizzati_view.path_attivita_completo,
    opu_operatori_denormalizzati_view.id_indirizzo,
    opu_operatori_denormalizzati_view.linee_pregresse,
    opu_operatori_denormalizzati_view.flag_nuova_gestione,
    opu_operatori_denormalizzati_view.tipo_impresa,
    opu_operatori_denormalizzati_view.tipo_societa,
    opu_operatori_denormalizzati_view.codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.id_asl_stab,
    opu_operatori_denormalizzati_view.id_linea_attivita,
    opu_operatori_denormalizzati_view.data_mod_attivita,
    opu_operatori_denormalizzati_view.stab_entered,
    opu_operatori_denormalizzati_view.linea_numero_registrazione,
    opu_operatori_denormalizzati_view.linea_stato,
    opu_operatori_denormalizzati_view.linea_stato_text,
    opu_operatori_denormalizzati_view.linea_codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.stab_codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.id_indirizzo_operatore,
    opu_operatori_denormalizzati_view.import_opu,
    opu_operatori_denormalizzati_view.id_linea_attivita_stab,
    opu_operatori_denormalizzati_view.note_operatore,
    opu_operatori_denormalizzati_view.note_stabilimento,
    opu_operatori_denormalizzati_view.linea_codice_nazionale,
    opu_operatori_denormalizzati_view.flag_pnaa,
    opu_operatori_denormalizzati_view.stab_inserito_da,
    opu_operatori_denormalizzati_view.stab_id_attivita,
    opu_operatori_denormalizzati_view.stab_descrizione_attivita,
    opu_operatori_denormalizzati_view.stab_id_carattere,
    opu_operatori_denormalizzati_view.stab_descrizione_carattere,
    opu_operatori_denormalizzati_view.impresa_id_tipo_impresa,
    opu_operatori_denormalizzati_view.stab_asl,
    opu_operatori_denormalizzati_view.flag_clean,
    opu_operatori_denormalizzati_view.data_generazione_numero,
    opu_operatori_denormalizzati_view.lat_stab,
    opu_operatori_denormalizzati_view.long_stab,
    opu_operatori_denormalizzati_view.linea_entered,
    opu_operatori_denormalizzati_view.linea_modified,
    opu_operatori_denormalizzati_view.macroarea,
    opu_operatori_denormalizzati_view.aggregazione,
    opu_operatori_denormalizzati_view.attivita_xml,
    opu_operatori_denormalizzati_view.codiceistatasl_old,
    opu_operatori_denormalizzati_view.sigla_prov_operativa,
    opu_operatori_denormalizzati_view.sigla_prov_legale,
    opu_operatori_denormalizzati_view.sigla_prov_soggfisico,
    opu_operatori_denormalizzati_view.comune_residenza,
    opu_operatori_denormalizzati_view.data_nascita_rapp_sede_legale,
    opu_operatori_denormalizzati_view.impresa_id_tipo_societa,
    opu_operatori_denormalizzati_view.comune_nascita_rapp_sede_legale,
    opu_operatori_denormalizzati_view.sesso,
    opu_operatori_denormalizzati_view.civico,
    opu_operatori_denormalizzati_view.toponimo_residenza,
    opu_operatori_denormalizzati_view.id_toponimo_residenza,
    opu_operatori_denormalizzati_view.civico_sede_legale,
    opu_operatori_denormalizzati_view.tiponimo_sede_legale,
    opu_operatori_denormalizzati_view.toponimo_sede_legale,
    opu_operatori_denormalizzati_view.civico_sede_stab,
    opu_operatori_denormalizzati_view.tiponimo_sede_stab,
    opu_operatori_denormalizzati_view.toponimo_sede_stab,
    opu_operatori_denormalizzati_view.via_rapp_sede_legale,
    opu_operatori_denormalizzati_view.via_sede_legale,
    opu_operatori_denormalizzati_view.id_comune_richiesta,
    opu_operatori_denormalizzati_view.comune_richiesta,
    opu_operatori_denormalizzati_view.via_stabilimento_calcolata,
    opu_operatori_denormalizzati_view.civico_stabilimento_calcolato,
    opu_operatori_denormalizzati_view.cap_residenza,
    opu_operatori_denormalizzati_view.nazione_residenza,
    opu_operatori_denormalizzati_view.nazione_sede_legale,
    opu_operatori_denormalizzati_view.nazione_stab,
    opu_operatori_denormalizzati_view.id_lookup_tipo_linee_mobili,
    opu_operatori_denormalizzati_view.id_tipo_linea_produttiva,
    opu_operatori_denormalizzati_view.id_soggetto_fisico,
        CASE
            WHEN opu_operatori_denormalizzati_view.codice_attivita = ANY (ARRAY['IUV-CAN-PEN'::text, 'IUV-CAN-CAN'::text, 'VET-AMBV-PU'::text, 'VET-CLIV-PU'::text, 'VET-OSPV-PU'::text, 'IUV-CAN-ALLCAN'::text, 'IUV-CAN-ALLGAT'::text, 'IUV-ADCA-ADCA'::text, 'IUV-CAN-RIFRIC'::text, 'IUV-CAN-RIFSAN'::text, 'IUV-CAN-AAF'::text, 'ASSANIM-ASSANIM-ASSANIM'::text]) THEN 5
            WHEN opu_operatori_denormalizzati_view.codice_attivita = ANY (ARRAY['IUV-CODAC-VEDCG'::text, 'IUV-COIAC-VEICG'::text, '349-93-ALPET-PRIV'::text, '349-93-ALCAT-PRIV'::text, '349-93-ALPET-ALTR'::text, '349-93-ALCAT-ALTR'::text, 'IUV-CODAC-DET'::text, 'IUV-COIAC-INGINF'::text, 'IUV-COIAC-INGSUP'::text]) THEN 6
            ELSE NULL::integer
        END AS id_linea_bdu
   FROM opu_operatori_denormalizzati_view
     LEFT JOIN master_list_flag_linee_attivita ON master_list_flag_linee_attivita.id_linea = opu_operatori_denormalizzati_view.id_linea_attivita_stab
  WHERE master_list_flag_linee_attivita.bdu = true;       
       
       
       
 
 
 
 CREATE OR REPLACE VIEW public.opu_operatori_denormalizzati_view_canili_bdu
AS SELECT opu_operatori_denormalizzati_view.flag_dia,
    opu_operatori_denormalizzati_view.id_opu_operatore,
    opu_operatori_denormalizzati_view.ragione_sociale,
    opu_operatori_denormalizzati_view.partita_iva,
    opu_operatori_denormalizzati_view.codice_fiscale_impresa,
    opu_operatori_denormalizzati_view.indirizzo_sede_legale,
    opu_operatori_denormalizzati_view.comune_sede_legale,
    opu_operatori_denormalizzati_view.istat_legale,
    opu_operatori_denormalizzati_view.cap_sede_legale,
    opu_operatori_denormalizzati_view.prov_sede_legale,
    opu_operatori_denormalizzati_view.note,
    opu_operatori_denormalizzati_view.entered,
    opu_operatori_denormalizzati_view.modified,
    opu_operatori_denormalizzati_view.enteredby,
    opu_operatori_denormalizzati_view.modifiedby,
    opu_operatori_denormalizzati_view.domicilio_digitale,
    opu_operatori_denormalizzati_view.flag_ric_ce,
    opu_operatori_denormalizzati_view.num_ric_ce,
    opu_operatori_denormalizzati_view.comune,
    opu_operatori_denormalizzati_view.id_asl,
    opu_operatori_denormalizzati_view.id_stabilimento,
    opu_operatori_denormalizzati_view.esito_import,
    opu_operatori_denormalizzati_view.data_import,
    opu_operatori_denormalizzati_view.cun,
    opu_operatori_denormalizzati_view.id_sinvsa,
    opu_operatori_denormalizzati_view.descrizione_errore,
    opu_operatori_denormalizzati_view.comune_stab,
    opu_operatori_denormalizzati_view.istat_operativo,
    opu_operatori_denormalizzati_view.indirizzo_stab,
    opu_operatori_denormalizzati_view.cap_stab,
    opu_operatori_denormalizzati_view.prov_stab,
    opu_operatori_denormalizzati_view.data_fine_dia,
    opu_operatori_denormalizzati_view.categoria_rischio,
    opu_operatori_denormalizzati_view.cf_rapp_sede_legale,
    opu_operatori_denormalizzati_view.nome_rapp_sede_legale,
    opu_operatori_denormalizzati_view.cognome_rapp_sede_legale,
    opu_operatori_denormalizzati_view.codice_registrazione,
    opu_operatori_denormalizzati_view.id_norma,
    opu_operatori_denormalizzati_view.cf_correntista,
    opu_operatori_denormalizzati_view.codice_attivita,
    opu_operatori_denormalizzati_view.primario,
    opu_operatori_denormalizzati_view.attivita,
    opu_operatori_denormalizzati_view.data_inizio,
    opu_operatori_denormalizzati_view.data_fine,
    opu_operatori_denormalizzati_view.numero_registrazione,
    opu_operatori_denormalizzati_view.indirizzo_rapp_sede_legale,
    opu_operatori_denormalizzati_view.stato,
    opu_operatori_denormalizzati_view.solo_attivita,
    opu_operatori_denormalizzati_view.data_inizio_attivita,
    opu_operatori_denormalizzati_view.data_fine_attivita,
    opu_operatori_denormalizzati_view.data_prossimo_controllo,
    opu_operatori_denormalizzati_view.id_stato,
    opu_operatori_denormalizzati_view.path_attivita_completo,
    opu_operatori_denormalizzati_view.id_indirizzo,
    opu_operatori_denormalizzati_view.linee_pregresse,
    opu_operatori_denormalizzati_view.flag_nuova_gestione,
    opu_operatori_denormalizzati_view.tipo_impresa,
    opu_operatori_denormalizzati_view.tipo_societa,
    opu_operatori_denormalizzati_view.codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.id_asl_stab,
    opu_operatori_denormalizzati_view.id_linea_attivita,
    opu_operatori_denormalizzati_view.data_mod_attivita,
    opu_operatori_denormalizzati_view.stab_entered,
    opu_operatori_denormalizzati_view.linea_numero_registrazione,
    opu_operatori_denormalizzati_view.linea_stato,
    opu_operatori_denormalizzati_view.linea_stato_text,
    opu_operatori_denormalizzati_view.linea_codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.stab_codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.id_indirizzo_operatore,
    opu_operatori_denormalizzati_view.import_opu,
    opu_operatori_denormalizzati_view.id_linea_attivita_stab,
    opu_operatori_denormalizzati_view.note_operatore,
    opu_operatori_denormalizzati_view.note_stabilimento,
    opu_operatori_denormalizzati_view.linea_codice_nazionale,
    opu_operatori_denormalizzati_view.flag_pnaa,
    opu_operatori_denormalizzati_view.stab_inserito_da,
    opu_operatori_denormalizzati_view.stab_id_attivita,
    opu_operatori_denormalizzati_view.stab_descrizione_attivita,
    opu_operatori_denormalizzati_view.stab_id_carattere,
    opu_operatori_denormalizzati_view.stab_descrizione_carattere,
    opu_operatori_denormalizzati_view.impresa_id_tipo_impresa,
    opu_operatori_denormalizzati_view.stab_asl,
    opu_operatori_denormalizzati_view.flag_clean,
    opu_operatori_denormalizzati_view.data_generazione_numero,
    opu_operatori_denormalizzati_view.lat_stab,
    opu_operatori_denormalizzati_view.long_stab,
    opu_operatori_denormalizzati_view.linea_entered,
    opu_operatori_denormalizzati_view.linea_modified,
    opu_operatori_denormalizzati_view.macroarea,
    opu_operatori_denormalizzati_view.aggregazione,
    opu_operatori_denormalizzati_view.attivita_xml,
    opu_operatori_denormalizzati_view.codiceistatasl_old,
    opu_operatori_denormalizzati_view.sigla_prov_operativa,
    opu_operatori_denormalizzati_view.sigla_prov_legale,
    opu_operatori_denormalizzati_view.sigla_prov_soggfisico,
    opu_operatori_denormalizzati_view.comune_residenza,
    opu_operatori_denormalizzati_view.data_nascita_rapp_sede_legale,
    opu_operatori_denormalizzati_view.impresa_id_tipo_societa,
    opu_operatori_denormalizzati_view.comune_nascita_rapp_sede_legale,
    opu_operatori_denormalizzati_view.sesso,
    opu_operatori_denormalizzati_view.civico,
    opu_operatori_denormalizzati_view.toponimo_residenza,
    opu_operatori_denormalizzati_view.id_toponimo_residenza,
    opu_operatori_denormalizzati_view.civico_sede_legale,
    opu_operatori_denormalizzati_view.tiponimo_sede_legale,
    opu_operatori_denormalizzati_view.toponimo_sede_legale,
    opu_operatori_denormalizzati_view.civico_sede_stab,
    opu_operatori_denormalizzati_view.tiponimo_sede_stab,
    opu_operatori_denormalizzati_view.toponimo_sede_stab,
    opu_operatori_denormalizzati_view.via_rapp_sede_legale,
    opu_operatori_denormalizzati_view.via_sede_legale,
    opu_operatori_denormalizzati_view.id_comune_richiesta,
    opu_operatori_denormalizzati_view.comune_richiesta,
    opu_operatori_denormalizzati_view.via_stabilimento_calcolata,
    opu_operatori_denormalizzati_view.civico_stabilimento_calcolato,
    opu_operatori_denormalizzati_view.cap_residenza,
    opu_operatori_denormalizzati_view.nazione_residenza,
    opu_operatori_denormalizzati_view.nazione_sede_legale,
    opu_operatori_denormalizzati_view.nazione_stab,
    opu_operatori_denormalizzati_view.id_lookup_tipo_linee_mobili,
    opu_operatori_denormalizzati_view.id_tipo_linea_produttiva,
    opu_operatori_denormalizzati_view.id_soggetto_fisico,
        CASE
            WHEN opu_operatori_denormalizzati_view.codice_attivita = ANY (ARRAY['IUV-CAN-PEN'::text, 'IUV-CAN-CAN'::text, 'VET-AMBV-PU'::text, 'VET-CLIV-PU'::text, 'VET-OSPV-PU'::text, 'IUV-CAN-ALLCAN'::text, 'IUV-CAN-ALLGAT'::text, 'IUV-ADCA-ADCA'::text, 'IUV-CAN-RIFRIC'::text, 'IUV-CAN-RIFSAN'::text, 'IUV-CAN-AAF', 'ASSANIM-ASSANIM-ASSANIM'::text]) THEN 5
            WHEN opu_operatori_denormalizzati_view.codice_attivita = ANY (ARRAY['IUV-CODAC-VEDCG'::text, 'IUV-COIAC-VEICG'::text, '349-93-ALPET-PRIV'::text, '349-93-ALCAT-PRIV'::text, '349-93-ALPET-ALTR'::text, '349-93-ALCAT-ALTR'::text, 'IUV-CODAC-DET'::text, 'IUV-COIAC-INGINF'::text, 'IUV-COIAC-INGSUP'::text]) THEN 6
            ELSE NULL::integer
        END AS id_linea_bdu
   FROM opu_operatori_denormalizzati_view
     LEFT JOIN master_list_flag_linee_attivita ON master_list_flag_linee_attivita.id_linea = opu_operatori_denormalizzati_view.id_linea_attivita_stab
  WHERE master_list_flag_linee_attivita.bdu = true AND (opu_operatori_denormalizzati_view.codice_attivita = ANY (ARRAY['IUV-CAN-PEN'::text, 'IUV-CAN-CAN'::text, 'IUV-CAN-ALLCAN'::text, 'IUV-CAN-ALLGAT'::text, 'IUV-ADCA-ADCA'::text, 'IUV-CAN-RIFRIC'::text, 'IUV-CAN-RIFSAN'::text, 'IUV-CAN-AAF'::text]));
       
 
 
 
 
 select * from opu_operatore oo where id=4527959
 
 
 
 select replace('pinco\ss', '\', '\\')
 
 
 
 
 ALTER TABLE public.r_gisa_opu_relazione_stabilimento_linee_produttive ADD codice_sinaaf text NULL;

 
 
 











CREATE OR REPLACE FUNCTION public.g2b_get_info_ws(_identita text, entita text)
 RETURNS TABLE(propagazione_bdu boolean, nome_app text, dbi_g2b text, id_tabella text, tabella text, sincronizzato boolean, cancellato boolean, id_struttura text)
 LANGUAGE plpgsql
AS $function$
DECLARE
propagazione_sinaaf_return boolean;
_id_tipologia_evento integer;
nome_ws_return text;
dbi_get_envelope_return text;
_id_linea_produttiva integer;
_id_stabilimento_gisa integer;
is_struttura_vet boolean;
is_struttura_detenzione boolean;
id_tabella_return text;
tabella_return text;
dipendenze_return text;
nome_campo_id_sinaaf_return text;
nome_campo_codice_sinaaf_get_return text;
nome_campo_codice_sinaaf_return text;
presente_in_gisa_return text;
_numero_microchip_assegnato text;
_id_proprietario_corrente integer;
_id_detentore_corrente integer;
_mc_esiste_in_sinaaf boolean;
_prop_esiste_in_sinaaf boolean;
_det_esiste_in_sinaaf boolean;
sincronizzato_to_return boolean;
id_sinaaf_to_return text;
id_sinaaf_secondario_to_return text;
codice_sinaaf_to_return text;
_id_proprietario text;
_controllo_detentore_cambiato boolean;
cancellato_return boolean;
codice_semantico_to_return text;
_cambio_proprietario boolean;

id_persona text;
 BEGIN
	propagazione_sinaaf_return:=false;
	sincronizzato_to_return:=false;
	



if(entita='struttura')then
_id_linea_produttiva:=(select id_linea_produttiva from opu_relazione_stabilimento_linee_produttive where id =  _identita::integer);
		tabella_return:='opu_stabilimento';
			id_tabella:='id';
			propagazione_bdu:=(select * from g2b_get_propagabilita(_identita,entita));
			nome_app:='2bdu';
			dbi_g2b:='public_functions.suap_inserisci_canile_bdu_associazioni';
			id_struttura := (select os.id from opu_relazione_stabilimento_linee_produttive orslp join opu_stabilimento os on os.id = orslp.id_stabilimento where orslp.id=_identita::integer);
		--_det_esiste_in_bdu :=(select ws.data is not null and ws.data >= t1.modified_sinaaf and t1.modified_sinaaf is not null from opu_relazione_stabilimento_linee_produttive as t1, ws_storico_chiamate ws where ws.id_tabella = t1.id::text and ws.tabella = 'opu_relazione_stabilimento_linee_produttive' and ws.esito= 'OK' and t1.id = _id_detentore_corrente order by ws.id desc limit 1);
					--f _det_esiste_in_sinaaf is null then _det_esiste_in_sinaaf:=false; end if;
			--select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
			--select orosf.id_soggetto_fisico into id_persona from opu_relazione_stabilimento_linee_produttive orslp join opu_stabilimento os on orslp.id_stabilimento=os.id join opu_rel_operatore_soggetto_fisico orosf on os.id_operatore = orosf.id_operatore where orslp.id =  _identita::integer;
end if;
	





				
				--select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
					

	
   RETURN QUERY     
	select propagazione_bdu boolean, nome_app text, dbi_g2b text, id_tabella text, tabella_return text, sincronizzato boolean, cancellato boolean,id_struttura text;    
 END;
$function$
;









CREATE OR REPLACE VIEW public.opu_operatori_denormalizzati_view_bdu
AS SELECT opu_operatori_denormalizzati_view.flag_dia,
    opu_operatori_denormalizzati_view.id_opu_operatore,
    opu_operatori_denormalizzati_view.ragione_sociale,
    opu_operatori_denormalizzati_view.partita_iva,
    opu_operatori_denormalizzati_view.codice_fiscale_impresa,
    opu_operatori_denormalizzati_view.indirizzo_sede_legale,
    opu_operatori_denormalizzati_view.comune_sede_legale,
    opu_operatori_denormalizzati_view.istat_legale,
    opu_operatori_denormalizzati_view.cap_sede_legale,
    opu_operatori_denormalizzati_view.prov_sede_legale,
    opu_operatori_denormalizzati_view.note,
    opu_operatori_denormalizzati_view.entered,
    opu_operatori_denormalizzati_view.modified,
    opu_operatori_denormalizzati_view.enteredby,
    opu_operatori_denormalizzati_view.modifiedby,
    opu_operatori_denormalizzati_view.domicilio_digitale,
    opu_operatori_denormalizzati_view.flag_ric_ce,
    opu_operatori_denormalizzati_view.num_ric_ce,
    opu_operatori_denormalizzati_view.comune,
    opu_operatori_denormalizzati_view.id_asl,
    opu_operatori_denormalizzati_view.id_stabilimento,
    opu_operatori_denormalizzati_view.esito_import,
    opu_operatori_denormalizzati_view.data_import,
    opu_operatori_denormalizzati_view.cun,
    opu_operatori_denormalizzati_view.id_sinvsa,
    opu_operatori_denormalizzati_view.descrizione_errore,
    opu_operatori_denormalizzati_view.comune_stab,
    opu_operatori_denormalizzati_view.istat_operativo,
    opu_operatori_denormalizzati_view.indirizzo_stab,
    opu_operatori_denormalizzati_view.cap_stab,
    opu_operatori_denormalizzati_view.prov_stab,
    opu_operatori_denormalizzati_view.data_fine_dia,
    opu_operatori_denormalizzati_view.categoria_rischio,
    opu_operatori_denormalizzati_view.cf_rapp_sede_legale,
    opu_operatori_denormalizzati_view.nome_rapp_sede_legale,
    opu_operatori_denormalizzati_view.cognome_rapp_sede_legale,
    opu_operatori_denormalizzati_view.codice_registrazione,
    opu_operatori_denormalizzati_view.id_norma,
    opu_operatori_denormalizzati_view.cf_correntista,
    opu_operatori_denormalizzati_view.codice_attivita,
    opu_operatori_denormalizzati_view.primario,
    opu_operatori_denormalizzati_view.attivita,
    opu_operatori_denormalizzati_view.data_inizio,
    opu_operatori_denormalizzati_view.data_fine,
    opu_operatori_denormalizzati_view.numero_registrazione,
    opu_operatori_denormalizzati_view.indirizzo_rapp_sede_legale,
    opu_operatori_denormalizzati_view.stato,
    opu_operatori_denormalizzati_view.solo_attivita,
    opu_operatori_denormalizzati_view.data_inizio_attivita,
    opu_operatori_denormalizzati_view.data_fine_attivita,
    opu_operatori_denormalizzati_view.data_prossimo_controllo,
    opu_operatori_denormalizzati_view.id_stato,
    opu_operatori_denormalizzati_view.path_attivita_completo,
    opu_operatori_denormalizzati_view.id_indirizzo,
    opu_operatori_denormalizzati_view.linee_pregresse,
    opu_operatori_denormalizzati_view.flag_nuova_gestione,
    opu_operatori_denormalizzati_view.tipo_impresa,
    opu_operatori_denormalizzati_view.tipo_societa,
    opu_operatori_denormalizzati_view.codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.id_asl_stab,
    opu_operatori_denormalizzati_view.id_linea_attivita,
    opu_operatori_denormalizzati_view.data_mod_attivita,
    opu_operatori_denormalizzati_view.stab_entered,
    opu_operatori_denormalizzati_view.linea_numero_registrazione,
    opu_operatori_denormalizzati_view.linea_stato,
    opu_operatori_denormalizzati_view.linea_stato_text,
    opu_operatori_denormalizzati_view.linea_codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.stab_codice_ufficiale_esistente,
    opu_operatori_denormalizzati_view.id_indirizzo_operatore,
    opu_operatori_denormalizzati_view.import_opu,
    opu_operatori_denormalizzati_view.id_linea_attivita_stab,
    opu_operatori_denormalizzati_view.note_operatore,
    opu_operatori_denormalizzati_view.note_stabilimento,
    opu_operatori_denormalizzati_view.linea_codice_nazionale,
    opu_operatori_denormalizzati_view.flag_pnaa,
    opu_operatori_denormalizzati_view.stab_inserito_da,
    opu_operatori_denormalizzati_view.stab_id_attivita,
    opu_operatori_denormalizzati_view.stab_descrizione_attivita,
    opu_operatori_denormalizzati_view.stab_id_carattere,
    opu_operatori_denormalizzati_view.stab_descrizione_carattere,
    opu_operatori_denormalizzati_view.impresa_id_tipo_impresa,
    opu_operatori_denormalizzati_view.stab_asl,
    opu_operatori_denormalizzati_view.flag_clean,
    opu_operatori_denormalizzati_view.data_generazione_numero,
    opu_operatori_denormalizzati_view.lat_stab,
    opu_operatori_denormalizzati_view.long_stab,
    opu_operatori_denormalizzati_view.linea_entered,
    opu_operatori_denormalizzati_view.linea_modified,
    opu_operatori_denormalizzati_view.macroarea,
    opu_operatori_denormalizzati_view.aggregazione,
    opu_operatori_denormalizzati_view.attivita_xml,
    opu_operatori_denormalizzati_view.codiceistatasl_old,
    opu_operatori_denormalizzati_view.sigla_prov_operativa,
    opu_operatori_denormalizzati_view.sigla_prov_legale,
    opu_operatori_denormalizzati_view.sigla_prov_soggfisico,
    opu_operatori_denormalizzati_view.comune_residenza,
    opu_operatori_denormalizzati_view.data_nascita_rapp_sede_legale,
    opu_operatori_denormalizzati_view.impresa_id_tipo_societa,
    opu_operatori_denormalizzati_view.comune_nascita_rapp_sede_legale,
    opu_operatori_denormalizzati_view.sesso,
    opu_operatori_denormalizzati_view.civico,
    opu_operatori_denormalizzati_view.toponimo_residenza,
    opu_operatori_denormalizzati_view.id_toponimo_residenza,
    opu_operatori_denormalizzati_view.civico_sede_legale,
    opu_operatori_denormalizzati_view.tiponimo_sede_legale,
    opu_operatori_denormalizzati_view.toponimo_sede_legale,
    opu_operatori_denormalizzati_view.civico_sede_stab,
    opu_operatori_denormalizzati_view.tiponimo_sede_stab,
    opu_operatori_denormalizzati_view.toponimo_sede_stab,
    opu_operatori_denormalizzati_view.via_rapp_sede_legale,
    opu_operatori_denormalizzati_view.via_sede_legale,
    opu_operatori_denormalizzati_view.id_comune_richiesta,
    opu_operatori_denormalizzati_view.comune_richiesta,
    opu_operatori_denormalizzati_view.via_stabilimento_calcolata,
    opu_operatori_denormalizzati_view.civico_stabilimento_calcolato,
    opu_operatori_denormalizzati_view.cap_residenza,
    opu_operatori_denormalizzati_view.nazione_residenza,
    opu_operatori_denormalizzati_view.nazione_sede_legale,
    opu_operatori_denormalizzati_view.nazione_stab,
    opu_operatori_denormalizzati_view.id_lookup_tipo_linee_mobili,
    opu_operatori_denormalizzati_view.id_tipo_linea_produttiva,
    opu_operatori_denormalizzati_view.id_soggetto_fisico,
        CASE
            WHEN opu_operatori_denormalizzati_view.codice_attivita = ANY (ARRAY['IUV-CAN-PEN'::text, 'IUV-CAN-CAN'::text, 'VET-AMBV-PU'::text, 'VET-CLIV-PU'::text, 'VET-OSPV-PU'::text, 'IUV-CAN-ALLCAN'::text, 'IUV-CAN-ALLGAT'::text, 'IUV-ADCA-ADCA'::text, 'IUV-CAN-RIFRIC'::text, 'IUV-CAN-RIFSAN'::text, 'IUV-CAN-AAF'::text, 'ASSANIM-ASSANIM-ASSANIM'::text]) THEN 5
            WHEN opu_operatori_denormalizzati_view.codice_attivita = ANY (ARRAY['IUV-CODAC-VEDCG'::text, 'IUV-COIAC-VEICG'::text, '349-93-ALPET-PRIV'::text, '349-93-ALCAT-PRIV'::text, '349-93-ALPET-ALTR'::text, '349-93-ALCAT-ALTR'::text, 'IUV-CODAC-DET'::text, 'IUV-COIAC-INGINF'::text, 'IUV-COIAC-INGSUP'::text]) THEN 6
            ELSE NULL::integer
        END AS id_linea_bdu,
            opu_operatori_denormalizzati_view.id_sinaaf,
    opu_operatori_denormalizzati_view.codice_sinaaf
   FROM opu_operatori_denormalizzati_view
     LEFT JOIN master_list_flag_linee_attivita ON master_list_flag_linee_attivita.id_linea = opu_operatori_denormalizzati_view.id_linea_attivita_stab
  WHERE master_list_flag_linee_attivita.bdu = true;


update master_list_flag_linee_attivita set incompatibilita = null where id = 1618






--NUOVO



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
  
  
--GISA
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
  
  
  CREATE TABLE public.opu_informazioni_privato (
	id_privato int4 NULL,
	id_associazione int4 NULL
);
