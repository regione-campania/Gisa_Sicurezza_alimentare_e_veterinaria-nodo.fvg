-- svuotare gestione richieste
delete from sviluppo_flussi;  
delete from sviluppo_moduli;
delete from sviluppo_moduli_note; 

-- svuotare allerte
delete from allerte_asl_coinvolte;  
delete from analiti_allerte;
delete from allerte_asl_coinvolte_history;  
delete from allerte_history;  
delete from allerte_ldd; 
delete from allerte_ldd_history;   
delete from matrici_allerte; 
delete from ticket where tipologia=700;

select * from projects

-- record fittizio da inserire per il forum (da verificare prima se esiste!!!!)
INSERT INTO public.projects(
            project_id, group_id, department_id, template_id, title, shortdescription, 
            requestedby, requesteddept, requestdate, approvaldate, closedate, 
            owner, entered, enteredby, modified, modifiedby, approvalby, 
            category_id, portal, allow_guests, news_enabled, details_enabled, 
            team_enabled, plan_enabled, lists_enabled, discussion_enabled, 
            tickets_enabled, documents_enabled, news_label, details_label, 
            team_label, plan_label, lists_label, discussion_label, tickets_label, 
            documents_label, est_closedate, budget, budget_currency, requestdate_timezone, 
            est_closedate_timezone, portal_default, portal_header, portal_format, 
            portal_key, portal_build_news_body, portal_news_menu, description, 
            allows_user_observers, level, portal_page_type, calendar_enabled, 
            calendar_label, accounts_enabled, accounts_label, trashed_date)
    VALUES (3,null,null,null,'Forum','Forum GISA',null,null,'2008-09-18 11:40:00','2008-09-18 11:39:17',null,null,'2008-09-18 11:39:17.203',206,'2008-09-30 10:36:19.187',1,null,null,false,false,false,false,true,false,false,true,false,false,
   '','','','','','','','',null,null,'EUR','Europe/Berlin','Europe/Berlin',false,null,null,null,false,false,null,false,10,null,false,null,false,'', null);

--Da nascondere come cavalieri: GISA Web GIS, tutti i cavalieri MATRIX, Schede DCA 43 7.6.2019, REPORTISTICA AVANZATA
select * from permission where permission ilike '%webgis%' --749
select * from permission where permission ilike '%dca%' --761
select * from permission where permission ilike '%reportistica%' --457,765,1396789107,
select * from permission where permission ilike '%matrix%' --1396789108,1396789109,764,768
update role_permission set role_view  = false where permission_id in (749,102,457,765,1396789107,1396789108,1396789109,764,768,761);

-- svuoto i record preaccettazione
delete from preaccettazione.associazione_preaccettazione_entita;  
delete from preaccettazione.stati_preaccettazione;   
delete from preaccettazione.codici_preaccettazione;  

-- query per svuotamento tabelle: recupero quelle che hanno più record
--SELECT relname, n_tup_ins - n_tup_del as rowcount FROM pg_stat_all_tables 
--where (n_tup_ins - n_tup_del) > 1000
--order by 2 desc, 1 

delete from opu_insert_log;
delete from customer_satisfaction;
drop table organization_address_backup;
drop table storico_nucleo_ispettivo_temp ;
drop table temp_camp ;
drop table linee_attivita_controlli_ufficiali_backup;
delete from suap_log_validazione_operazioni;
delete from ws_storico_chiamate;
delete from anagrafica_852_o;
delete from dbi_get_controlli_ufficiali_eseguiti_table;
delete from report_vista_osa_mai_controllati;
delete from cu_programmazioni_asl;
 
drop table riferimento_address_id_id_indirizzo;
drop table opu_indirizzo_old;
drop table camera_commercio;
drop table nucleo_temp_ticket;
drop table "PREV_sintesis_linee_attivita_controlli_ufficiali"
delete from controlli_punti_di_prelievo_acque_rete;
delete from linee_attivita_controlli_ufficiali_stab_soa;
delete from esito_invio_852_sinvsa;
delete from riferimento_org_id_id_stabilimento;
delete from riferimento_org_id_id_operatore;
drop table opu_rel_operatore_soggetto_fisico_;
drop table opu_stabilimento_;
drop table opu_operatore_;
drop table opu_indirizzo_ cascade;
drop table aziende_agricole_temp;
delete from usage_log;
drop table "PREV_opu_linee_attivita_controlli_ufficiali" cascade;
drop table  codici_fiscali_da_importare;
drop table  tmptmp2;
drop table  lista_attributi_modificati_stab;
drop table  anag_852_puliti_import;
drop table  tmptmp;
drop table diag_indirizzi_napoli_rag_soc_fase2;
drop table diag_indirizzi_napoli_sporchi;
drop table table_app;
drop table appotb;
drop table opu_agr_appo;
delete from import_distributori_automatici_ko;  
drop table opu_indirizzo_backup;
drop table organization_852_trasporti_non_opu_unnested;
drop table organization_852_trasporti_non_opu_ora_opu;
delete from informazioni_sanitarie_allevamenti;
drop table nucleo_ispettivo_temp_test;
delete from access_log where entered <= '2022-01-01';
delete from laboratori_haccp_controllati;
delete from nucleo_ispettivo_temp_test_2;
DROP TRIGGER backup_delete ON public.linee_attivita_controlli_ufficiali;
delete from linee_attivita_controlli_ufficiali;
delete from salvataggio_specie_trasportata;
delete from tipocontrolloufficialeimprese;
delete from cu_nucleo;
delete from audit_checklist;
delete from matrici_campioni;
delete from analiti_campioni;
delete from strutture_controllate_autorita_competenti;
delete from nucleo_ispettivo_mv;
delete from salvataggio_nc_note;
delete from salvataggio_osservazioni;
delete from salvataggio_azioni_adottate;
delete from m_capi;
delete from audit_checklist_type;
drop table organization_address_backup;
delete from linee_mobili_fields_value;
delete from cu_fields_value;
delete from campioni_fields_value;

ALTER TABLE public.linee_attivita_controlli_ufficiali DROP CONSTRAINT linee_attivita_controlli_ufficiali_id_controllo_ufficiale_fkey;    
delete from ticket where ticketid <> 10000000;


ALTER TABLE public.linee_attivita_controlli_ufficiali
  ADD CONSTRAINT linee_attivita_controlli_ufficiali_id_controllo_ufficiale_fkey FOREIGN KEY (id_controllo_ufficiale)
      REFERENCES public.ticket (ticketid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

delete from m_art17;
delete from m_capi_log;
delete from suap_storico;
delete from aziende_zootecniche_fields;
delete from import_ibr;
drop view view_globale_archiviati_minimale; 
drop view view_globale_archiviati_minimale; 
drop view global_arch_view;
delete from lista_linee_vecchia_anagrafica_stabilimenti_soggetti_a_scia;
delete from cu_nucleo;
delete from m_vpm_esiti_riscontrati;
delete from m_partite_sedute;
delete from m_partite;
delete from chk_bns_risposte_v4;
delete from chk_bns_risposte_v5;
delete from linee_attivita_controlli_ufficiali_stab_soa;
delete from controlli_punti_di_prelievo_acque_rete;
delete from anagrafica_852;
drop table organization_852_ateco_mappati;
delete from linee_nuove_allevamenti;
delete from m_vpm_campioni;
delete from suap_log_validazioni;
delete from unita_operative_controllo;
delete from m_capi_libero_consumo_massivo_log;
delete from chk_bns_risposte;
delete from barcode_osa;
drop table soggetti_fisici_organization_852;
delete from limitazioni_followup;
delete from log_insert_852_opu;
delete from asset;
delete from tipicampioni;
delete from import_distributori_automatici_ko;
delete from access_dati;
delete from dati_utente_controlliufficiali;
delete from m_capi_sedute;
delete from suap_richieste_validazioni_prenotazione_numero_registrazione;
delete from m_vpm_categorie_riscontrate;
delete from suap_verifica_tentativi;
delete from associazione_matrici_piani;
delete from salvataggio_azioni_adottate;
delete from dpat_strumento_calcolo_nominativi_;
delete from biosicurezza_risposte;
delete from import_ba;
delete from import_ca_molluschi;
delete from opu_soggetto_fisico_storico;
delete from checklist;
delete from salvataggio_nonconformita;
delete from org_importati_to_mapping;
delete from tipoimpresa;
delete from organization_targhe;
delete from dpat_struttura_indicatore;
delete from oggettisequestrati_azioninonconformi;
delete from controlli_fields_value;
delete from contact_emailaddress;
delete from indirizzi_napoli_fase1;
delete from distributori_automatici;
delete from norme_violate_sanzioni;
delete from opu_stabilimenti_importati_no_aziende_agricole;
delete from apicoltura_consistenza;
delete from allerte_imprese_coinvolte;
delete from history;
delete from tb_accesslock;
delete from master_list_configuratore_livelli_aggiuntivi_values;
delete from organization_phone;
delete from project_files_download;
delete from moduli_campioni_fields_value;
delete from dpat_competenze_struttura_indicatore;
delete from a_i_equidi;
delete from gisa_storico_operazioni_utenti;
delete from registro_trasgressori_values_storico;
delete from log_import_852;
delete from project_files_version;
delete from project_files_thumbnail;
delete from project_files;
delete from organization_852_trasporto_conto_terzi;
delete from organization_852_trasporti_1202;
drop table table_app_no_duplicati_fisse;
delete from log_insert_privati_opu;
delete from privati_da_importare_import_old;
delete from registro_trasgressori_values;
delete from lista_prodotti_stabilimenti;
delete from comuni1;
delete from controlli_acque_rete;
delete from gestori_acque_indirizzi;
delete from animalitrasportati;
delete from chk_bns_boxes_v5;
delete from master_list_suap_allegati_procedure_relazione;
delete from contact_emailaddress_ext;
delete from m_vpm_capi_tamponi;
drop table organization_852_trasporti_non_importati;
delete from chk_bns_mod_ist;
delete from stampe_moduli_macelli;
delete from apicoltura_apiari;
delete from opu_soggetto_fisico_;
delete from coordinate_molluschi;
delete from registro_trasgressori_values_storico_record;
drop table dpat_strumento_calcolo_carichi_lavoro_digemon;
delete from apicoltura_apiari_variazioni_detentore;
delete from associazione_analiti_piani;
delete from apicoltura_apiari_variazioni_ubicazione;
delete from tipocampionechimico;
delete from sintesis_stabilimenti_import;
delete from sintesis_soggetto_fisico;
delete from m_vpm_patologie_rilevate;
delete from sintesis_storico_relazione_stabilimento_linee_produttive;
drop table opu_app_nomi;
delete from elenco_attivita_osm_reg;
delete from strutture_asl;
delete from quesiti_risposte_controllo_documentale;
delete from variaz_titolarita_nocessazione;
delete from opu_operatore_variazione_titolarita_stabilimenti;
delete from riferimento_org_id_id_relazione_stab_linea_produttiva;
delete from contact_address;
drop view dpat_coefficiente;
drop table dpat_coefficiente_;
delete from dpat_indicatore_;
drop table attori_opfuoriasl;
delete from chk_bns_capannoni_v4;
delete from organization_autoveicoli;
delete from gestori_acque_punti_prelievo;
delete from storico_modif_stab;
delete from laboratorihaccp_elenco_prove;
delete from ricerca_esito_tamponi;
delete from tab_cap;
drop table tab_cap_old;

drop table tamponi;
delete from import_osm_esiti;
delete from master_list_suap_tipo_attivita;
delete from master_list_suap;
delete from stab_853_report_open_data;
delete from dpat_codici_indicatore;
delete from anagrafica_nominativo;
delete from richieste_errata_corrige;
drop table codici_riscatto_app_mobile;
delete from richieste_errata_corrige_campi;
delete from categoriatrasportati;
delete from modello_5_values;
drop table indirizzi_napoli_fase3;
delete from chk_bns_mod_ist_v4_generica;
delete from lookup_esame_istopatologico_who_umana;
delete from buffer_comuni_coinvolti_storico;
drop table suap_mapping_linee;
delete from m_import_storico;
drop table tmp_censimenti_2017;
drop table scarti_operatore;
drop table soa_categorie_impianti_prodotti;
delete from contact_phone;
drop table dpat_strumento_calcolo_nominativi_temp;
delete from tipoalimentioriginevegetale;
delete from farmacosorveglianza_allegatoi;
drop table opu_linee_attivita_controlli_ufficiali_backup;
delete from import_b11;
drop table organization_852_trasporti_diletta_non_opu_ora_opu;
delete from log_user_reg;
drop table gestori_acque_punti_prelievo_old;
delete from cu_temp_checklist;
delete from reati_illecitipenali;
delete from apicoltura_deleghe;
drop table bk_dpat_piano;
delete from dpat_attivita_;
delete from bk_dpat_attivita;
delete from macelli_art17_errata_corrige;
delete from organization_personale;
drop table censimenti_from_bdn_tmp;
drop table nucleo_temp_utenti;
delete from laboratorihaccp_storico_elenco_prove;
delete from imprese_pregresso;
delete from master_list_sk_elenco;
delete from chk_bns_mod_ist_v5_suini;
delete from variazione_stato_operazioni_storico;
delete from lookup_denominazioni_labhaccp;
delete from buffer_comuni_coinvolti;
delete from opu_gestione_errata_corrige;
drop table organization_852_diletta_temp_unnested;
drop table sintesis_linee_attivita_controlli_ufficiali_backup;
drop table lista_prodotti_stabilimenti_old_;
delete from tipo_operatore_commerciale;
delete from dpat_codici_attivita;
delete from dpat_risorse_strumentali_strutture;
delete from organization_sediveicoli;
drop table organization_852_trasporti_non_opu_unnested_da_importare;
drop table organization_852_trasporti_non_opu;
drop table organization_852_trasporti_non_opu_unnested_da_importare_import;
delete from dpat_formula;
drop table temp;
delete from lookup_piano_monitoraggio_configuratore;
delete from apicoltura_movimentazioni;
delete from iuv_campioni_valutazione_comportamentale_anomalie ;
delete from iuv_campioni_valutazione_comportamentale;
delete from coordinate_zone_produzione;
delete from opu_gestione_errata_corrige_stabilimento;
delete from master_list_allegati_procedure_relazione;
drop table anagrafica."PREV_linee_attivita_controlli_ufficiali"
delete from iuv_campioni_valutazione_comportamentale_anomalie;
delete from iuv_campioni_valutazione_comportamentale;
delete from campione_specie_animali_pnaa_mangime;
delete from campione_prodotti_pnaa;
delete from ticket where ticketid <> 10000000
delete from linee_attivita_ml8_temp;
delete from m_lcso_organi;
delete from suap_opu_relazione_richiesta_id_opu_rel_stab_lp;
delete from bdn_ws_log;  
delete from audit;
delete from allegati_in_possesso_asl; 
drop table diag_indirizzi_napoli_puliti;
delete from suap_storico_richieste;
delete from tipo_molluschi;
delete from organization_address where trasheddate is not null;
delete from campione_specie_animali_pnaa_mangime;
delete from campione_prodotti_pnaa;
delete from organization_address where org_id in (select org_id from organization where trashed_date is not null);
delete from banchi_zone_molluschi; 
delete from organization_emailaddress; 
delete from storico_modif_stab;
delete from organization_phone;
delete from asset;
delete from history;
delete from attori_opfuoriasl;
delete from tipo_operatore_commerciale;
delete from organization_autoveicoli;
delete from organization  where trashed_date is not null and org_id <> -1
delete from organization_address where org_id in (select org_id from organization where tipologia=1)
delete from organization where tipologia=1
delete from la_imprese_linee_attivita;
truncate  sintesis_operatore cascade; 

delete from suap_ric_scia_relazione_stabilimento_linee_produttive;
delete from suap_ric_scia_rel_operatore_soggetto_fisico;
delete from suap_ric_scia_stabilimento;
delete from suap_ric_scia_operatore;
--tabelle da poter cancellare
drop table "ricerche_anagrafiche_old_materializzata_temp-cancellata";
drop table diag_indirizzi_napoli_rag_soc_fase1;
drop table blackberry_logs;
drop table storico_modif_stab;
drop table anagrafica.anagrafica_mappatura_old_new;
drop table indirizzi_napoli_fase1_bkp;
drop table nucleo_ispettivo_temp_test_2;
drop table soggetti_fisici_organization_852;
drop table table_app_no_duplicati_fisse;
drop table organization_852_trasporti_non_importati;
drop table cu_nucleo_temporaneao;
drop table stab_853_report_open_data;
drop table codici_riscatto_app_mobile;
drop table indirizzi_napoli_fase3;
drop table suap_mapping_linee cascade;
drop table tmp_censimenti_2017;
drop table dpat_strumento_calcolo_nominativi_temp;
drop table opu_linee_attivita_controlli_ufficiali_backup;
drop table  organization_852_trasporti_diletta_non_opu_ora_opu;
drop table  gestori_acque_punti_prelievo_old;
drop table  cu_temp_checklist;
drop table  bk_dpat_piano;
drop table  censimenti_from_bdn_tmp;
drop table  nucleo_temp_utenti;
drop table  organization_852_diletta_temp_unnested;
drop table  sintesis_linee_attivita_controlli_ufficiali_backup;
drop table  lista_prodotti_stabilimenti_old_;
drop table  organization_852_trasporti_non_opu_unnested_da_importare;
drop table  organization_852_trasporti_non_opu;
drop table  organization_852_trasporti_non_opu_unnested_da_importare_import;
drop table temp;
drop table riferimento_org_id_id_stabilimento;
drop table riferimento_org_id_id_operatore;
drop table dbi_get_controlli_ufficiali_eseguiti_table;
drop table anagrafica_852_o; 
drop table cu_programmazioni_asl cascade
drop table report_vista_osa_mai_controllati
drop table informazioni_sanitarie_allevamenti;
drop table organization_852_ateco_mappati;
drop table soa_categorie_impianti;  
drop table soa_categorie_impianti_prodotti;
delete from suap_ric_scia_soggetto_fisico;

-- cancellazione parte apiari
truncate apicoltura_apiari; 
truncate apicoltura_rel_impresa_soggetto_fisico cascade;
truncate apicoltura_imprese cascade;
delete from apicoltura_deleghe;
-- cancellazione parte opu lasciando gli ultimi record
delete from opu_relazione_stabilimento_linee_produttive where id_stabilimento is null and id_stabilimento in (select id from opu_stabilimento where id_operatore not in (select id from opu_operatore  order by id desc limit 4));
delete from opu_stabilimento where id_operatore is null and id_operatore not in (select id from opu_operatore  order by id desc limit 4);
delete from opu_rel_operatore_soggetto_fisico where id_operatore not in (select id from opu_operatore  order by id desc limit 4);
delete from opu_operatore where id not in (select id from opu_operatore order by id desc limit 4);
delete from opu_soggetto_fisico where id not in (select id_soggetto_fisico from opu_rel_operatore_soggetto_fisico);
delete from opu_indirizzo where id not in (
select id_indirizzo from opu_stabilimento 
union 
select id_indirizzo from opu_operatore  
union
select indirizzo_id from opu_soggetto_fisico 
);
-- cancellazione parte organization lasciamo solo gli allevamenti
delete from aziende;
delete from operatori_allevamenti;  
delete from organization_address where org_id not in (select org_id from organization where tipologia=2 order by org_id desc limit 5);
delete from organization where tipologia =2 and org_id not in (select org_id from organization where tipologia=2 order by org_id desc limit 5);

delete from ricerche_anagrafiche_old_materializzata;
insert into ricerche_anagrafiche_old_materializzata  (select * from ricerca_anagrafiche);  

-- query verifica per anagrafiche presenti
select count(*), tipologia_operatore, 
riferimento_id_nome_tab  
from ricerche_anagrafiche_old_materializzata 
group by  riferimento_id_nome_tab,tipologia_operatore
