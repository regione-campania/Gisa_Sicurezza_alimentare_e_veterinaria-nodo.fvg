ALTER TABLE public.animale ADD flag_incrocio bool NULL;




CREATE OR REPLACE VIEW public.registro_sanzioni_proprietari_cani
AS SELECT a.id,
    a.microchip,
    a.tatuaggio,
    a.nome,
    a.data_nascita,
    a.sesso,
    a.id_specie,
    a.id_razza,
    a.id_tipo_mantello,
    a.id_proprietario,
    a.id_asl_riferimento,
    a.id_veterinario_microchip,
    a.id_sterilizzatore,
    a.descrizione_stato,
    a.flag_anagrafato_in_clinica,
    a.flag_catturato,
    a.flag_circuito_commerciale,
    a.flag_contributo_regionale,
    a.flag_fuori_regione,
    a.flag_pensione,
    a.flag_reimmesso,
    a.flag_ritrovato,
    a.passaporto_data_rilascio,
    a.passaporto_numero,
    a.id_regione_provenienza,
    a.cattura_indirizzo,
    a.cattura_numero_verbale,
    a.flag_controllo_documentale,
    a.flag_controllo_fisico,
    a.flag_controllo_laboratorio,
    a.id_vecchio_proprietario,
    a.id_nuovo_proprietario,
    a.id_asl_destinazione,
    a.id_partita_circuito_commerciale,
    a.id_pratica_contributi,
    a.id_pratica_contributi_separata,
    a.id_asl_riferimento_old,
    a.id_asl_destinazione_old,
    a.id_sterilizzatore_old,
    a.note,
    a.segni_particolari,
    a.export_fase2_errore_etl,
    a.export_fase2_errore_bdn,
    a.export_fase2_errore_bdn_codice,
    a.export_fase2_errore_etl_codice,
    a.utente_inserimento,
    a.utente_modifica,
    a.utente_cancellazione,
    a.data_aggiornamento_stato,
    a.data_registrazione,
    a.data_sterilizzazione,
    a.data_microchip,
    a.data_rientro_da_fuori_regione,
    a.cattura_data,
    a.data_inserimento,
    a.flag_data_nascita_presunta,
    a.trashed_date,
    a.flag_sterilizzazione,
    a.flag_decesso,
    a.flag_smarrimento,
    a.data_rilascio_passaporto,
    a.numero_passaporto,
    a.stato,
    a.id_regione,
    a.id_comune_cattura,
    a.flag_controllo_identita,
    a.id_esito_controllo_documentale,
    a.id_esito_controllo_fisico,
    a.id_esito_controllo_identita,
    a.id_esito_controllo_laboratorio,
    a.data_esito_controllo_documentale,
    a.data_esito_controllo_fisico,
    a.data_esito_controllo_identita,
    a.data_esito_controllo_laboratorio,
    a.flag_vincolato,
    a.data_modifica,
    a.id_proprietario_ultimo_trasferimento_a_regione,
    a.old_asset_id,
    a.flag_canina_felina,
    a.data_tatuaggio,
    a.id_proprietario_ultimo_trasferimento_a_stato,
    a.id_continente,
    a.note_internal_use_only,
    a.data_cancellazione,
    a.id_detentore,
    a.id_detentore_ultimo_trasferimento_a_stato,
    a.id_detentore_ultimo_trasferimento_a_regione,
    a.id_taglia,
    a.export_fase2_data_ultima_estrazione,
    a.data_export,
    a.export_fase2_data_ultimo_aggiornamento,
    a.export_fase2_data_inserimento,
    a.note_trashed,
    a.vaccino_data,
    a.vaccino_numero_lotto,
    a.flag_detenuto_in_canile_dopo_ritrovamento,
    a.origine_registrazione,
    a.vaccino_data_scadenza,
    a.vaccino_nome,
    a.vaccino_produttore,
    a.flag_furto,
    a.flag_ultima_operazione_eseguita_fuori_dominio_asl,
    a.id_asl_fuori_dominio_ultima_registrazione,
    a.id_evento_ultima_registrazione_fuori_dominio,
    a.id_detentore_ultima_registrazione_fuori_dominio,
    a.id_stato_ultima_registrazione_fuori_dominio,
    a.id_tipologia_registrazione_fuori_dominio_asl,
    a.flag_bloccato,
    a.id_ultima_registrazione_blocco,
    a.flag_attivita_itinerante,
    a.id_comune_attivita_itinerante,
    a.luogo_attivita_itinerante,
    a.data_attivita_itinerante,
    a.data_scadenza_passaporto,
    a.id_detentore_old,
    a.recuperato,
    a.id_upload,
    a.export_fase2_data_ultimo_allineamento_bdn,
    a.flag_mancata_origine,
    a.export_fase2_url_ultima_estrazione,
    a.export_fase2_browser_ultima_estrazione,
    a.export_fase2_data_client_ultima_estrazione,
    a.export_fase2_ip_ultima_estrazione,
    a.export_fase2_note_hd,
    a.cf_veterinario_microchip,
    a.altra_diagnosi_note,
    a.altra_diagnosi,
    a.sinaaf_mantello_non_noto,
    a.flag_incrocio
   FROM animale a
     JOIN evento e ON e.id_animale = a.id AND e.id_tipologia_evento = 1 AND e.trashed_date IS NULL AND e.data_cancellazione IS NULL
     JOIN evento_registrazione_bdu e_bdu ON e.id_evento = e_bdu.id_evento AND e_bdu.flag_anagrafe_fr IS FALSE AND e_bdu.id_proprietario_provenienza IS NOT NULL AND e_bdu.id_animale_madre IS NOT NULL
     JOIN access_ acc ON acc.user_id = a.utente_inserimento AND acc.role_id = 24
     JOIN opu_relazione_stabilimento_linee_produttive opu_rel ON opu_rel.id = e_bdu.id_proprietario AND (opu_rel.id_linea_produttiva = ANY (ARRAY[1, 4, 5, 6]))
  WHERE a.trashed_date IS NULL AND a.data_cancellazione IS NULL AND a.id_specie = 1 AND (a.data_inserimento - a.data_nascita) < '1 year'::interval;










drop function public_functions.dbi_bdu_animali_vivi( integer,  integer, integer);
CREATE OR REPLACE FUNCTION public_functions.dbi_bdu_animali_vivi(tipospecie integer, asl_input integer, anno_inserimento integer)
 RETURNS TABLE(data_inserimento timestamp without time zone, data_registrazione timestamp without time zone, microchip text, tatuaggio text, inserito_da text, ruolo_inserito_da text, id_animale integer, specie text, razza text, flag_incrocio boolean, data_nascita timestamp without time zone, sesso text, stato_animale text, cognome_proprietario text, nome_proprietario text, codice_fiscale text, indirizzo_proprietario text, cap text, comune_proprietario text, id_asl integer, asl text)
 LANGUAGE plpgsql
 STRICT
AS $function$
BEGIN
	FOR data_inserimento, data_registrazione,microchip,tatuaggio,inserito_da, ruolo_inserito_da,id_animale, specie, razza,flag_incrocio, data_nascita,sesso,stato_animale,cognome_proprietario,nome_proprietario,codice_fiscale,indirizzo_proprietario,cap,comune_proprietario, id_asl, asl

		in
select 
a.data_inserimento as data_inserimento, 
a.data_registrazione as data_registrazione,
COALESCE (a.microchip  , 'N.D.') as microchip,
case when a.tatuaggio='' then 'N.D.'::text else a.tatuaggio end as tatuaggio,
pg_catalog.concat(contatto.namefirst, ' ', contatto.namelast) AS inserito_da, 
ruoli.role AS ruolo_inserito_da,
a.id AS id_animale, 
case when a.id_specie =1 then 'CANE'::text when a.id_specie=2 then 'GATTO'::text when a.id_specie=3 then 'FURETTO'::text end AS specie, 
razza.description AS razza, 
a.flag_incrocio as flag_incrocio,
a.data_nascita,
a.sesso,
lts.description as stato_animale,
osf.cognome as cognome_proprietario,
osf.nome as nome_proprietario,
osf.codice_fiscale,oi.via as indirizzo_proprietario,
oi.cap,com.nome as comune_proprietario ,
a.id_asl_riferimento as id_asl,
asl_rif.description as asl 
from animale a
join lookup_tipologia_stato lts on a.stato = lts.code
join opu_relazione_stabilimento_linee_produttive oprl on  a.id_proprietario = oprl.id and oprl.trashed_date is null
join opu_stabilimento os on oprl.id_stabilimento = os.id
join opu_soggetto_fisico osf on os.id_soggetto_fisico = osf.id and osf.trashed_date is null
join opu_indirizzo oi on os.id_indirizzo = oi.id
join comuni1 com on oi.comune = com.id
LEFT JOIN access_ utenti ON a.utente_inserimento = utenti.user_id
LEFT JOIN contact_ contatto ON utenti.contact_id = contatto.contact_id
LEFT JOIN role ruoli ON utenti.role_id = ruoli.role_id
LEFT JOIN lookup_razza razza ON razza.code = a.id_razza
LEFT JOIN lookup_asl_rif asl_rif on asl_rif.code = a.id_asl_riferimento
where a.stato in (2,4,13,19,27,5,8,12,18,20,21,22,29,74,78) and 
a.id_asl_riferimento =  os.id_asl and 
a.data_cancellazione is null and 
a.trashed_date is null and 
osf.codice_fiscale is not null
and 
 (
  (tipospecie>-1 and a.id_specie = tipospecie)
 or (tipospecie=-1)
  )
  and (
   (asl_input>-1 and a.id_asl_riferimento = asl_input)
 or (asl_input=-1)
  )
  and(
  (anno_inserimento>-1 and date_part('year'::text, a.data_inserimento) = anno_inserimento)
  or (anno_inserimento=-1)
  )
    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$function$
;


drop view public.registro_unico_cani_rischio_elevato_aggressivita;
CREATE OR REPLACE VIEW public.registro_unico_cani_rischio_elevato_aggressivita
AS SELECT DISTINCT a.id AS id_animale,
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
     JOIN controlli_ufficiali_cani_aggressori cu_gisa ON cu_gisa.ticketid = COALESCE(aggr.id_cu, mors.id_cu) AND a.microchip::text = cu_gisa.microchip
  WHERE (ev.id_tipologia_evento = ANY (ARRAY[21, 68])) AND ev.data_cancellazione IS NULL AND ev.trashed_date IS NULL AND (aggr.prevedibilita_evento = 2 AND aggr.aggressione_ripetuta = 2 AND (aggr.taglia_aggressore = ANY (ARRAY[3, 4])) AND aggr.alterazioni_comportamentali = 2 AND aggr.analisi_gestione = 2 OR mors.tipologia = 2 AND (mors.valutazione_dehasse >= 14::double precision OR mors.valutazione_dehasse < 14::double precision AND mors.morso_ripetuto = 2 AND mors.alterazioni_comportamentali = 2 AND mors.analisi_gestione = 2) OR mors.tipologia = 1 AND mors.prevedibilita_evento = 2 AND mors.morso_ripetuto = 2 AND (mors.taglia_aggressore = ANY (ARRAY[3, 4])) AND (mors.categoria_vittima = ANY (ARRAY[1, 3, 4])) AND mors.taglia_vittima = 1 AND mors.alterazioni_comportamentali = 2 AND mors.analisi_gestione = 2);


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 





drop function public_functions.dbi_bdu_registrazioni_data_evento;





CREATE OR REPLACE FUNCTION public_functions.dbi_bdu_registrazioni_data_evento(_tipospecie integer, _asl integer, _tiporegistrazione integer, _annoevento integer)
 RETURNS TABLE(id_animale integer, data_furto timestamp without time zone, luogo_furto text, dati_denuncia_furto text, importo_smarrimento double precision, luogo_smarrimento text, data_smarrimento timestamp without time zone, data_decesso timestamp without time zone, tipo_decesso text, luogo_decesso text, data_ritrovamento timestamp without time zone, ritrovamento_non_denunciato text, luogo_ritrovamento text, comune_ritrovamento text, nuovo_proprietario_ritrovamento text, asl_proprietario_sterilizzazione text, comune_cattura text, data_sterilizzazione timestamp without time zone, sterilizzazione_con_contributo text, sterilizzazione_progetto_canili text, ente_sterilizzazione text, veterinario_1_sterilizzazione text, veterinario_2_sterilizzazione text, evento_pregresso text, data_cattura timestamp without time zone, verbale_cattura text, data_rilascio_passaporto timestamp without time zone, data_scadenza_passaporto timestamp without time zone, numero_passaporto text, rinnovo_passaporto text, data_trasferimento timestamp without time zone, nuovo_proprietario_trasferimento text, vecchio_proprietario_trasferimento text, vecchio_detentore_trasferimento text, data_trasferimento_fuoriregione timestamp without time zone, regione_destinazione_fuoriregione text, data_cessione timestamp without time zone, vecchio_proprietario_cessione text, asl_vecchio_proprietario_cessione text, asl_nuovo_proprietario_cessione text, data_adozione_colonia timestamp without time zone, vecchio_proprietario_adozione_colonia text, vecchio_detentore_adozione_colonia text, nuovo_proprietario_adozione_colonia text, data_adozione_canile timestamp without time zone, vecchio_proprietario_adozione_canile text, vecchio_detentore_adozione_canile text, tipo_adozione text, nuovo_proprietario_adozione_canile text, data_presa_in_carico timestamp without time zone, nuovo_proprietario_presa_in_carico text, data_reimmissione timestamp without time zone, comune_reimmissione text, data_rientro_fuoriregione timestamp without time zone, regione_rientro_fuori_regione text, luogo_rientro_fuori_regione text, data_prelievo_leishmania timestamp without time zone, veterinario_prelievo_leishmania text, asl_evento text, id_asl integer, inserita_da text, ruolo_inserita_da text, specie text,razza text,flag_incrocio boolean ,microchip text, tatuaggio text, id_tipologia_registrazione integer, descrizione_tipologia_registrazione text, id_evento integer, data_operazione_sistema timestamp without time zone, data_evento timestamp without time zone, proprietario_pre_evento text, detentore_pre_evento text, tipologia_proprietario_pre_evento text, tipologia_detentore_pre_evento text, nuovo_proprietario_cessione text, nuovo_proprietario_presa_cessione text, nuovo_proprietario_presa_in_carico_adozione_fa text, vecchio_proprietario_trasferimento_fuori_regione text, nuovo_proprietario_trasferimento_fuori_regione text, nuovo_proprietario_trasferimento_canile text, vecchio_detentore_trasferimento_canile text, nuovo_proprietario_trasf_sindaco text, vecchio_proprietario_trasferimento_fuori_stato text, nuovo_proprietario_trasferimento_fuori_stato text, data_allontanamento timestamp without time zone, medico_esecutore_allontanamento text, veterinario_allontanamento text, causale_allontanamento text, data_mutilazione timestamp without time zone, medico_esecutore_mutilazione text, veterinario_mutilazione text, intervento_eseguito_mutilazione text, causale_mutilazione text, data_adozione_fuori_asl timestamp without time zone, vecchio_detentore_adozione_fuori_asl text, nuovo_proprietario_adozione_fuori_asl text)
 LANGUAGE plpgsql
 STRICT
AS $function$
BEGIN FOR 
   id_animale ,
   data_furto , 
   luogo_furto , 
   dati_denuncia_furto ,
   importo_smarrimento ,
   luogo_smarrimento ,
   data_smarrimento ,
   data_decesso,
   tipo_decesso ,
   luogo_decesso ,
   data_ritrovamento , 
   ritrovamento_non_denunciato , 
   luogo_ritrovamento  ,
   comune_ritrovamento , 
   nuovo_proprietario_ritrovamento ,
   asl_proprietario_sterilizzazione ,
   comune_cattura  ,
   data_sterilizzazione , 
   sterilizzazione_con_contributo  ,
   sterilizzazione_progetto_canili  ,
   ente_sterilizzazione , 
   veterinario_1_sterilizzazione , 
   veterinario_2_sterilizzazione ,
   evento_pregresso   ,
   data_cattura ,
   verbale_cattura ,
   data_rilascio_passaporto , 
   data_scadenza_passaporto  ,
   numero_passaporto ,
   rinnovo_passaporto , 
   data_trasferimento  ,
   nuovo_proprietario_trasferimento  ,
   vecchio_proprietario_trasferimento , 
   vecchio_detentore_trasferimento , 
   data_trasferimento_fuoriregione  ,
   regione_destinazione_fuoriregione , 
   data_cessione ,
   vecchio_proprietario_cessione , 
   asl_vecchio_proprietario_cessione ,
   asl_nuovo_proprietario_cessione  ,
   data_adozione_colonia  ,
   vecchio_proprietario_adozione_colonia  ,
   vecchio_detentore_adozione_colonia  ,
   nuovo_proprietario_adozione_colonia , 
   data_adozione_canile  ,
   vecchio_proprietario_adozione_canile , 
   vecchio_detentore_adozione_canile  ,
   --nuovo_proprietario_adozione_canile  ,
   tipo_adozione ,
   --data_adozione  ,
  -- vecchio_detentore , 
   nuovo_proprietario_adozione_canile ,
   data_presa_in_carico  ,
 nuovo_proprietario_presa_in_carico , 
data_reimmissione  ,
comune_reimmissione ,  
data_rientro_fuoriregione  ,
regione_rientro_fuori_regione  ,
luogo_rientro_fuori_regione  ,
data_prelievo_leishmania,
veterinario_prelievo_leishmania,
  asl_evento , 
  id_asl ,
   inserita_da , 
   ruolo_inserita_da , 
   specie , 
   razza,
   flag_incrocio,
   microchip , 
   tatuaggio , 
   id_tipologia_registrazione, 
   descrizione_tipologia_registrazione, 
   id_evento ,
   data_operazione_sistema  , 
   data_evento, 
   --entered,
   proprietario_pre_evento, 
   detentore_pre_evento, 
   tipologia_proprietario_pre_evento, 
   tipologia_detentore_pre_evento,
   nuovo_proprietario_cessione,
   nuovo_proprietario_presa_cessione,
   nuovo_proprietario_presa_in_carico_adozione_fa,
   --codice_fiscale_nuovo_proprietario_presa_in_carico_adozione_fa,
   vecchio_proprietario_trasferimento_fuori_regione,
   nuovo_proprietario_trasferimento_fuori_regione,
   nuovo_proprietario_trasferimento_canile,
   vecchio_detentore_trasferimento_canile,
   nuovo_proprietario_trasf_sindaco,
   vecchio_proprietario_trasferimento_fuori_stato,
   nuovo_proprietario_trasferimento_fuori_stato,
   data_allontanamento,
medico_esecutore_allontanamento,
veterinario_allontanamento,
causale_allontanamento,
data_mutilazione,
medico_esecutore_mutilazione,
veterinario_mutilazione,
intervento_eseguito_mutilazione,
causale_mutilazione,
data_adozione_fuori_asl,
vecchio_detentore_adozione_fuori_asl,
nuovo_proprietario_adozione_fuori_asl
	in
 SELECT 
 animale.id as id_animale,
 --FURTO
furto.data_furto as data_furto,
furto.luogo_furto as luogo_furto ,
furto.dati_denuncia as dati_denuncia_furto,
--SMARRIMENTO
smar.importo_smarrimento as importo_smarrimento,
smar.luogo_smarrimento as luogo_smarrimento,
smar.data_smarrimento as data_smarrimento,
--DECESSO
decesso.data_decesso as data_decesso,
listadecessi.description as tipo_decesso,
decesso.luogo_decesso as luogo_decesso, 
--RITROVAMENTO E RITROVAMENTO ND  
CASE when reg.id_tipologia_evento = 12 then ritro.data_ritrovamento when reg.id_tipologia_evento = 41 then ritro_nd.data_ritrovamento_nd end as data_ritrovamento,
  CASE when reg.id_tipologia_evento = 12 then 'NO' when reg.id_tipologia_evento = 41 then 'SI' end as ritrovamento_non_denunciato,
  CASE when reg.id_tipologia_evento = 12 then ritro.luogo_ritrovamento when reg.id_tipologia_evento = 41 then ritro_nd.luogo_ritrovamento_nd end as luogo_ritrovamento,
    CASE when reg.id_tipologia_evento = 12 then comuni.nome when reg.id_tipologia_evento = 41 then comuni_nd.nome end as comune_ritrovamento,
CASE when reg.id_tipologia_evento = 12 then den.ragione_sociale when reg.id_tipologia_evento = 41 then den_nd.ragione_sociale end as nuovo_proprietario,
listaasl_ster.description as asl_proprietario_sterilizzazione,
COALESCE(comunicane.nome, com1.nome, comunigatto.nome) AS comune_cattura_sterilizzazione,
ster.data_sterilizzazione, 
CASE WHEN (ster.flag_richiesta_contributo_regionale and ster.id_progetto_di_sterilizzazione_richiesto > 0) THEN 'SI'::text ELSE 'NO'::text END AS sterilizzazione_con_contributo,
CASE WHEN ster.id_progetto_di_sterilizzazione_richiesto in (select id_pratica from pratiche_contributi_canili) then 'SI'::text ELSE 'NO'::text END as sterilizzazione_progetto_canili,
CASE WHEN ster.tipologia_soggetto_sterilizzante=1 THEN 'ASL'::text WHEN ster.tipologia_soggetto_sterilizzante=2 THEN 'LLPP' WHEN ster.tipologia_soggetto_sterilizzante is null THEN 'ASL' END as ente_sterilizzazione,
concat_ws( vet_1_ster_contact.namelast,  vet_1_ster_contact.namefirst, ' ') as  veterinario_1_sterilizzazione,
concat_ws( vet_2_ster_contact.namelast,  vet_2_ster_contact.namefirst, ' ') as  veterinario_2_sterilizzazione,
CASE WHEN reg.inserimento_registrazione_forzato THEN 'SI'::text ELSE 'NO'::text END AS evento_pregresso,
cattura.data_cattura ,
--COALESCE(comuni.nome, 'N.D.') as comune_cattura,
cattura.verbale_cattura,
ril_passaporto.data_rilascio_passaporto, 
ril_passaporto.data_scadenza_passaporto ,
ril_passaporto.numero_passaporto,
case when ril_passaporto.flag_rinnovo = true then 'SI'::text when ril_passaporto.flag_rinnovo =false then 'NO'::text when ril_passaporto.flag_rinnovo is null then 'NO'::text end AS rinnovo_passaporto, 
trasf.data_trasferimento ,
rel_nuovo.ragione_sociale as nuovo_proprietario_trasferimento,
rel_vecchio.ragione_sociale as vecchio_proprietario_trasferimento, 
rel_vecchio_det.ragione_sociale as vecchio_detentore_trasferimento,
trasf_fr.data_trasferimento_fuori_regione ,
regioni.description as regione_destinazione_fuoriregione,   
cessione.data_cessione,
vecchio_proprietario.ragione_sociale as vecchio_proprietario, 
listaasl_vecchio.description as asl_vecchio_proprietario_cessione, 
listaasl_nuovo.description as asl_nuovo_proprietario_cessione,
ado_colonia.data_adozione_colonia ,
 vecchio_colonia_prop.ragione_sociale AS vecchio_proprietario_adozione_colonia,
vecchio_colonia_det.ragione_sociale AS vecchio_detentore_adozione_colonia,
nuovo_prop.ragione_sociale AS nuovo_proprietario_adozione_colonia,
 ado_canile.data_adozione ,
 vecchio_canile_prop.ragione_sociale AS vecchio_proprietario_adozione_canile,
vecchio_canile_det.ragione_sociale AS vecchio_detentore_adozione_canile,
--nuovo_prop.ragione_sociale AS nuovo_proprietario_adozione_canile,
 tipo_adozione ,
 --case when reg.id_tipologia_evento = 13 then ado_canile.data_adozione when reg.id_tipologia_evento = 19 then ado_colonia.data_adozione_colonia when reg.id_tipologia_evento = 46 then ado_fa.data_adozione_fa end as data_adozione
--, case when reg.id_tipologia_evento = 13 then den_canile_origine.ragione_sociale when reg.id_tipologia_evento = 19 then den_colonia_origine.ragione_sociale when reg.id_tipologia_evento = 46 then den_fa_origine.ragione_sociale end as vecchio_detentore
--,
 case when reg.id_tipologia_evento = 13 then den_canile.ragione_sociale when reg.id_tipologia_evento = 19 then den_colonia.ragione_sociale when reg.id_tipologia_evento = 46 then den_fa.ragione_sociale end as nuovo_proprietario ,
 presa.data_presa_in_carico , 
 nuovo_proprietario.ragione_sociale as nuovo_proprietario, 
reimmissione.data_reimmissione ,
comuni_reimmissione.nome as comune_reimmissione,  
rientro_fr.data_rientro_fr ,
regione_rientro_fuori_regione ,
rientro_fr.luogo ,
prelievo_leish.data_prelievo_leish as data_prelievo_leishmania,
case when (prelievo_leish.id_veterinario_llpp is not null and cc.namelast is not null) then concat(cc.namelast ,',', cc.namefirst) 
when (prelievo_leish.id_veterinario_llpp is null and cc.namelast is not null) then concat(cc.namelast ,',', cc.namefirst)   end as veterinario_prelievo_leishmaniosi,

 listaasl.description AS asl_evento, 
 reg.id_asl as id_asl,
 pg_catalog.concat(contatto.namefirst, ' ', contatto.namelast) AS inserita_da, 
 listaruoli.role AS ruolo_inserita_da, 
 CASE       WHEN animale.id_specie = 1 THEN 'CANE'::text
            WHEN animale.id_specie = 2 THEN 'GATTO'::text
            WHEN animale.id_specie = 3 THEN 'FURETTO'::text
            ELSE NULL::text
        END AS specie,
        razza.description as razza,
        animale.flag_incrocio as flag_incrocio ,
 CASE
            WHEN animale.microchip::text = ''::text THEN 'N.D.'::text::character varying
            ELSE animale.microchip
	END AS microchip, 
 CASE
            WHEN animale.tatuaggio::text = ''::text THEN 'N.D.'::text::character varying
            ELSE animale.tatuaggio
        END AS tatuaggio, 
 listaregistrazioni.code AS id_tipologia_registrazione,
 listaregistrazioni.description AS descrizione_tipologia_registrazione, 
 reg.id_evento as id_evento,
reg.entered AS data_operazione_sistema, 
        coalesce(
CASE
            WHEN reg.id_tipologia_evento = 1 THEN registrazione.data_registrazione
            WHEN reg.id_tipologia_evento = 2 THEN ster.data_sterilizzazione
            WHEN reg.id_tipologia_evento = 3 THEN ins_microchip.data_inserimento_microchip
            WHEN reg.id_tipologia_evento = 4 THEN furto.data_furto
            WHEN reg.id_tipologia_evento = 5 THEN cattura.data_cattura
            WHEN reg.id_tipologia_evento = 6 THEN ril_passaporto.data_rilascio_passaporto
            WHEN reg.id_tipologia_evento = 7 THEN cessione.data_cessione
            WHEN reg.id_tipologia_evento = 8 THEN trasf_fr.data_trasferimento_fuori_regione
            WHEN reg.id_tipologia_evento = 9 THEN decesso.data_decesso
            WHEN reg.id_tipologia_evento = 11 THEN smar.data_smarrimento
            WHEN reg.id_tipologia_evento = 12 THEN ritro.data_ritrovamento
            WHEN reg.id_tipologia_evento = 13 THEN ado_canile.data_adozione
            WHEN reg.id_tipologia_evento = 14 THEN rest_canile.data_restituzione_canile
            WHEN reg.id_tipologia_evento = 15 THEN presa.data_presa_in_carico
            WHEN reg.id_tipologia_evento = 16 THEN trasf.data_trasferimento
            WHEN reg.id_tipologia_evento = 17 THEN rientro_fr.data_rientro_fr
            WHEN reg.id_tipologia_evento = 18 THEN cambio.data_cambio_detentore
            WHEN reg.id_tipologia_evento = 19 THEN ado_colonia.data_adozione_colonia
            WHEN reg.id_tipologia_evento = 21 THEN morsicatura.data_morso
            WHEN reg.id_tipologia_evento = 23 THEN reimmissione.data_reimmissione
            WHEN reg.id_tipologia_evento = 24 THEN cattura.data_cattura
            WHEN reg.id_tipologia_evento = 26 THEN controlli.data_registrazione_esiti -------------------------------
            WHEN reg.id_tipologia_evento = 31 THEN trasf_canile.data_trasferimento_canile
             WHEN reg.id_tipologia_evento = 33 THEN reg.modified ------------------------------
            WHEN reg.id_tipologia_evento = 36 THEN ins_vaccino.data_inserimento_vaccinazione
            WHEN reg.id_tipologia_evento = 38 THEN ins_microchip.data_inserimento_microchip
            WHEN reg.id_tipologia_evento = 39 THEN trasf_fs.data_trasferimento_fuori_stato
            --WHEN reg.id_tipologia_evento = 40 THEN trasf_fr_sp.data_trasferimento_fuori_regione_solo_proprietario
            WHEN reg.id_tipologia_evento = 42 THEN rientro_fs.data_rientro_fuori_stato
            WHEN reg.id_tipologia_evento = 43 THEN residenza.data_modifica_residenza
            WHEN reg.id_tipologia_evento = 50 THEN dna.data_prelievo
            WHEN reg.id_tipologia_evento = 45 THEN rest.data_restituzione
            WHEN reg.id_tipologia_evento = 46 then ado_fa.data_adozione_fa
            WHEN reg.id_tipologia_evento = 47 then presa_ado_fa.data_presa_in_carico_adozione_fa
            WHEN reg.id_tipologia_evento = 41 then ritro_nd.data_ritrovamento_nd
            WHEN reg.id_tipologia_evento = 54 then prelievo_leish.data_prelievo_leish
            WHEN reg.id_tipologia_evento = 55 then trasf_sindaco.data_trasferimento
            ELSE null::timestamp without time zone
        END,reg.entered) AS data_evento,
               -- reg.entered,
        propc.ragione_sociale as proprietario_pre_evento, 
        detc.ragione_sociale as detentore_pre_evento, 
	propcdesc.description as tipologia_proprietario_pre_evento, 
	detcdesc.description as tipologia_detentore_pre_evento,
	nuovo_proprietario_cessione.ragione_sociale as nuovo_proprietario_cessione,
	nuovo_proprietario.ragione_sociale as nuovo_proprietario_presa_cessione,
	/* NUOVO PROPRIETARIO PRESA IN CARICO ADOZIONE FUORI AMBITO ASL */
        nuovo_proprietario_presa_ado_fa.ragione_sociale as nuovo_proprietario_presa_in_carico_adozione_fa,
--        nuovo_proprietario_presa_ado_fa.codice_fiscale as codice_fiscale_nuovo_proprietario_presa_in_carico_adozione_fa,
        trasf_fr_vecchio.ragione_sociale as vecchio_proprietario_trasferimento_fuori_regione,
        trasf_fr.dati_proprietario_fuori_regione as nuovo_proprietario_trasferimento_fuori_regione,
        nuovo_propr_trasf_canile.ragione_sociale as nuovo_proprietario_trasferimento_canile,
        vecchio_det_trasf_canile.ragione_sociale as vecchio_detentore_trasferimento_canile,
        nuovo_propr_trasf_sindaco.ragione_sociale as nuovo_proprietario_trasf_sindaco,
        vecchio_propr_trasf_fuori_stato.ragione_sociale as vecchio_proprietario_trasferimento_fuori_stato,
        trasf_fs.dati_proprietario_fuori_stato as nuovo_proprietario_trasferimento_fuori_stato,
        allo.data_allontanamento,
        allo_lme.description as medico_esecutore_allontanamento,
	CASE WHEN allo.id_medico_esecutore =1 THEN allo_veterinariasl.description WHEN allo.id_medico_esecutore = 2 THEN allo_veterinariprivati.description END as veterinario_allontanamento,
	allo_lc.description as causale_allontanamento,
	muti.data_mutilazione,
	muti_lme.description as medico_esecutore_mutilazione,
	CASE WHEN muti.id_medico_esecutore =1 THEN muti_veterinariasl.description WHEN muti.id_medico_esecutore = 2 THEN muti_veterinariprivati.description END as veterinario_allontanamento,
	muti_lie.description as intervento_eseguito_mutilazione,
	muti_lc.description as causale_mutilazione,
	ado_fa.data_adozione_fa as data_adozione_fuori_asl,
den_canile_origine.ragione_sociale as vecchio_detentore_adozione_fuori_asl,
den_fa.ragione_sociale as nuovo_proprietario_adozione_fuori_asl
	
   FROM evento reg

     LEFT JOIN animale ON animale.id = reg.id_animale
	LEFT JOIN lookup_razza razza ON razza.code = animale.id_razza
   /*FURTO*/
   LEFT JOIN evento_furto furto ON furto.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=4) or _tiporegistrazione=-1)
  /*SMARRIMENTO*/
  LEFT JOIN evento_smarrimento smar ON smar.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=11) or _tiporegistrazione=-1)

 /*DECESSO*/
    LEFT JOIN evento_decesso decesso ON decesso.id_evento = reg.id_evento 
    left join lookup_tipologia_decesso listadecessi on decesso.id_causa_decesso = listadecessi.code 
    and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=9) or _tiporegistrazione=-1)

 /*RITROVAMENTO*/
   LEFT JOIN evento_ritrovamento ritro ON ritro.id_evento = reg.id_evento                                                     
   left join opu_operatori_denormalizzati den on ritro.id_proprietario_dopo_ritrovamento = den.id_rel_stab_lp and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=12) or _tiporegistrazione=-1)

 /*RITROVAMENTO ND*/

   left join evento_ritrovamento_non_denunciato ritro_nd on ritro_nd.id_evento = reg.id_evento
   left join opu_operatori_denormalizzati den_nd on ritro_nd.id_detentore_dopo_ritrovamento_nd = den_nd.id_rel_stab_lp 
   left join comuni1 comuni_nd on comuni_nd.id = ritro_nd.comune_ritrovamento_nd 
   and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=41) or _tiporegistrazione=-1)

/*STERILIZZAZIONE*/

  LEFT JOIN evento_sterilizzazione ster ON ster.id_evento = reg.id_evento
  left join lookup_asl_rif listaasl_ster on listaasl_ster.code = ster.id_asl_proprietario
  left join lookup_asl_rif listaenti on listaenti.code = ster.id_soggetto_sterilizzante and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=2) or _tiporegistrazione=-1)
  left join access_ vet_1_ster_acc on vet_1_ster_acc.user_id = ster.veterinario_asl_1
  left join contact_ vet_1_ster_contact on vet_1_ster_contact.user_id = vet_1_ster_acc.user_id
  left join access_ vet_2_ster_acc on vet_2_ster_acc.user_id = ster.veterinario_asl_2
  left join contact_ vet_2_ster_contact on vet_2_ster_contact.user_id = vet_2_ster_acc.user_id
--left join lookup_asl_rif listaaslevento on listaaslevento.code = reg.id_asl

/*CATTURA*/
   LEFT JOIN evento_cattura cattura ON cattura.id_evento = reg.id_evento
   LEFT JOIN comuni1 comuni ON comuni.id = cattura.id_comune_cattura 
   LEFT JOIN cane on cane.id_animale = animale.id
   LEFT JOIN gatto on gatto.id_animale = animale.id
   LEFT JOIN comuni1 comunicane on comunicane.id = cane.id_comune_cattura 
   LEFT JOIN comuni1 comunigatto on comunigatto.id = gatto.id_comune_cattura 
   left join comuni1 com1 on com1.id = animale.id_comune_cattura 
    and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=5) or _tiporegistrazione=-1)

 /*RILASCIO PASSAPORTO*/

   LEFT JOIN evento_rilascio_passaporto ril_passaporto ON ril_passaporto.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=6) or _tiporegistrazione=-1)


 /*TRASFERIMENTO*/
   LEFT JOIN evento_trasferimento trasf ON trasf.id_evento = reg.id_evento 
   left join opu_operatori_denormalizzati rel_nuovo on trasf.id_nuovo_proprietario = rel_nuovo.id_rel_stab_lp 
   left join opu_operatori_denormalizzati rel_vecchio on trasf.id_vecchio_proprietario = rel_vecchio.id_rel_stab_lp and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=16) or _tiporegistrazione=-1)
   left join opu_operatori_denormalizzati rel_vecchio_det on trasf.id_vecchio_detentore = rel_vecchio_det.id_rel_stab_lp and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=16) or _tiporegistrazione=-1)



 /*TRASF FUORI REGIONE*/
    LEFT JOIN evento_trasferimento_fuori_regione trasf_fr ON trasf_fr.id_evento = reg.id_evento 
    left join lookup_regione regioni on regioni.code = trasf_fr.id_regione_a 
    left join opu_operatori_denormalizzati trasf_fr_vecchio on trasf_fr.id_vecchio_proprietario_fuori_regione = trasf_fr_vecchio.id_rel_stab_lp and 
 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=8) or _tiporegistrazione=-1)

    /* TRASFERIMENTO DA CANILE */   
   LEFT JOIN evento_trasferimento_canile trasf_canile ON trasf_canile.id_evento = reg.id_evento
  left join opu_operatori_denormalizzati nuovo_propr_trasf_canile on trasf_canile.id_proprietario_trasferimento_canile = nuovo_propr_trasf_canile.id_rel_stab_lp and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=31) or _tiporegistrazione=-1)
  left join opu_operatori_denormalizzati vecchio_det_trasf_canile on trasf_canile.id_canile_old_trasferimento_canile = vecchio_det_trasf_canile.id_rel_stab_lp and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=31) or _tiporegistrazione=-1)

    
       /* TRASFERIMENTO VERSO SINDACO */   
   LEFT JOIN evento_trasferimento_sindaco trasf_sindaco ON trasf_sindaco.id_evento = reg.id_evento
  left join opu_operatori_denormalizzati nuovo_propr_trasf_sindaco on trasf_sindaco.id_nuovo_proprietario = nuovo_propr_trasf_sindaco.id_rel_stab_lp and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=55) or _tiporegistrazione=-1)

--   LEFT JOIN evento_trasferimento_fuori_regione_solo_proprietario trasf_fr_sp ON trasf_fr_sp.id_evento = reg.id_evento and 
 --                                                    ((_tiporegistrazione>-1 and _tiporegistrazione=40) or _tiporegistrazione=-1)
   LEFT JOIN evento_trasferimento_fuori_stato trasf_fs ON trasf_fs.id_evento = reg.id_evento 
   left join opu_operatori_denormalizzati vecchio_propr_trasf_fuori_stato on trasf_fs.id_vecchio_proprietario_fuori_stato = vecchio_propr_trasf_fuori_stato.id_rel_stab_lp and 
 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=39) or _tiporegistrazione=-1)



 /*CESSIONE*/

    LEFT JOIN evento_cessione cessione ON cessione.id_evento = reg.id_evento 
   left join lookup_asl_rif listaasl_vecchio on cessione.id_asl_vecchio_proprietario_cessione = listaasl_vecchio.code
   left join lookup_asl_rif listaasl_nuovo on cessione.id_asl_nuovo_proprietario_cessione = listaasl_nuovo.code 
   left join opu_operatori_denormalizzati vecchio_proprietario on cessione.id_vecchio_proprietario_cessione = vecchio_proprietario.id_rel_stab_lp     and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=7) or _tiporegistrazione=-1)
   left join opu_operatori_denormalizzati nuovo_proprietario_cessione on cessione.id_nuovo_proprietario_cessione = nuovo_proprietario_cessione.id_rel_stab_lp     and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=7) or _tiporegistrazione=-1)

  /*PRESA CESSIONE*/
   LEFT JOIN evento_presa_in_carico_cessione presa ON presa.id_evento = reg.id_evento 
   left join opu_operatori_denormalizzati nuovo_proprietario on presa.id_nuovo_proprietario_presa_cessione = nuovo_proprietario.id_rel_stab_lp and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=15) or _tiporegistrazione=-1)


/*ADOZIONE DA CANILE*/   
   LEFT JOIN evento_adozione_da_canile ado_canile ON ado_canile.id_evento = reg.id_evento 
   left join opu_operatori_denormalizzati den_canile on den_canile.id_rel_stab_lp = ado_canile.id_proprietario_adozione 
   left join opu_operatori_denormalizzati vecchio_canile_prop on ado_canile.id_vecchio_proprietario_adozione = vecchio_canile_prop.id_rel_stab_lp 
   left join opu_operatori_denormalizzati vecchio_canile_det on ado_canile.id_vecchio_detentore_adozione = vecchio_canile_det.id_rel_stab_lp  and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione =13) or _tiporegistrazione=-1) 

/*ADOZIONE DA COLONIA*/
   LEFT JOIN evento_adozione_da_colonia ado_colonia ON ado_colonia.id_evento = reg.id_evento    
   left join opu_operatori_denormalizzati vecchio_colonia_prop on ado_colonia.id_vecchio_proprietario_adozione_colonia = vecchio_colonia_prop.id_rel_stab_lp 
   left join opu_operatori_denormalizzati vecchio_colonia_det on ado_colonia.id_vecchio_detentore_adozione_colonia = vecchio_colonia_det.id_rel_stab_lp 
   left join opu_operatori_denormalizzati nuovo_prop on ado_colonia.id_proprietario_adozione_colonia = nuovo_prop.id_rel_stab_lp 
   left join opu_operatori_denormalizzati den_colonia_origine on den_colonia_origine.id_rel_stab_lp = ado_colonia.id_vecchio_detentore_adozione_colonia
   left join opu_operatori_denormalizzati den_colonia on den_colonia.id_rel_stab_lp = ado_colonia.id_proprietario_adozione_colonia and 
                                                        ((_tiporegistrazione>-1 and _tiporegistrazione=19) or _tiporegistrazione=-1)

   /*ADOZIONE FUORI ASL*/

   left join evento_adozione_fuori_asl ado_fa on ado_fa.id_evento = reg.id_evento  
   left join opu_operatori_denormalizzati den_canile_origine on den_canile_origine.id_rel_stab_lp = ado_fa.id_vecchio_detentore_adozione_fa 
   left join opu_operatori_denormalizzati den_fa_origine on den_fa_origine.id_rel_stab_lp = ado_fa.id_vecchio_detentore_adozione_fa 
   left join opu_operatori_denormalizzati den_fa on den_fa.id_rel_stab_lp = ado_fa.id_nuovo_proprietario_adozione_fa   and   
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=46) or _tiporegistrazione=-1)


/*PRESA IN CARICO FUORI AMBITO ASL*/   
   LEFT JOIN evento_presa_in_carico_adozione_fuori_asl presa_ado_fa ON presa_ado_fa.id_evento = reg.id_evento  
   left join opu_operatori_denormalizzati nuovo_proprietario_presa_ado_fa on presa_ado_fa.id_nuovo_proprietario_presa_adozione_fa = nuovo_proprietario_presa_ado_fa.id_rel_stab_lp and
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione =47) or _tiporegistrazione=-1) 


   /*REIMMISSIONE*/
     LEFT JOIN evento_reimmissione reimmissione ON reimmissione.id_evento = reg.id_evento left join comuni1 as comuni_reimmissione on (reimmissione.id_comune_reimmissione = comuni_reimmissione.id) and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=23) or _tiporegistrazione=-1)


   /*RIENTRO FR*/
      LEFT JOIN evento_rientro_da_fuori_regione rientro_fr ON rientro_fr.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=17) or _tiporegistrazione=-1)

   /*EVENTO CAMBIO DETENTORE*/                                                     
   LEFT JOIN evento_cambio_detentore cambio ON cambio.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=18) or _tiporegistrazione=-1)

   /*EVENTO ESITO CONTROLLI*/
   LEFT JOIN evento_esito_controlli esito ON esito.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=22) or _tiporegistrazione=-1)
   /*evento_inserimento_esiti_controlli_commerciali*/
   LEFT JOIN evento_inserimento_esiti_controlli_commerciali controlli ON controlli.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=26) or _tiporegistrazione=-1)
   /*EVENTO INSERIMENTO MC*/                                                  
   LEFT JOIN evento_inserimento_microchip ins_microchip ON ins_microchip.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=3) or _tiporegistrazione=-1)
                                                     
   LEFT JOIN evento_inserimento_vaccino ins_vaccino ON ins_vaccino.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=36) or _tiporegistrazione=-1)
                                                     
   LEFT JOIN evento_modifica_residenza residenza ON residenza.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=43) or _tiporegistrazione=-1)
                                                     
   LEFT JOIN evento_morsicatura morsicatura ON morsicatura.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=21) or _tiporegistrazione=-1)

   LEFT JOIN evento_registrazione_bdu registrazione ON registrazione.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=1) or _tiporegistrazione=-1)

   LEFT JOIN evento_restituzione_a_canile rest_canile ON rest_canile.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=14) or _tiporegistrazione=-1)

   LEFT JOIN evento_rientro_da_fuori_stato rientro_fs ON rientro_fs.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=42) or _tiporegistrazione=-1)


   LEFT JOIN evento_prelievo_dna dna ON dna.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=50) or _tiporegistrazione=-1)   
   LEFT JOIN evento_restituzione_a_proprietario rest ON rest.id_evento = reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=45) or _tiporegistrazione=-1)

    /*PRELIEVO CAMPIONI LEISHMANIA*/

   LEFT JOIN evento_prelievo_leish prelievo_leish on  prelievo_leish.id_evento =  reg.id_evento and 
                                                     ((_tiporegistrazione>-1 and _tiporegistrazione=54) or _tiporegistrazione=-1)
   LEFT JOIN contact_ cc on (prelievo_leish.id_veterinario_llpp = cc.user_id)      
   LEFT JOIN contact_ cc1 on (prelievo_leish.id_veterinario_asl = cc.user_id)                                              

   LEFT JOIN access_ ON reg.id_utente_inserimento = access_.user_id
   LEFT JOIN contact_ contatto ON access_.contact_id = contatto.contact_id
   LEFT JOIN role listaruoli ON access_.role_id = listaruoli.role_id
   LEFT JOIN lookup_tipologia_registrazione listaregistrazioni ON reg.id_tipologia_evento = listaregistrazioni.code
   LEFT JOIN lookup_asl_rif listaasl ON reg.id_asl = listaasl.code


   /*informazioni proprietario detentore corrente*/

   LEFT JOIN opu_operatori_denormalizzati propc on (reg.id_proprietario_corrente = propc.id_rel_stab_lp)
   LEFT JOIN opu_relazione_attivita_produttive_aggregazioni oo on (oo.id = propc.id_linea_produttiva)
   LEFT JOIN opu_lookup_attivita_linee_produttive_aggregazioni propcdesc  on (oo.id_attivita_aggregazione = propcdesc.code)


   LEFT JOIN opu_operatori_denormalizzati detc on (reg.id_detentore_corrente = detc.id_rel_stab_lp)
   LEFT JOIN opu_relazione_attivita_produttive_aggregazioni od on (od.id = detc.id_linea_produttiva)
   LEFT JOIN opu_lookup_attivita_linee_produttive_aggregazioni detcdesc  on (od.id_attivita_aggregazione = detcdesc.code)

 /*EVENTO ALLONTANAMENTO*/                                                  
   LEFT JOIN evento_allontanamento allo ON allo.id_evento = reg.id_evento and 
                                                            ((_tiporegistrazione>-1 and _tiporegistrazione=66) or _tiporegistrazione=-1)
   LEFT JOIN lookup_medico_esecutore allo_lme on allo_lme.code = allo.id_medico_esecutore
   LEFT JOIN elenco_veterinari_asl_with_group_asl allo_veterinariasl on allo_veterinariasl.code = allo.id_veterinario_asl
   LEFT JOIN elenco_veterinari allo_veterinariprivati on allo_veterinariprivati.code = allo.id_veterinario_llpp
   LEFT JOIN lookup_causale allo_lc on allo_lc.code = allo.id_causale							

/*EVENTO MUTILAZIONE*/                                                  
   LEFT JOIN evento_mutilazione muti ON muti.id_evento = reg.id_evento and 
                                                            ((_tiporegistrazione>-1 and _tiporegistrazione=65) or _tiporegistrazione=-1)
   LEFT JOIN lookup_medico_esecutore muti_lme on muti_lme.code = muti.id_medico_esecutore
   LEFT JOIN elenco_veterinari_asl_with_group_asl muti_veterinariasl on muti_veterinariasl.code = muti.id_veterinario_asl
   LEFT JOIN elenco_veterinari muti_veterinariprivati on muti_veterinariprivati.code = muti.id_veterinario_llpp
   LEFT JOIN lookup_intervento_eseguito muti_lie on  muti_lie.code = muti.id_intervento_eseguito
  LEFT JOIN lookup_causale muti_lc on muti_lc.code = muti.id_causale



  WHERE 
  reg.data_cancellazione IS NULL and reg.trashed_date is null
  AND animale.data_cancellazione IS NULL and animale.trashed_date is null
   and(
  (_tipospecie>-1 and animale.id_specie = _tipospecie)
 or (_tipospecie=-1)
  )
  and (
   (_asl>-1 and reg.id_asl = _asl)
 or (_asl=-1)
  )
    and (
   (_tiporegistrazione>-1 and reg.id_tipologia_evento = _tiporegistrazione)
 or (_tiporegistrazione=-1)
  )
  and listaregistrazioni.enabled_estrazione
  and((reg.id_tipologia_evento = 1 and date_part('year', registrazione.data_registrazione) = _annoevento)
or(reg.id_tipologia_evento = 2 and date_part('year', ster.data_sterilizzazione) = _annoevento)
or(reg.id_tipologia_evento = 3 and date_part('year', ins_microchip.data_inserimento_microchip) = _annoevento)
or(reg.id_tipologia_evento = 4 and date_part('year', furto.data_furto) = _annoevento)
or(reg.id_tipologia_evento = 5 and date_part('year', cattura.data_cattura) = _annoevento)
or(reg.id_tipologia_evento = 6 and date_part('year', ril_passaporto.data_rilascio_passaporto) = _annoevento)
or(reg.id_tipologia_evento = 7 and date_part('year', cessione.data_cessione) = _annoevento)
or(reg.id_tipologia_evento = 8 and date_part('year', trasf_fr.data_trasferimento_fuori_regione) = _annoevento)
or(reg.id_tipologia_evento = 9 and date_part('year', decesso.data_decesso) = _annoevento)
or(reg.id_tipologia_evento = 11 and date_part('year', smar.data_smarrimento) = _annoevento)
or(reg.id_tipologia_evento = 12 and date_part('year', ritro.data_ritrovamento) = _annoevento)
or(reg.id_tipologia_evento = 41 and date_part('year', ritro_nd.data_ritrovamento_nd) = _annoevento)
or(reg.id_tipologia_evento = 13 and date_part('year', ado_canile.data_adozione) = _annoevento)
or(reg.id_tipologia_evento = 14 and date_part('year', rest_canile.data_restituzione_canile) = _annoevento)
or(reg.id_tipologia_evento = 15 and date_part('year', presa.data_presa_in_carico) = _annoevento)
or(reg.id_tipologia_evento = 16 and date_part('year', trasf.data_trasferimento) = _annoevento)
or(reg.id_tipologia_evento = 17 and date_part('year', rientro_fr.data_rientro_fr) = _annoevento)
or(reg.id_tipologia_evento = 18 and date_part('year', cambio.data_cambio_detentore) = _annoevento)
or(reg.id_tipologia_evento = 19 and date_part('year', ado_colonia.data_adozione_colonia) = _annoevento)
or(reg.id_tipologia_evento = 21 and date_part('year', morsicatura.data_morso) = _annoevento)
or(reg.id_tipologia_evento = 23 and date_part('year', reimmissione.data_reimmissione) = _annoevento)
or(reg.id_tipologia_evento = 24 and date_part('year', cattura.data_cattura) = _annoevento)
or(reg.id_tipologia_evento = 26 and date_part('year', controlli.data_registrazione_esiti) = _annoevento)
or(reg.id_tipologia_evento = 31 and date_part('year', trasf_canile.data_trasferimento_canile) = _annoevento)
or(reg.id_tipologia_evento = 33 and date_part('year', reg.modified) = _annoevento)
or(reg.id_tipologia_evento = 36 and date_part('year', ins_vaccino.data_inserimento_vaccinazione) = _annoevento)
or(reg.id_tipologia_evento = 38 and date_part('year', ins_microchip.data_inserimento_microchip) = _annoevento)
or(reg.id_tipologia_evento = 39 and date_part('year', trasf_fs.data_trasferimento_fuori_stato) = _annoevento)
--or(reg.id_tipologia_evento = 40 and date_part('year', trasf_fr_sp.data_trasferimento_fuori_regione_solo_proprietario) = _annoevento)
or(reg.id_tipologia_evento = 42 and date_part('year', rientro_fs.data_rientro_fuori_stato) = _annoevento)
or(reg.id_tipologia_evento = 43 and date_part('year', residenza.data_modifica_residenza) = _annoevento)
or(reg.id_tipologia_evento = 50 and date_part('year', dna.data_prelievo) = _annoevento)
or(reg.id_tipologia_evento = 45 and date_part('year', rest.data_restituzione) = _annoevento)
or(reg.id_tipologia_evento = 46 and date_part('year', ado_fa.data_adozione_fa) = _annoevento)
or(reg.id_tipologia_evento = 47 and date_part('year', presa_ado_fa.data_presa_in_carico_adozione_fa) = _annoevento)
or(reg.id_tipologia_evento = 54 and date_part('year', prelievo_leish.data_prelievo_leish) = _annoevento)
or(reg.id_tipologia_evento = 55 and date_part('year', trasf_sindaco.data_trasferimento) = _annoevento)
or(reg.id_tipologia_evento = 66 and date_part('year', allo.data_allontanamento) = _annoevento)
or(reg.id_tipologia_evento = 65 and date_part('year', muti.data_mutilazione) = _annoevento)
or (_annoevento=-1))
  LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$function$
;


drop function public_functions.dbi_bdu_animali_anagrafati( integer,  integer,  integer,  integer,  integer);

CREATE OR REPLACE FUNCTION public_functions.dbi_bdu_animali_anagrafati(tipospecie integer, asl integer, anno_inserimento integer, anno_registrazione integer, tipovet integer)
 RETURNS TABLE(data_inserimento timestamp without time zone, data_registrazione timestamp without time zone, microchip text, tatuaggio text, inserito_da text, ruolo_inserito_da text, id_animale integer, flag_attivita_itinerante boolean, comune_attivita_itinerante text, luogo_attivita_itinerante text, data_attivita_itinerante timestamp without time zone, commerciale text, stato_originale text, asl_originale text, id_asl integer, specie text, razza text, flag_incrocio boolean, veterinario_chippatore text, data_microchip timestamp without time zone, stato_decesso text, proprietario text, comune_proprietario text, tipo_proprietario text, tipo_vet integer, data_nascita timestamp without time zone, flag_stampata_richiesta_prima_iscrizione boolean, sesso text)
 LANGUAGE plpgsql
 STRICT
AS $function$
BEGIN
	FOR data_inserimento, data_registrazione, microchip , tatuaggio, inserito_da, ruolo_inserito_da, id_animale, flag_attivita_itinerante, comune_attivita_itinerante , luogo_attivita_itinerante , 
  data_attivita_itinerante ,commerciale, stato_originale, asl_originale, id_asl, specie, razza,flag_incrocio, veterinario_chippatore, data_microchip, stato_decesso, proprietario, comune_proprietario, tipo_proprietario, tipo_vet, data_nascita,
  flag_stampata_richiesta_prima_iscrizione,sesso
		in
SELECT 
animale.data_inserimento as data_inserimento, 
animale.data_registrazione as data_registrazione,
COALESCE (animale.microchip  , 'N.D.') as microchip,
case when animale.tatuaggio='' then 'N.D.'::text else animale.tatuaggio end as tatuaggio,
pg_catalog.concat(contatto.namefirst, ' ', contatto.namelast) AS inserito_da, 
ruoli.role AS ruolo_inserito_da,
animale.id AS id_animale, 
animale.flag_attivita_itinerante,
COALESCE(com.nome, 'N.D.'::text) as comune_attivita_itinerante,
animale.luogo_attivita_itinerante,
animale.data_attivita_itinerante,
case when animale.flag_circuito_commerciale then 'SI'::text else 'NO'::text end AS commerciale, 
COALESCE (stati.description , 'N.D.') as stato_originale, 
COALESCE (lista_asl.description , 'N.D.') as asl_originale, 
evento.id_asl as id_asl,
case when animale.id_specie =1 then 'CANE'::text when animale.id_specie=2 then 'GATTO'::text when animale.id_specie=3 then 'FURETTO'::text end AS specie, 
razza.description AS razza, 
animale.flag_incrocio as flag_incrocio,
case when vet.namefirst is not null and  vet.namelast is not null then pg_catalog.concat(vet.namefirst, ' ', vet.namelast) else 'N.D.'::text end AS veterinario_chippatore, 
animale.data_microchip as data_microchip, 
CASE WHEN animale.flag_decesso THEN 'MORTO'::text ELSE 'VIVO'::text END AS stato_decesso, 
COALESCE(operatore.ragione_sociale, 'N.D.'::text) AS proprietario, 
COALESCE(comuni1.nome, 'N.D.'::text) AS comune_proprietario, 
COALESCE(linea.description, 'N.D.'::text) AS tipo_proprietario,
CASE WHEN utenti.role_id = 24 THEN '1'::integer ELSE '2'::integer END AS tipo_vet,
animale.data_nascita,
flag.animale is not null as flag_stampata_richiesta_prima_iscrizione,
animale.sesso

   FROM animale
   LEFT JOIN evento ON evento.id_animale = animale.id
   LEFT JOIN evento_registrazione_bdu reg ON evento.id_evento = reg.id_evento
   LEFT JOIN cane ON animale.id = cane.id_animale
   LEFT JOIN lookup_razza razza ON razza.code = animale.id_razza
   LEFT JOIN lookup_asl_rif lista_asl ON evento.id_asl = lista_asl.code
   LEFT JOIN opu_relazione_stabilimento_linee_produttive rel ON reg.id_proprietario = rel.id
   LEFT JOIN opu_stabilimento sta ON rel.id_stabilimento = sta.id
   LEFT JOIN opu_operatore operatore ON sta.id_operatore = operatore.id
   LEFT JOIN opu_relazione_attivita_produttive_aggregazioni tipo ON rel.id_linea_produttiva = tipo.id
   LEFT JOIN opu_indirizzo ind ON ind.id = sta.id_indirizzo
   LEFT JOIN comuni1 on comuni1.id = ind.comune
   LEFT JOIN opu_lookup_attivita_linee_produttive_aggregazioni linea ON tipo.id_attivita_aggregazione = linea.code
   LEFT JOIN lookup_tipologia_stato stati ON reg.id_stato = stati.code
   LEFT JOIN access_ utenti ON animale.utente_inserimento = utenti.user_id
   LEFT JOIN contact_ contatto ON utenti.contact_id = contatto.contact_id
   LEFT JOIN role ruoli ON utenti.role_id = ruoli.role_id
   LEFT JOIN access_ utenti_vet ON animale.id_veterinario_microchip = utenti_vet.user_id
   LEFT JOIN contact_ vet ON utenti_vet.contact_id = vet.contact_id
   left join comuni1 com on com.id = animale.id_comune_attivita_itinerante
   left join animali_flag_stampata_richiesta_prima_iscrizione flag on flag.animale = animale.id
   
  WHERE 
  animale.data_cancellazione IS NULL and animale.trashed_date is null
  and evento.data_cancellazione IS NULL and evento.trashed_date is null 
  and evento.id_tipologia_evento = 1

  and(
  (tipospecie>-1 and animale.id_specie = tipospecie)
 or (tipospecie=-1)
  )
  and (
   (asl>-1 and evento.id_asl = asl)
 or (asl=-1)
  )
  and(
  (anno_inserimento>-1 and date_part('year'::text, animale.data_inserimento) = anno_inserimento)
  or (anno_inserimento=-1)
  )
 and(
  (anno_registrazione>-1 and date_part('year'::text, animale.data_registrazione) = anno_registrazione)
  or (anno_registrazione=-1)
  )
  and (
 (tipovet =1 and utenti.role_id = 24) --veterinario privato
 or (tipovet=2 and utenti.role_id <> 24) --veterinario asl
 or (tipovet=-1)
  )
    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$function$
;


drop FUNCTION public_functions.dbi_bdu_animali( integer,  integer);
CREATE OR REPLACE FUNCTION public_functions.dbi_bdu_animali(tipospecie integer, asl integer)
 RETURNS TABLE(data_inserimento timestamp without time zone, data_registrazione timestamp without time zone, microchip text, tatuaggio text, inserito_da text, ruolo_inserito_da text, id_animale integer, commerciale text, stato_animale text, id_asl_animale integer, descrizione_asl_animale text, specie text, razza text, flag_incrocio boolean, taglia text, data_nascita timestamp without time zone, sesso text, veterinario_chippatore text, data_microchip timestamp without time zone, proprietario text, comune_proprietario text, tipo_proprietario text, stato_decesso text, data_decesso timestamp without time zone, detentore text, tipo_detentore text, id_asl_detentore integer, asl_detentore text, comune_cattura text, flag_sterilizzato boolean, data_sterilizzazione timestamp without time zone, flag_contributo_sterilizzazione boolean, flag_contributo_canili boolean, ente_sterilizzazione text, valore_ente_sterilizzazione text, flag_sterilizzazione_pregressa boolean, id_asl_sterilizzazione integer, asl_evento_sterilizzazione text, id_proprietario integer, id_detentore integer, flag_randagio boolean, flag_sterilizzazione boolean, detentore_corrente_flag_canile boolean, randagio boolean)
 LANGUAGE plpgsql
 STRICT
AS $function$
BEGIN
	FOR data_inserimento, data_registrazione, microchip , tatuaggio, inserito_da, ruolo_inserito_da, id_animale, commerciale, stato_animale, 
	--asl_originale, 
	id_asl_animale , descrizione_asl_animale , 
	specie, razza, flag_incrocio, taglia, data_nascita, sesso, veterinario_chippatore, data_microchip, proprietario, comune_proprietario, 
	tipo_proprietario, stato_decesso, data_decesso, detentore, tipo_detentore, id_asl_detentore, asl_detentore,comune_cattura, flag_sterilizzato, data_sterilizzazione, 
	flag_contributo_sterilizzazione, flag_contributo_canili, ente_sterilizzazione, valore_ente_sterilizzazione, flag_sterilizzazione_pregressa, id_asl_sterilizzazione, asl_evento_sterilizzazione, 
	id_proprietario, id_detentore, flag_randagio, flag_sterilizzazione, detentore_corrente_flag_canile, randagio
		in
SELECT distinct
animale.data_inserimento as data_inserimento, 
animale.data_registrazione as data_registrazione,
COALESCE (animale.microchip  , 'N.D.') as microchip,
case when animale.tatuaggio='' then 'N.D.'::text else animale.tatuaggio end as tatuaggio,
pg_catalog.concat(contatto.namefirst, ' ', contatto.namelast) AS inserito_da, 
ruoli.role AS ruolo_inserito_da,
animale.id AS id_animale, 
case when animale.flag_circuito_commerciale then 'SI'::text else 'NO'::text end AS commerciale, 
COALESCE (stati.description , 'N.D.') as stato_animale, 
animale.id_asl_riferimento as id_asl_animale,
lista_asl.description as descrizione_asl_animale,
--COALESCE (lista_asl.description , 'N.D.') as asl_originale, 
case when animale.id_specie =1 then 'CANE'::text when animale.id_specie=2 then 'GATTO'::text when animale.id_specie=3 then 'FURETTO'::text end AS specie, 
razza.description AS razza, 
animale.flag_incrocio as flag_incrocio,
taglia.description AS taglia,
animale.data_nascita,
animale.sesso,
case when vet.namefirst is not null and  vet.namelast is not null then pg_catalog.concat(vet.namefirst, ' ', vet.namelast) else 'N.D.'::text end AS veterinario_chippatore, 
animale.data_microchip as data_microchip,  
COALESCE(op_prop.ragione_sociale, 'N.D.'::text) AS proprietario, 
COALESCE(comune_prop.nome, 'N.D.'::text) AS comune_proprietario, 
COALESCE(linea.description, 'N.D.'::text) AS tipo_proprietario,
CASE WHEN animale.flag_decesso THEN 'MORTO'::text ELSE 'VIVO'::text END AS stato_decesso, 
decesso.data_decesso as data_decesso,
COALESCE(op_det.ragione_sociale, 'N.D.'::text)  as detentore,
COALESCE(linea_det.description, 'N.D.'::text) as tipo_detentore,
op_det.id_asl as id_asl_detentore,
asl_det.description as asl_detentore,
CASE WHEN (proprietario_reg.id_asl=14 or linea_prop_reg.code=6) THEN 'F.R.'
     ELSE COALESCE(comune_cattura_cane.nome, comune_cattura_gatto.nome,'N.D.'::text)
END as comune_cattura,
COALESCE(animale.flag_sterilizzazione, false) as flag_sterilizzato,
sterilizzazione.data_sterilizzazione as data_sterilizzazione,
sterilizzazione.flag_richiesta_contributo_regionale as flag_contributo_sterilizzazione,
CASE WHEN sterilizzazione.id_progetto_di_sterilizzazione_richiesto in (select id_pratica from pratiche_contributi_canili) then true ELSE false END as flag_contributo_canili,
CASE WHEN soggetto.description is not null  THEN soggetto.description
WHEN (soggetto.description is  null and animale.flag_sterilizzazione is true) THEN 'Asl' END as ente_sterilizzazione, --se null imposto ad ASL 
CASE WHEN sterilizzazione.tipologia_soggetto_sterilizzante=1 THEN sterilizzazione_ente.description WHEN 
sterilizzazione.tipologia_soggetto_sterilizzante=2 THEN pg_catalog.concat(contact_ente_sterilizzazione.namefirst, ' ', contact_ente_sterilizzazione.namelast)
WHEN (sterilizzazione.tipologia_soggetto_sterilizzante is null and animale.flag_sterilizzazione is true) THEN sterilizzazione_asl.description  END as valore_ente_sterilizzazione,  --SE e' LP prendo nome e cognome, se asl asl salvata, se   null asl di inserimento registrazione
evento_ster.inserimento_registrazione_forzato as flag_sterilizzazione_pregressa,
evento_ster.id_asl as id_asl_sterilizzazione,
sterilizzazione_asl.description as asl_evento_sterilizzazione,
animale.id_proprietario as id_proprietario,
animale.id_detentore as id_detentore,
CASE WHEN coalesce(cane.flag_catturato, gatto.flag_catturato) THEN true else false END as flag_randagio,
animale.flag_sterilizzazione ,
case when info_det.flag_canile is null then false else info_det.flag_canile end as detentore_corrente_flag_canile,

COALESCE (stati.randagio , linea.code=2) as randagio 


   FROM animale
 --  LEFT JOIN evento ON evento.id_animale = animale.id
 --  LEFT JOIN evento_registrazione_bdu reg ON evento.id_evento = reg.id_evento
 LEFT JOIN evento evento_reg on (animale.id = evento_reg.id_animale and evento_reg.id_tipologia_evento = 1
   and evento_reg.data_cancellazione IS NULL and evento_reg.trashed_date is null )
   LEFT JOIN evento_registrazione_bdu registrazione on (evento_reg.id_evento = registrazione.id_evento)
   LEFT JOIN opu_operatori_denormalizzati proprietario_reg on (registrazione.id_proprietario = proprietario_reg.id_rel_stab_lp)
   LEFT JOIN cane ON animale.id = cane.id_animale
   LEFT JOIN gatto ON animale.id = gatto.id_animale
   LEFT JOIN lookup_razza razza ON razza.code = animale.id_razza
   LEFT JOIN lookup_taglia taglia ON taglia.code = animale.id_taglia
   LEFT JOIN opu_operatori_denormalizzati op_prop on (animale.id_proprietario = op_prop.id_rel_stab_lp)
   LEFT JOIN opu_operatori_denormalizzati op_det on (animale.id_detentore = op_det.id_rel_stab_lp)
   LEFT JOIN opu_informazioni_canile info_det on (info_det.id_relazione_stabilimento_linea_produttiva = op_det.id_rel_stab_lp)
   LEFT JOIN lookup_asl_rif asl_det on (asl_det.code = op_det.id_asl)
   LEFT JOIN lookup_asl_rif lista_asl ON animale.id_asl_riferimento = lista_asl.code
   LEFT JOIN comuni1 comune_prop on comune_prop.id = op_prop.comune
   LEFT JOIN opu_relazione_attivita_produttive_aggregazioni tipo ON op_prop.id_linea_produttiva = tipo.id
   LEFT JOIN opu_lookup_attivita_linee_produttive_aggregazioni linea ON tipo.id_attivita_aggregazione = linea.code
   LEFT JOIN opu_relazione_attivita_produttive_aggregazioni tipo_det ON op_det.id_linea_produttiva = tipo_det.id
   LEFT JOIN opu_lookup_attivita_linee_produttive_aggregazioni linea_det ON tipo_det.id_attivita_aggregazione = linea_det.code
   LEFT JOIN opu_relazione_attivita_produttive_aggregazioni tipo_prop_reg ON proprietario_reg.id_linea_produttiva = tipo_prop_reg.id
   LEFT JOIN opu_lookup_attivita_linee_produttive_aggregazioni linea_prop_reg ON tipo_prop_reg.id_attivita_aggregazione = linea_prop_reg.code
 --  LEFT JOIN lookup_tipologia_stato stati ON reg.id_stato = stati.code
   LEFT JOIN lookup_tipologia_stato stati ON animale.stato = stati.code
   LEFT JOIN access_ utenti ON animale.utente_inserimento = utenti.user_id
   LEFT JOIN contact_ contatto ON utenti.contact_id = contatto.contact_id
   LEFT JOIN role ruoli ON utenti.role_id = ruoli.role_id
   LEFT JOIN access_ utenti_vet ON animale.id_veterinario_microchip = utenti_vet.user_id
   LEFT JOIN contact_ vet ON utenti_vet.contact_id = vet.contact_id
   LEFT JOIN evento on (evento.id_animale = animale.id  and evento.id_tipologia_evento = 9 
   and evento.data_cancellazione IS NULL and evento.trashed_date is null )
   LEFT JOIN evento_decesso decesso on (evento.id_evento = decesso.id_evento )
   LEFT JOIN comuni1 comune_cattura_cane on (cane.id_comune_cattura = comune_cattura_cane.id)
   LEFT JOIN comuni1 comune_cattura_gatto on (gatto.id_comune_cattura = comune_cattura_gatto.id)
   LEFT JOIN evento evento_ster on (animale.id = evento_ster.id_animale and evento_ster.id_tipologia_evento = 2 
   and evento_ster.data_cancellazione IS NULL and evento_ster.trashed_date is null   )
   LEFT JOIN evento_sterilizzazione sterilizzazione on (evento_ster.id_evento = sterilizzazione.id_evento)
   LEFT JOIN lookup_soggetto_sterilizzante soggetto on (sterilizzazione.tipologia_soggetto_sterilizzante = soggetto.code) 
   LEFT JOIN lookup_asl_rif  sterilizzazione_asl on (evento_ster.id_asl =  sterilizzazione_asl.code)
   LEFT JOIN lookup_asl_rif sterilizzazione_ente on (sterilizzazione.id_soggetto_sterilizzante = sterilizzazione_ente.code)
   --LEFT JOIN ACCESS access_ente_sterilizzazione on  (evento_ster.id_soggetto_sterilizzante = access_ente_sterilizzazione.user_id)
   LEFT JOIN contact_ contact_ente_sterilizzazione on (sterilizzazione.id_soggetto_sterilizzante = contact_ente_sterilizzazione.user_id)
   
  WHERE 
  animale.data_cancellazione IS NULL and animale.trashed_date is null
 -- and evento.data_cancellazione IS NULL and evento.trashed_date is null 
 -- and evento.id_tipologia_evento = 1
 --and evento.data_cancellazione IS NULL and evento.trashed_date is null 
 --and evento.id_tipologia_evento = 9 
 --and evento_ster.data_cancellazione IS NULL and evento_ster.trashed_date is null  
 --and evento_ster.id_tipologia_evento = 2 
 --and animale.microchip ='380260042095006' 

  and(
  (tipospecie>-1 and animale.id_specie = tipospecie)
 or (tipospecie=-1)
  )
  and (
   (asl>-1 and animale.id_asl_riferimento = asl)
 or (asl=-1)
  )

  
    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$function$
;




drop type public_functions.registro_unico;
CREATE TYPE public_functions.registro_unico AS (
	microchip text,
	tatuaggio text,
	specie text,
	razza text,
	flag_incrocio bool,
	proprietario text,
	asl_proprietario text,
	id_evento int4,
	data_inserimento_registrazione timestamp,
	data_registrazione timestamp,
	evento text,
	anno float8,
	id_cu int4,
	misure_formative text,
	misure_riabilitative text,
	misure_restrittive text);




drop function public_functions.get_registro_unico_cani_aggressori();
CREATE OR REPLACE FUNCTION public_functions.get_registro_unico_cani_aggressori()
 RETURNS SETOF public_functions.registro_unico
 LANGUAGE sql
AS $function$select microchip, tatuaggio,specie,razza,flag_incrocio, proprietario, asl_proprietario, id_evento, data_inserimento_registrazione, data_registrazione, evento, anno, id_cu, misure_formative, misure_riabilitative, misure_restrittive from registro_unico_cani_rischio_elevato_aggressivita 
  $function$
;





DROP FUNCTION public.get_registro_unico_cani_aggressori(integer, integer);


CREATE OR REPLACE FUNCTION public.get_registro_unico_cani_aggressori(
    IN anno_input integer,
    IN asl_input integer)
  RETURNS TABLE(id_animale integer, microchip text, tatuaggio text, specie text, razza text, flag_incrocio boolean,id_proprietario integer, proprietario text, id_asl_proprietario integer, 
  asl_proprietario text, id_evento integer, data_inserimento_registrazione timestamp without time zone, data_registrazione timestamp without time zone, evento text, valutazione_dehasse double precision, 
  id_tipologia_registrazione integer, tipologia text, anno integer, id_tipologia_evento integer, id_cu integer, misure_restrittive text, misure_riabilitative text, misure_formative text) AS
$BODY$
BEGIN
	FOR id_animale, microchip, tatuaggio, specie , razza , flag_incrocio , id_proprietario, proprietario, id_asl_proprietario, asl_proprietario, id_evento, 
                data_inserimento_registrazione, data_registrazione, evento, valutazione_dehasse, 
                id_tipologia_registrazione, tipologia, anno, id_tipologia_evento, id_cu, misure_restrittive,misure_riabilitative, misure_formative
		in
			select * from registro_unico_cani_rischio_elevato_aggressivita reg
			where (anno_input is null or anno_input=-1 or reg.anno = anno_input) and 
			      (asl_input is null or  asl_input=-1 or asl_input = reg.id_asl_proprietario) 
			order by data_registrazione
    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_registro_unico_cani_aggressori(integer, integer)
  OWNER TO postgres;








