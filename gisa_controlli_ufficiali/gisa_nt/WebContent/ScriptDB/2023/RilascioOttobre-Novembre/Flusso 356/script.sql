
--VECCHIA GESTIONE--
alter table apicoltura_apiari add column capacita integer; 
alter table apicoltura_consistenza add column capacita integer;


insert into ws_oggetto_campi (id,id_oggetto, campo,obbligatorio) values ((select max(id)+1 from ws_oggetto_campi),8, 'capacitaStrutturale',false);





CREATE OR REPLACE VIEW public.apicoltura_apiari_denormalizzati_view
AS SELECT DISTINCT o.id AS id_apicoltura_imprese,
    stab.id AS id_apicoltura_apiari,
        CASE
            WHEN o.sincronizzato_bdn THEN 'SI'::text
            ELSE 'NO'::text
        END AS sincronizzato_bdn,
    las.description AS stato_impresa,
    lastab.description AS stato_stab,
    o.ragione_sociale,
    o.partita_iva,
    o.codice_fiscale_impresa,
    to_char(o.data_inizio, 'dd/MM/yyyy'::text) AS data_inizio_attivita,
    to_char(o.data_fine, 'dd/MM/yyyy'::text) AS data_fine_attivita,
    ((sedeop.via::text ||
        CASE
            WHEN sedeop.civico IS NOT NULL THEN ' '::text || sedeop.civico
            ELSE ''::text
        END))::character varying(300) AS indirizzo_sede_legale,
    comunisl.nome AS comune_sede_legale,
    comunisl.istat AS istat_legale,
    sedeop.id AS id_indirizzo_operatore,
    sedeop.cap AS cap_sede_legale,
    sedeop.provincia AS prov_sede_legale,
    o.note,
    o.entered,
    o.modified,
    o.enteredby,
    o.modifiedby,
    o.domicilio_digitale,
        CASE
            WHEN lokcla.code = 1 THEN 1
            WHEN lokcla.code = 2 THEN 2
            WHEN ml.fisso THEN 1
            WHEN ml.mobile THEN 2
            ELSE '-1'::integer
        END AS tipo_attivita,
        CASE
            WHEN lokcla.code = 1 THEN 'Con Sede Fissa'::text
            WHEN lokcla.code = 2 THEN 'Senza Sede Fissa'::text
            WHEN ml.fisso THEN 'Con Sede Fissa'::text
            WHEN ml.mobile THEN 'Senza Sede Fissa'::text
            ELSE 'N.D.'::text
        END AS tipo_descrizione_attivita,
    o.telefono_fisso,
    o.telefono_cellulare,
    o.faxt AS fax,
    i.comune,
    asl.description AS asl_apiario,
    stab.id AS id_stabilimento,
    stab.esito_import,
    stab.data_import,
    stab.id_sinvsa,
    stab.descrizione_errore,
    stab.progressivo,
    comuni1.nome AS comune_stab,
    comuni1.istat AS istat_operativo,
    sedestab.id AS id_indirizzo,
    concat_ws(','::text, sedestab.via, sedestab.civico)::character varying(300) AS indirizzo_stab,
    sedestab.cap AS cap_stab,
    sedestab.provincia AS prov_stab,
    stab.categoria_rischio,
    soggsl.id AS id_soggetto_fisico,
    soggsl.codice_fiscale AS cf_rapp_sede_legale,
    soggsl.nome AS nome_rapp_sede_legale,
    soggsl.cognome AS cognome_rapp_sede_legale,
    (
        CASE
            WHEN soggind.via IS NOT NULL THEN soggind.via
            ELSE ''::character varying
        END::text || ', '::text) ||
        CASE
            WHEN comunisoggind.nome IS NOT NULL THEN comunisoggind.nome
            ELSE ''::character varying
        END::text AS indirizzo_rapp_sede_legale,
    detentore.id AS id_detentore,
    detentore.codice_fiscale AS cf_detentore,
    detentore.nome AS nome_detentore,
    detentore.cognome AS cognome_detentore,
    lokmod.description AS modalita,
    lokcla.description AS classificazione,
    loksot.description AS sottospecie,
    stab.num_alveari,
    stab.num_sciami,
    stab.num_pacchi,
    stab.num_regine,
    to_char(stab.data_inizio, 'dd/MM/yyyy'::text) AS data_apertura_stab,
    to_char(stab.data_chiusura, 'dd/MM/yyyy'::text) AS data_chiusura_stab,
    stab.data_prossimo_controllo,
    asl.code AS id_asl_apiario,
    i.latitudine,
    i.longitudine,
    o.codice_azienda,
    stab.flag_laboratorio,
    COALESCE(latt.macroarea, ''::text) AS macroarea,
    COALESCE(latt.aggregazione, ''::text) AS aggregazione,
    COALESCE(latt.attivita, taa.description, ''::text) AS attivita,
    1 AS id_tipo_linea_produttiva,
    stab.data_assegnazione_censimento,
    aslperapicoltore.description AS asl_apicoltore,
    aslperapicoltore.code AS id_asl_apicoltore,
    to_char(stab.data_cessazione, 'dd/MM/yyyy'::text) AS data_cessazione_stab,
    COALESCE(latt.codice_macroarea, ''::text) AS codice_macroarea,
    COALESCE(latt.codice_aggregazione, ''::text) AS codice_aggregazione,
    latt.codice_attivita,
    stab.capacita
   FROM apicoltura_imprese o
     LEFT JOIN suap_ric_scia_operatore scia ON scia.id = o.id_richiesta_suap
     LEFT JOIN suap_ric_scia_stabilimento sciastab ON sciastab.id_operatore = scia.id
     LEFT JOIN suap_ric_scia_relazione_stabilimento_linee_produttive lps ON lps.id_stabilimento = sciastab.id
     LEFT JOIN ml8_linee_attivita_nuove_materializzata latt ON latt.id_nuova_linea_attivita = lps.id_linea_produttiva
     LEFT JOIN master_list_flag_linee_attivita ml ON ml.id_linea = latt.id_nuova_linea_attivita
     JOIN apicoltura_rel_impresa_soggetto_fisico rels ON rels.id_apicoltura_imprese = o.id AND rels.enabled
     JOIN opu_soggetto_fisico soggsl ON soggsl.id = rels.id_soggetto_fisico
     LEFT JOIN opu_indirizzo soggind ON soggind.id = soggsl.indirizzo_id
     LEFT JOIN comuni1 comunisoggind ON comunisoggind.id = soggind.comune
     JOIN apicoltura_relazione_imprese_sede_legale ros ON ros.id_apicoltura_imprese = o.id AND ros.enabled
     JOIN opu_indirizzo sedeop ON sedeop.id = ros.id_indirizzo
     JOIN comuni1 comunisl ON sedeop.comune = comunisl.id
     JOIN apicoltura_apiari stab ON stab.id_operatore = o.id
     JOIN opu_indirizzo sedestab ON sedestab.id = stab.id_indirizzo
     LEFT JOIN comuni1 ON sedestab.comune = comuni1.id
     LEFT JOIN opu_indirizzo i ON i.id = stab.id_indirizzo
     LEFT JOIN lookup_apicoltura_stati_apiario las ON las.code = o.stato
     LEFT JOIN lookup_apicoltura_stati_apiario lastab ON lastab.code = stab.stato
     LEFT JOIN apicoltura_lookup_tipo_attivita taa ON taa.code = o.tipo_attivita_apicoltura
     LEFT JOIN lookup_site_id asl ON asl.code = stab.id_asl
     LEFT JOIN lookup_site_id aslperapicoltore ON aslperapicoltore.code = o.id_asl
     LEFT JOIN opu_soggetto_fisico detentore ON detentore.id = stab.id_soggetto_fisico
     LEFT JOIN apicoltura_lookup_modalita lokmod ON lokmod.code = stab.id_apicoltura_lookup_modalita
     LEFT JOIN apicoltura_lookup_classificazione lokcla ON lokcla.code = stab.id_apicoltura_lookup_classificazione
     LEFT JOIN apicoltura_lookup_sottospecie loksot ON loksot.code = stab.id_apicoltura_lookup_sottospecie
  WHERE o.trashed_date IS NULL AND stab.trashed_date IS NULL;
 
 
  
  
  
  
  
  
  
  
  
  --VERSIONE 2
  
  
  
  alter table apicoltura_imprese add column capacita integer; 

  insert into ws_oggetto_campi (id,id_oggetto, campo,obbligatorio) values ((select max(id)+1 from ws_oggetto_campi),9, 'capacitaStrutturale',false);

  
  
  
  -- req2
  
  update master_list_flag_linee_attivita set apicoltura=true where codice_univoco='MS.000-130-AL-SN'
  
  
CREATE OR REPLACE FUNCTION public.mostra_ml(_livello integer, _id_selezionato integer, _json_flags json, _user_id integer, _linee_selezionate text DEFAULT NULL::text)
 RETURNS TABLE(id integer, descrizione text)
 LANGUAGE plpgsql
AS $function$

DECLARE

	_rev integer := (select * from get_max_rev_ml());
	
	_select_macroarea text := $$ SELECT distinct master_list_macroarea.id, concat(master_list_macroarea.macroarea, ' (', master_list_macroarea.norma, ')')::text as descrizione $$;

	_select_aggregazione text := $$ SELECT distinct master_list_aggregazione.id, master_list_aggregazione.aggregazione as descrizione $$;

	_select_linea_attivita text := $$ SELECT distinct master_list_linea_attivita.id, master_list_linea_attivita.linea_attivita as descrizione $$;

	_from text := $$ FROM master_list_macroarea join master_list_aggregazione on master_list_macroarea.id = master_list_aggregazione.id_macroarea join master_list_linea_attivita on master_list_linea_attivita.id_aggregazione=master_list_aggregazione.id left join master_list_flag_linee_attivita on master_list_flag_linee_attivita.id_linea = master_list_linea_attivita.id $$;

	_where_base text := $$ WHERE 1=1 $$; 

	--if (livello==2)
	_where_2 text := $$ and master_list_aggregazione.id_macroarea = %s $$;

	--if (livello==3)
	_where_3 text := $$ and master_list_linea_attivita.id_aggregazione = %s $$;

	--if linee_selezione <> null o vuoto
	_where_incompatibilita text := $$ and master_list_linea_attivita.id not in (
						select distinct regexp_split_to_table(string_agg(incompatibilita,','),',')::integer from master_list_flag_linee_attivita 
									where id_linea in (select distinct regexp_split_to_table(string_agg('%s',','),',')::integer)
					    )  
					$$;

	_order_clausola text := $$ ORDER BY descrizione $$;

	_select_final text;
	_from_final text;
	_where_final text;
	_qry_final text;

BEGIN

--REV
	IF _rev > 0 THEN
	_where_base = _where_base || ' and master_list_macroarea.rev = '|| _rev;
	END IF;

	-- FLAG
	select concat(_where_base, get_filtro_flags_ml) into _where_base from get_filtro_flags_ml( _json_flags);

	_where_final := _where_base;

	IF  _livello = 1 THEN 
		_select_final := _select_macroarea;
	ELSIF _livello = 2 THEN 
		_select_final := _select_aggregazione;
		_where_final := concat(_where_final,format(_where_2,_id_selezionato));
	elsif _livello != 4 then 
		_select_final := _select_linea_attivita;
		_where_final := concat(_where_final,format(_where_3,_id_selezionato));
	END IF;

	IF (length(trim(coalesce(_linee_selezionate,''))) <> 0) THEN
		_where_final := concat(_where_final,format(_where_incompatibilita,_linee_selezionate));
	END IF;
	
--LIVELLO 4 esclusione di aggregazione apiario.

IF  _livello = 4 THEN 
		_select_final := _select_aggregazione;
			_where_final := concat(_where_final,format(_where_2,_id_selezionato));
	_where_final = concat(_where_final, 'and master_list_aggregazione.id != 20433');	
end if;

	_from_final := _from;

	_qry_final := concat(_select_final, _from_final, _where_final, _order_clausola);

	raise WARNING 'dbi (public.mostra_ml) : %',_qry_final;
	
	return query
		EXECUTE _qry_final;
	

END;	
    
$function$
;

  
  
  

update apicoltura_imprese set note_hd = concat (note_hd, ' ***** ' , now(), ' - Settato id_bda = ', id_bdn_attivita), id_bda = id_bdn_attivita where id_bda is null and id_bdn_attivita is not null;
  
update apicoltura_imprese  set capacita = 10 where tipo_attivita_apicoltura = 2;
  
  update apicoltura_imprese  set capacita = 300 where tipo_attivita_apicoltura = 1;
  
 
 