

CREATE OR REPLACE VIEW public.registro_sanzioni_proprietari_cani AS 
 SELECT DISTINCT a.id AS id_animale,
    a.microchip::text AS microchip,
    a.tatuaggio::text AS tatuaggio,
    a.id_proprietario,
    opu_rel.ragione_sociale AS proprietario,
    opu_rel.id_asl AS id_asl_proprietario,
    opu_rel_prov.id_asl AS id_asl_cedente,
    asl_ced.description::text AS asl_cedente,
    asl.description::text AS asl_proprietario,
    e_bdu.id_proprietario_provenienza,
    COALESCE(opu_rel_prov.ragione_sociale, opu_rel_prov_origine.ragione_sociale::text, e_bdu.ragione_sociale_provenienza) AS proprietario_provenienza,
    e.id_evento,
    e.entered AS data_inserimento_registrazione,
    e_bdu.data_registrazione,
    a.data_nascita,
    (cont.namelast::text || ' '::text) || cont.namefirst::text AS utente_inserimento,
    r.description::text AS razza,
    COALESCE(cu.data_chiusura, e_bdu.data_chiusura_sanzione) AS data_chiusura,
    COALESCE(cu.utente_chiusura, concat(cont2.namelast, ' ', cont2.namefirst)) AS utente_chiusura,
    cu.ticketid AS id_cu,
    (e_bdu.id_animale_madre IS NOT NULL AND e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario OR e_bdu.id_animale_madre IS NULL) AND (a.flag_mancata_origine IS FALSE OR a.flag_mancata_origine IS NULL) AND (e_bdu.flag_anagrafe_estera IS FALSE OR e_bdu.flag_anagrafe_estera IS NULL) AS sanzione_cedente,
    a.flag_mancata_origine OR e_bdu.flag_anagrafe_estera AS sanzione_proprietario,
        CASE
            WHEN cu.ticketid IS NOT NULL OR e_bdu.data_chiusura_sanzione IS NOT NULL THEN 'Chiusa'::text
            ELSE 'Aperta'::text
        END AS stato,
        CASE
            WHEN (e_bdu.id_animale_madre IS NOT NULL AND e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario OR e_bdu.id_animale_madre IS NULL) AND (a.flag_mancata_origine IS FALSE OR a.flag_mancata_origine IS NULL) AND (e_bdu.flag_anagrafe_estera IS FALSE OR e_bdu.flag_anagrafe_estera IS NULL) THEN concat('Cedente', COALESCE(' ASL '::text || asl_ced.description::text, ' ASL FUORI REGIONE'::text))
            WHEN a.flag_mancata_origine OR e_bdu.flag_anagrafe_estera THEN 'Proprietario'::text
            ELSE NULL::text
        END AS soggetto_sanzionato,
    e_bdu.id_animale_madre,
    COALESCE(a_madre.microchip, e_bdu.microchip_madre::character varying)::text AS microchip_madre,
    cu.numero_sanzione,
    a.flag_mancata_origine,
    e_bdu.flag_anagrafe_estera,
        CASE
            WHEN cu.ticketid IS NOT NULL OR e_bdu.data_chiusura_sanzione IS NOT NULL THEN false
            ELSE true
        END AS stato_apertura,
        CASE
            WHEN (e_bdu.id_animale_madre IS NOT NULL AND e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario OR e_bdu.id_animale_madre IS NULL) AND (a.flag_mancata_origine IS FALSE OR a.flag_mancata_origine IS NULL) AND (e_bdu.flag_anagrafe_estera IS FALSE OR e_bdu.flag_anagrafe_estera IS NULL) AND asl_ced.description::text IS NOT NULL THEN '2'::text
            WHEN (e_bdu.id_animale_madre IS NOT NULL AND e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario OR e_bdu.id_animale_madre IS NULL) AND (a.flag_mancata_origine IS FALSE OR a.flag_mancata_origine IS NULL) AND (e_bdu.flag_anagrafe_estera IS FALSE OR e_bdu.flag_anagrafe_estera IS NULL) AND asl_ced.description::text IS NULL THEN '3'::text
            WHEN a.flag_mancata_origine OR e_bdu.flag_anagrafe_estera THEN '1'::text
            ELSE NULL::text
        END AS soggetto_sanzionato_code,
    c.nome AS comune_proprietario,
    c1.nome AS comune_proprietario_provenienza
   FROM animale a
     JOIN evento e ON e.id_animale = a.id AND e.id_tipologia_evento = 1 AND e.trashed_date IS NULL AND e.data_cancellazione IS NULL
     JOIN evento_registrazione_bdu e_bdu ON e.id_evento = e_bdu.id_evento AND e_bdu.flag_anagrafe_fr IS FALSE AND (a.flag_mancata_origine OR e_bdu.id_animale_madre IS NOT NULL AND e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario OR e_bdu.id_animale_madre IS NULL)
     JOIN access_ acc ON acc.user_id = a.utente_inserimento AND acc.role_id = 24
     JOIN contact_ cont ON cont.contact_id = acc.contact_id
     JOIN opu_operatori_denormalizzati opu_rel ON opu_rel.id_rel_stab_lp = e_bdu.id_proprietario AND (opu_rel.id_linea_produttiva = ANY (ARRAY[1, 4, 5, 6]))
     LEFT JOIN opu_operatori_denormalizzati opu_rel_prov ON opu_rel_prov.id_rel_stab_lp = e_bdu.id_proprietario_provenienza
     LEFT JOIN opu_operatori_denormalizzati_origine opu_rel_prov_origine ON opu_rel_prov_origine.id_rel_stab_lp = e_bdu.id_proprietario_provenienza
     JOIN configurazione_tracciabilita_cani config ON config.data_inizio < e.entered
     LEFT JOIN animale a_madre ON a_madre.id = e_bdu.id_animale_madre
     LEFT JOIN lookup_razza r ON r.code = a.id_razza
     LEFT JOIN lookup_site_id asl ON asl.code = opu_rel.id_asl
     LEFT JOIN lookup_site_id asl_ced ON asl_ced.code = opu_rel_prov.id_asl
     LEFT JOIN access_ acc2 ON acc2.user_id = e_bdu.utente_chiusura_sanzione
     LEFT JOIN contact_ cont2 ON cont2.contact_id = acc2.contact_id

     --versione con foreign_server
     /*LEFT JOIN controlli_ufficiali_proprietari_cani cu ON cu.data_controllo >= e_bdu.data_registrazione AND cu.microchip = a.microchip::text AND cu.cf_proprietario =
        CASE
            WHEN (e_bdu.id_animale_madre IS NOT NULL AND e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario OR e_bdu.id_animale_madre IS NULL) AND (a.flag_mancata_origine IS FALSE OR a.flag_mancata_origine IS NULL) AND (e_bdu.flag_anagrafe_estera IS FALSE OR e_bdu.flag_anagrafe_estera IS NULL) THEN upper(COALESCE(opu_rel_prov.codice_fiscale, opu_rel_prov_origine.codice_fiscale::text, e_bdu.codice_fiscale_proprietario_provenienza))
            WHEN a.flag_mancata_origine OR e_bdu.flag_anagrafe_estera THEN upper(opu_rel.codice_fiscale)
            ELSE NULL::text
        END*/

        
      LEFT JOIN  (select cu.numero_sanzione,cu.ticketid, cu.data_controllo,cu.microchip,cu.cf_proprietario, cu.data_chiusura, cu.utente_chiusura 
                  FROM dblink((select * from conf.get_pg_conf('GISA')), 'select numero_sanzione,ticketid, data_controllo,microchip,cf_proprietario, data_chiusura, utente_chiusura  from controlli_ufficiali_proprietari_cani') 
                  as cu(numero_sanzione text,ticketid integer, data_controllo timestamp without time zone, microchip text,cf_proprietario text, data_chiusura timestamp without time zone, utente_chiusura text)) cu ON cu.data_controllo >= e_bdu.data_registrazione AND cu.microchip = a.microchip::text AND cu.cf_proprietario =
        CASE
            WHEN (e_bdu.id_animale_madre IS NOT NULL AND e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario OR e_bdu.id_animale_madre IS NULL) AND (a.flag_mancata_origine IS FALSE OR a.flag_mancata_origine IS NULL) AND (e_bdu.flag_anagrafe_estera IS FALSE OR e_bdu.flag_anagrafe_estera IS NULL) THEN upper(COALESCE(opu_rel_prov.codice_fiscale, opu_rel_prov_origine.codice_fiscale::text, e_bdu.codice_fiscale_proprietario_provenienza))
            WHEN a.flag_mancata_origine OR e_bdu.flag_anagrafe_estera THEN upper(opu_rel.codice_fiscale)
            ELSE NULL::text
        END



        
     LEFT JOIN comuni1 c ON opu_rel.comune = c.id
     LEFT JOIN comuni1 c1 ON opu_rel_prov.comune = c1.id
  WHERE a.trashed_date IS NULL AND a.data_cancellazione IS NULL AND a.id_specie = 1;

ALTER TABLE public.registro_sanzioni_proprietari_cani
  OWNER TO postgres;





CREATE OR REPLACE VIEW public.registro_unico_cani_rischio_elevato_aggressivita AS 
 SELECT DISTINCT a.id AS id_animale,
    a.microchip,
    a.tatuaggio,
        CASE
            WHEN a.id_specie = 1 THEN 'CANE'::text
            WHEN a.id_specie = 2 THEN 'GATTO'::text
            WHEN a.id_specie = 3 THEN 'FURETTO'::text
            ELSE NULL::text
        END AS specie,
    lr.description AS razza,
    a.flag_incrocio,
    ev.id_proprietario_corrente AS id_proprietario,
    propr.ragione_sociale AS proprietario,
    COALESCE(aggr.id_asl_proprietario, mors.id_asl_proprietario) AS id_asl_proprietario,
    asl.description AS asl_proprietario,
    ev.id_evento,
    ev.entered AS data_inserimento_registrazione,
    COALESCE(aggr.data_aggressione, mors.data_morso) AS data_registrazione,
    tipo_reg.description AS evento,
    mors.valutazione_dehasse,
    tipologia.code AS id_tipologia_registrazione,
    tipologia.description AS tipologia,
    date_part('year'::text, COALESCE(aggr.data_aggressione, mors.data_morso)) AS anno,
    ev.id_tipologia_evento,
    COALESCE(aggr.id_cu, mors.id_cu) AS id_cu,
        CASE
            WHEN ev.id_tipologia_evento = 21 THEN mors.misure_formative
            ELSE aggr.misure_formative
        END AS misure_formative,
        CASE
            WHEN ev.id_tipologia_evento = 21 THEN mors.misure_restrittive
            ELSE aggr.misure_restrittive
        END AS misure_restrittive,
        CASE
            WHEN ev.id_tipologia_evento = 21 THEN mors.misure_riabilitative
            ELSE aggr.misure_riabilitative
        END AS misure_riabilitative
   FROM evento ev
     LEFT JOIN evento_aggressione aggr ON ev.id_evento = aggr.id_evento
     LEFT JOIN evento_morsicatura mors ON ev.id_evento = mors.id_evento
     JOIN animale a ON a.id = ev.id_animale AND a.data_cancellazione IS NULL AND a.trashed_date IS NULL
     LEFT JOIN lookup_razza lr ON a.id_razza = lr.code
     JOIN lookup_tipologia_registrazione tipo_reg ON tipo_reg.code = ev.id_tipologia_evento
     LEFT JOIN scheda_morsicatura sc ON sc.id = mors.id_scheda_morsicatura
     JOIN lookup_tipologia_morso tipologia ON tipologia.code = COALESCE(aggr.tipologia, mors.tipologia)
     LEFT JOIN opu_operatori_denormalizzati propr ON propr.id_rel_stab_lp = ev.id_proprietario_corrente
     LEFT JOIN lookup_asl_rif asl ON asl.code = COALESCE(aggr.id_asl_proprietario, mors.id_asl_proprietario)
     --versione con foreign_server
     /*JOIN controlli_ufficiali_cani_aggressori cu_gisa ON cu_gisa.ticketid = COALESCE(aggr.id_cu, mors.id_cu) AND a.microchip::text = cu_gisa.microchip*/

     JOIN  (select cu.ticketid , cu.microchip FROM dblink((select * from conf.get_pg_conf('GISA')), 'select ticketid,microchip from controlli_ufficiali_cani_aggressori') as cu(ticketid integer, microchip character varying(300) )) cu ON cu.ticketid = COALESCE(aggr.id_cu, mors.id_cu) AND a.microchip::text = cu.microchip

      
  WHERE (ev.id_tipologia_evento = ANY (ARRAY[21, 68])) AND ev.data_cancellazione IS NULL AND ev.trashed_date IS NULL AND (aggr.prevedibilita_evento = 2 AND aggr.aggressione_ripetuta = 2 AND (aggr.taglia_aggressore = ANY (ARRAY[3, 4])) AND aggr.alterazioni_comportamentali = 2 AND aggr.analisi_gestione = 2 OR mors.tipologia = 2 AND (mors.valutazione_dehasse >= 14::double precision OR mors.valutazione_dehasse < 14::double precision AND mors.morso_ripetuto = 2 AND mors.alterazioni_comportamentali = 2 AND mors.analisi_gestione = 2) OR mors.tipologia = 1 AND mors.prevedibilita_evento = 2 AND mors.morso_ripetuto = 2 AND (mors.taglia_aggressore = ANY (ARRAY[3, 4])) AND (mors.categoria_vittima = ANY (ARRAY[1, 3, 4])) AND mors.taglia_vittima = 1 AND mors.alterazioni_comportamentali = 2 AND mors.analisi_gestione = 2);

ALTER TABLE public.registro_unico_cani_rischio_elevato_aggressivita
  OWNER TO postgres;



  
CREATE OR REPLACE VIEW public.uos AS 
 SELECT DISTINCT uos.id,
    uos.id_stabilimento,
    uos.id_stabilimento_gisa,
    uos.id_asl,
    uos.ragione_sociale
   FROM
   --versione con foreign server
    /*opu_operatori_denormalizzati_uos uos */
    (select id, id_stabilimento, id_stabilimento_gisa, id_asl, ragione_sociale FROM dblink((select * from conf.get_pg_conf('VAM')), 'select id, id_stabilimento, id_stabilimento_gisa, id_asl, ragione_sociale from clinica_uos ') as uos(id integer, id_stabilimento integer, id_stabilimento_gisa integer, id_asl integer, ragione_sociale text)) uos

   WHERE uos.ragione_sociale <> ALL (ARRAY['IZSM Avellino'::text, 'IZSM Benevento'::text, 'IZSM Caserta'::text, 'IZSM Portici'::text, 'IZSM Salerno'::text]);

ALTER TABLE public.uos
  OWNER TO postgres;

