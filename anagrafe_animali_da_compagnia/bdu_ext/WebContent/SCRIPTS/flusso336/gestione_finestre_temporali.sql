alter table configurazione_tracciabilita_cani add column data_fine timestamp without time zone;
update configurazione_tracciabilita_cani set data_fine = '27/01/2024 13:00', data_inizio = '15/01/2024 8:30';
insert into configurazione_tracciabilita_cani (data_inizio) values ('01/01/2030');




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
     JOIN configurazione_tracciabilita_cani config ON (config.data_inizio < e.entered or config.data_inizio is null) and (config.data_fine >  e.entered or config.data_fine is null)
     LEFT JOIN animale a_madre ON a_madre.id = e_bdu.id_animale_madre
     LEFT JOIN lookup_razza r ON r.code = a.id_razza
     LEFT JOIN lookup_site_id asl ON asl.code = opu_rel.id_asl
     LEFT JOIN lookup_site_id asl_ced ON asl_ced.code = opu_rel_prov.id_asl
     LEFT JOIN access_ acc2 ON acc2.user_id = e_bdu.utente_chiusura_sanzione
     LEFT JOIN contact_ cont2 ON cont2.contact_id = acc2.contact_id
     LEFT JOIN ( SELECT cu_1.numero_sanzione,
            cu_1.ticketid,
            cu_1.data_controllo,
            cu_1.microchip,
            cu_1.cf_proprietario,
            cu_1.data_chiusura,
            cu_1.utente_chiusura
           FROM dblink(( SELECT get_pg_conf.get_pg_conf
                   FROM conf.get_pg_conf('GISA'::text) get_pg_conf(get_pg_conf)), 'select numero_sanzione,ticketid, data_controllo,microchip,cf_proprietario, data_chiusura, utente_chiusura  from controlli_ufficiali_proprietari_cani'::text) cu_1(numero_sanzione text, ticketid integer, data_controllo timestamp without time zone, microchip text, cf_proprietario text, data_chiusura timestamp without time zone, utente_chiusura text)) cu ON cu.data_controllo >= e_bdu.data_registrazione AND cu.microchip = a.microchip::text AND cu.cf_proprietario =
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




