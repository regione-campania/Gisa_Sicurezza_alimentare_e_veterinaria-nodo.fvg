--BDU
drop foreign table cartella_clinica_operazioni_in_sospeso;
drop foreign table opu_operatori_denormalizzati_canili_canili_gisa;			
drop foreign table controlli_ufficiali_cani_aggressori;			
drop foreign table controlli_ufficiali_proprietari_cani;
drop foreign table file_commissione;					
drop foreign table guc_utenti_bdu_remote;
drop view sinaaf_pregresso_estrazione_strutture_detenzione ;	
drop view sinaaf_pregresso_estrazione_colonie ;			
drop foreign table indirizzi_colonia;
drop foreign table opu_operatori_denormalizzati_canili_opc_gisa_organization;
drop foreign table opu_operatori_denormalizzati_uos;
drop VIEW public.canili_bdu_except_gisa_opu_view ;
drop view canili_bdu_except_gisa_view;
drop view canili_gisa_except_bdu_opu_view;
drop view canili_gisa_except_bdu_view;				
drop foreign table r_canili_gisa;						
drop foreign table r_canili_gisa_opu;
drop foreign table sinaaf_opu_operatori_denormalizzati_view_canili_bdu;
DROP FOREIGN TABLE public.fg_struttura_detenzione_dati;



create view controlli_ufficiali_cani_aggressori as
  select t.ticketid  ,    t.microchip  , t.tatuaggio  ,  t.codice_evento   
                  FROM dblink((select * from conf.get_pg_conf('GISA')), 'select t.ticketid  ,    t.microchip  , t.tatuaggio  ,  t.codice_evento from controlli_ufficiali_cani_aggressori t') 
                  as t(ticketid integer ,    microchip text ,    tatuaggio text ,    codice_evento text)
;






CREATE FOREIGN TABLE public.controlli_ufficiali_cani_aggressori
   (ticketid integer ,
    microchip text ,
    tatuaggio text ,
    codice_evento text )
   SERVER foreign_server_gisa
   OPTIONS (schema_name 'public', table_name 'controlli_ufficiali_cani_aggressori');
ALTER FOREIGN TABLE public.controlli_ufficiali_cani_aggressori
  OWNER TO postgres;




CREATE OR REPLACE FUNCTION public_functions.dbi_bdu_animali_anagrafati(
    IN tipospecie integer,
    IN asl integer,
    IN anno_inserimento integer,
    IN anno_registrazione integer,
    IN tipovet integer)
  RETURNS TABLE(data_inserimento timestamp without time zone, data_registrazione timestamp without time zone, microchip text, tatuaggio text, inserito_da text, ruolo_inserito_da text, id_animale integer, flag_attivita_itinerante boolean, comune_attivita_itinerante text, luogo_attivita_itinerante text, data_attivita_itinerante timestamp without time zone, commerciale text, stato_originale text, asl_originale text, id_asl integer, specie text, razza text, flag_incrocio boolean, veterinario_chippatore text, data_microchip timestamp without time zone, stato_decesso text, proprietario text, comune_proprietario text, tipo_proprietario text, tipo_vet integer, data_nascita timestamp without time zone, flag_stampata_richiesta_prima_iscrizione boolean, sesso text) AS
$BODY$
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
   --left join animali_flag_stampata_richiesta_prima_iscrizione flag on flag.animale = animale.id
   LEFT JOIN  (select flag.animale  
                  FROM dblink((select * from conf.get_pg_conf('DOCUMENTALE')), 'select flag.animale  from animali_flag_stampata_richiesta_prima_iscrizione flag') 
                  as flag(animale integer)) flag ON flag.animale= animale.id
     
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
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION public_functions.dbi_bdu_animali_anagrafati(integer, integer, integer, integer, integer)
  OWNER TO postgres;



CREATE OR REPLACE FUNCTION public_functions.dbi_bdu_animali_anagrafati_new(
    IN tipospecie integer,
    IN asl integer,
    IN anno_inserimento integer,
    IN anno_registrazione integer,
    IN tipovet integer)
  RETURNS TABLE(data_inserimento timestamp without time zone, data_registrazione timestamp without time zone, microchip text, tatuaggio text, inserito_da text, ruolo_inserito_da text, id_animale integer, flag_attivita_itinerante boolean, comune_attivita_itinerante text, luogo_attivita_itinerante text, data_attivita_itinerante timestamp without time zone, commerciale text, stato_originale text, asl_originale text, id_asl integer, specie text, razza text, veterinario_chippatore text, data_microchip timestamp without time zone, stato_decesso text, proprietario text, comune_proprietario text, tipo_proprietario text, tipo_vet integer, data_nascita timestamp without time zone, flag_mancata_origine boolean, flag_stampata_richiesta_prima_iscrizione boolean, flag_acquisto_online boolean, sito_web_acquisto text, sito_web_acquisto_note text, sesso text) AS
$BODY$
BEGIN
	FOR data_inserimento, data_registrazione, microchip , tatuaggio, inserito_da, ruolo_inserito_da, id_animale, flag_attivita_itinerante, comune_attivita_itinerante , luogo_attivita_itinerante , 
  data_attivita_itinerante ,commerciale, stato_originale, asl_originale, id_asl, specie, razza, veterinario_chippatore, data_microchip, stato_decesso, proprietario, comune_proprietario, tipo_proprietario, tipo_vet, data_nascita,
  flag_mancata_origine,flag_stampata_richiesta_prima_iscrizione, flag_acquisto_online, sito_web_acquisto, sito_web_acquisto_note,sesso
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
case when vet.namefirst is not null and  vet.namelast is not null then pg_catalog.concat(vet.namefirst, ' ', vet.namelast) else 'N.D.'::text end AS veterinario_chippatore, 
animale.data_microchip as data_microchip, 
CASE WHEN animale.flag_decesso THEN 'MORTO'::text ELSE 'VIVO'::text END AS stato_decesso, 
COALESCE(operatore.ragione_sociale, 'N.D.'::text) AS proprietario, 
COALESCE(comuni1.nome, 'N.D.'::text) AS comune_proprietario, 
COALESCE(linea.description, 'N.D.'::text) AS tipo_proprietario,
CASE WHEN utenti.role_id = 24 THEN '1'::integer ELSE '2'::integer END AS tipo_vet,
animale.data_nascita,
animale.flag_mancata_origine,
flag.animale is not null as flag_stampata_richiesta_prima_iscrizione,
reg.flag_acquisto_online, 
reg.sito_web_acquisto, 
reg.sito_web_acquisto_note,
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
   --left join animali_flag_stampata_richiesta_prima_iscrizione flag on flag.animale = animale.id
   LEFT JOIN  (select flag.animale  
                  FROM dblink((select * from conf.get_pg_conf('DOCUMENTALE')), 'select flag.animale  from animali_flag_stampata_richiesta_prima_iscrizione flag') 
                  as flag(animale integer)) flag ON flag.animale= animale.id
   
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
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION public_functions.dbi_bdu_animali_anagrafati_new(integer, integer, integer, integer, integer)
  OWNER TO postgres;



drop foreign table animali_flag_stampata_richiesta_prima_iscrizione;

drop foreign table fg_linee_mobili_fields_value;

create view fg_linee_mobili_fields_value as
  select t.id  , t.id_rel_stab_linea  ,  t.id_linee_mobili_html_fields  ,  t.valore_campo  , t.indice  , t.enabled  , t.id_utente_inserimento  ,
                  t.data_inserimento  , t.id_opu_rel_stab_linea  
                  FROM dblink((select * from conf.get_pg_conf('GISA')), 'select t.id  , t.id_rel_stab_linea  ,  t.id_linee_mobili_html_fields  ,  t.valore_campo  , t.indice  , t.enabled  , t.id_utente_inserimento  ,
                  t.data_inserimento  , t.id_opu_rel_stab_linea  from linee_mobili_fields_value t') 
                  as t(id integer , id_rel_stab_linea integer ,  id_linee_mobili_html_fields integer ,  valore_campo text , indice integer , enabled boolean , id_utente_inserimento integer ,
                  data_inserimento timestamp without time zone , id_opu_rel_stab_linea integer)
;



drop foreign table fg_linee_mobili_html_fields;



create view fg_linee_mobili_html_fields as 
select t.id  , t.enabled  ,  t.ordine_campo  
                  FROM dblink((select * from conf.get_pg_conf('GISA')), 'select t.id  , t.enabled  ,  t.ordine_campo   from fg_linee_mobili_html_fields t') 
                  as t(id integer,    enabled boolean ,    ordine_campo integer)
;






drop foreign table lookup_associazioni_animaliste;


create or replace view lookup_associazioni_animaliste as 
select t.code  ,    t.description  ,   t.default_item  ,  t.level , t.asl , t.enabled  ,  t.entered ,  t.modified ,  t.partita_iva , t.indirizzo , t.id_specie , t.ragione_sociale  
                  FROM dblink((select * from conf.get_pg_conf('GISA')), 'select t.code  ,    t.description  ,   t.default_item  ,  t.level , t.asl , t.enabled  ,  t.entered ,  t.modified ,  t.partita_iva , t.indirizzo , t.id_specie , t.ragione_sociale    from associazioni_view t') 
                  as t(code integer ,
    description text ,
    default_item boolean ,
    level integer ,
    asl integer ,
    enabled boolean ,
    entered timestamp without time zone ,
    modified timestamp without time zone ,
    partita_iva text ,
    indirizzo text ,
    id_specie integer ,
    ragione_sociale text )
;






drop foreign table lookup_diagnosi_citologica;



create or replace view lookup_diagnosi_citologica as 
select t.code  ,    t.description  ,    t.default_item  ,    t.enabled  ,    t.level  ,    t.isgroup  ,    t.entered  ,    t.modified   
                  FROM dblink((select * from conf.get_pg_conf('VAM')), 'select t.code  ,    t.description  ,    t.default_item  ,    t.enabled  ,    t.level  ,    t.isgroup  ,    t.entered  ,    t.modified     from lookup_esame_citologico_diagnosi_bdu t') 
                  as t(code integer ,
    description text ,
    default_item boolean ,
    enabled boolean ,
    level integer ,
    isgroup boolean ,
    entered timestamp without time zone ,
    modified timestamp without time zone )
;




drop foreign table  lookup_diagnosi_istologica;


create or replace view lookup_diagnosi_istologica as 
select t.code  ,    t.description  ,    t.default_item  ,    t.enabled  ,    t.level  ,    t.padre  ,    t.entered  ,    t.modified   
                  FROM dblink((select * from conf.get_pg_conf('VAM')), 'select t.code  ,    t.description  ,    t.default_item  ,    t.enabled  ,    t.level  ,    t.padre  ,    t.entered  ,    t.modified   from lookup_esame_istopatologico_who_umana_bdu t') 
                  as t(code integer ,
    description text ,
    default_item boolean ,
    enabled boolean ,
    level integer ,
    padre integer ,
    entered timestamp without time zone ,
    modified timestamp without time zone  )
;






DROP FOREIGN TABLE public.opu_operatori_denormalizzati_canili_opc_gisa;

create or replace view opu_operatori_denormalizzati_canili_opc_gisa as 
select id_stabilimento  ,
    id_opu_operatore  ,
    partita_iva  ,
    codice_fiscale_impresa  ,
    ragione_sociale  ,
    nome_rapp_sede_legale  ,
    cognome_rapp_sede_legale  ,
    cf_rapp_sede_legale  ,
    data_nascita_rapp_sede_legale  ,
    sesso  ,
    comune_nascita_rapp_sede_legale  ,
    sigla_prov_soggfisico  ,
    comune_residenza  ,
    via_rapp_sede_legale  ,
    civico  ,
    cap_residenza  ,
    nazione_residenza ,
    sigla_prov_legale  ,
    comune_sede_legale  ,
    via_sede_legale  ,
    civico_sede_legale  ,
    cap_sede_legale  ,
    nazione_sede_legale  ,
    sigla_prov_operativa  ,
    comune_stab  ,
    via_stabilimento_calcolata  ,
    civico_sede_stab  ,
    cap_stab  ,
    nazione_stab  ,
    id_asl  ,
    toponimo_residenza  ,
    toponimo_sede_legale  ,
    toponimo_sede_stab  ,
    id_linea_attivita  ,
    modifiedby  ,
    modified  ,
    enteredby  ,
    entered ,
    id_linea_bdu  ,
    lat_stab ,
    long_stab      
                  FROM dblink((select * from conf.get_pg_conf('GISA')), 'select id_stabilimento  ,
    id_opu_operatore  ,
    partita_iva  ,
    codice_fiscale_impresa  ,
    ragione_sociale  ,
    nome_rapp_sede_legale  ,
    cognome_rapp_sede_legale  ,
    cf_rapp_sede_legale  ,
    data_nascita_rapp_sede_legale  ,
    sesso  ,
    comune_nascita_rapp_sede_legale  ,
    sigla_prov_soggfisico  ,
    comune_residenza  ,
    via_rapp_sede_legale  ,
    civico  ,
    cap_residenza  ,
    nazione_residenza ,
    sigla_prov_legale  ,
    comune_sede_legale  ,
    via_sede_legale  ,
    civico_sede_legale  ,
    cap_sede_legale  ,
    nazione_sede_legale  ,
    sigla_prov_operativa  ,
    comune_stab  ,
    via_stabilimento_calcolata  ,
    civico_sede_stab  ,
    cap_stab  ,
    nazione_stab  ,
    id_asl  ,
    toponimo_residenza  ,
    toponimo_sede_legale  ,
    toponimo_sede_stab  ,
    id_linea_attivita  ,
    modifiedby  ,
    modified  ,
    enteredby  ,
    entered ,
    id_linea_bdu  ,
    lat_stab ,
    long_stab   from opu_operatori_denormalizzati_view_bdu t') 
                  as t(id_stabilimento integer ,
    id_opu_operatore integer ,
    partita_iva text ,
    codice_fiscale_impresa text ,
    ragione_sociale text ,
    nome_rapp_sede_legale text ,
    cognome_rapp_sede_legale text ,
    cf_rapp_sede_legale text ,
    data_nascita_rapp_sede_legale timestamp without time zone ,
    sesso text ,
    comune_nascita_rapp_sede_legale text ,
    sigla_prov_soggfisico text ,
    comune_residenza text ,
    via_rapp_sede_legale text ,
    civico text ,
    cap_residenza text ,
    nazione_residenza text ,
    sigla_prov_legale text ,
    comune_sede_legale text ,
    via_sede_legale text ,
    civico_sede_legale text ,
    cap_sede_legale text ,
    nazione_sede_legale text ,
    sigla_prov_operativa text ,
    comune_stab text ,
    via_stabilimento_calcolata text ,
    civico_sede_stab text ,
    cap_stab text ,
    nazione_stab text ,
    id_asl integer ,
    toponimo_residenza text ,
    toponimo_sede_legale text ,
    toponimo_sede_stab text ,
    id_linea_attivita integer ,
    modifiedby integer ,
    modified timestamp without time zone ,
    enteredby integer ,
    entered timestamp without time zone ,
    id_linea_bdu integer ,
    lat_stab double precision ,
    long_stab double precision  )
;




DROP FOREIGN TABLE public.r_gisa_opu_relazione_stabilimento_linee_produttive;
  
create or replace view r_gisa_opu_relazione_stabilimento_linee_produttive as 
select id  ,
    id_linea_produttiva  ,
    id_stabilimento  ,
    stato  ,
    data_inizio  ,
    data_fine  ,
    autorizzazione  ,
    note  ,
    telefono1  ,
    telefono2  ,
    mail1  ,
    mail2  ,
    fax  ,
    tipo_attivita_produttiva  ,
    primario  ,
    enabled  ,
    modified     ,
    modifiedby  ,
    descrizione_linea_attivita  ,
    numero_registrazione  ,
    id_linea_nuova_aziende_agricole  ,
    codice_ufficiale_esistente  ,
    data_generazione_numero e ,
    id_rel_stab_lp_old  ,
    categoria_rischio  ,
    data_prossimo_controllo  ,
    id_vecchia_linea  ,
    num_protocollo  ,
    id_tipo_vecchio_operatore  ,
    codice_nazionale  ,
    data_generazione_codice_nazionale ,
    id_nuova_linea_azienda_agricole  ,
    entered     ,
    enteredby  ,
    data_sospensione_volontaria  ,
    pregresso_o_import  ,
    id_linea_fittizia_pre_aggiornamento  ,
    flag_spostamento  ,
    id_scia_sospensione  ,
    scia_sospensione  ,
    id_suap_rel_stab_lp  ,
    note_internal_use_hd_only  ,
    note_hd  ,
    codice_univoco_ml  ,
    id_linea_produttiva_old  ,
    codice_sinaaf  ,
    id_sinaaf       
                  FROM dblink((select * from conf.get_pg_conf('GISA')), 'select id  ,
    id_linea_produttiva  ,
    id_stabilimento  ,
    stato  ,
    data_inizio  ,
    data_fine  ,
    autorizzazione  ,
    note  ,
    telefono1  ,
    telefono2  ,
    mail1  ,
    mail2  ,
    fax  ,
    tipo_attivita_produttiva  ,
    primario  ,
    enabled  ,
    modified     ,
    modifiedby  ,
    descrizione_linea_attivita  ,
    numero_registrazione  ,
    id_linea_nuova_aziende_agricole  ,
    codice_ufficiale_esistente  ,
    data_generazione_numero e ,
    id_rel_stab_lp_old  ,
    categoria_rischio  ,
    data_prossimo_controllo  ,
    id_vecchia_linea  ,
    num_protocollo  ,
    id_tipo_vecchio_operatore  ,
    codice_nazionale  ,
    data_generazione_codice_nazionale ,
    id_nuova_linea_azienda_agricole  ,
    entered     ,
    enteredby  ,
    data_sospensione_volontaria  ,
    pregresso_o_import  ,
    id_linea_fittizia_pre_aggiornamento  ,
    flag_spostamento  ,
    id_scia_sospensione  ,
    scia_sospensione  ,
    id_suap_rel_stab_lp  ,
    note_internal_use_hd_only  ,
    note_hd  ,
    codice_univoco_ml  ,
    id_linea_produttiva_old  ,
    codice_sinaaf  ,
    id_sinaaf   from opu_relazione_stabilimento_linee_produttive t') 
                  as t(id integer ,
    id_linea_produttiva integer ,
    id_stabilimento integer ,
    stato integer ,
    data_inizio timestamp without time zone ,
    data_fine timestamp without time zone ,
    autorizzazione text ,
    note character varying ,
    telefono1 text ,
    telefono2 text ,
    mail1 text ,
    mail2 text ,
    fax text ,
    tipo_attivita_produttiva integer ,
    primario boolean ,
    enabled boolean ,
    modified timestamp without time zone ,
    modifiedby integer ,
    descrizione_linea_attivita text ,
    numero_registrazione text ,
    id_linea_nuova_aziende_agricole integer ,
    codice_ufficiale_esistente text ,
    data_generazione_numero timestamp without time zone ,
    id_rel_stab_lp_old integer ,
    categoria_rischio integer ,
    data_prossimo_controllo time with time zone ,
    id_vecchia_linea integer ,
    num_protocollo text ,
    id_tipo_vecchio_operatore integer ,
    codice_nazionale text ,
    data_generazione_codice_nazionale timestamp without time zone ,
    id_nuova_linea_azienda_agricole integer ,
    entered timestamp without time zone ,
    enteredby integer ,
    data_sospensione_volontaria timestamp without time zone ,
    pregresso_o_import boolean ,
    id_linea_fittizia_pre_aggiornamento integer ,
    flag_spostamento boolean ,
    id_scia_sospensione integer ,
    scia_sospensione boolean ,
    id_suap_rel_stab_lp integer ,
    note_internal_use_hd_only text ,
    note_hd text ,
    codice_univoco_ml text ,
    id_linea_produttiva_old integer ,
    codice_sinaaf text ,
    id_sinaaf text   )
;

DROP FOREIGN TABLE public.r_ml8_linee_attivita_nuove_materializzata;

create or replace view r_ml8_linee_attivita_nuove_materializzata as 
select id_nuova_linea_attivita  ,
    enabled  ,
    id_macroarea  ,
    id_aggregazione  ,
    id_attivita  ,
    codice_macroarea  ,
    codice_aggregazione  ,
    codice_attivita  ,
    macroarea  ,
    aggregazione  ,
    attivita  ,
    id_norma  ,
    norma  ,
    descrizione  ,
    livello  ,
    id_padre  ,
    path_id   ,
    path_descrizione ,
    "?column?"  ,
    codice  ,
    path_codice ,
    flag_pnaa  ,
    id_lookup_configurazione_validazione  ,
    id_lookup_tipo_attivita  ,
    id_lookup_tipo_linee_mobili  ,
    decodifica_tipo_produzione_bdn  ,
    decodifica_codice_orientamento_bdn  ,
    decodifica_specie_bdn        
                  FROM dblink((select * from conf.get_pg_conf('GISA')), 'select id_nuova_linea_attivita  ,
    enabled  ,
    id_macroarea  ,
    id_aggregazione  ,
    id_attivita  ,
    codice_macroarea  ,
    codice_aggregazione  ,
    codice_attivita  ,
    macroarea  ,
    aggregazione  ,
    attivita  ,
    id_norma  ,
    norma  ,
    descrizione  ,
    livello  ,
    id_padre  ,
    path_id   ,
    path_descrizione ,
    "?column?"  ,
    codice  ,
    path_codice ,
    flag_pnaa  ,
    id_lookup_configurazione_validazione  ,
    id_lookup_tipo_attivita  ,
    id_lookup_tipo_linee_mobili  ,
    decodifica_tipo_produzione_bdn  ,
    decodifica_codice_orientamento_bdn  ,
    decodifica_specie_bdn   from ml8_linee_attivita_nuove_materializzata t') 
                  as t(id_nuova_linea_attivita integer ,
    enabled boolean ,
    id_macroarea integer ,
    id_aggregazione integer ,
    id_attivita integer ,
    codice_macroarea text ,
    codice_aggregazione text ,
    codice_attivita text ,
    macroarea text ,
    aggregazione text ,
    attivita text ,
    id_norma integer ,
    norma text ,
    descrizione text ,
    livello integer ,
    id_padre integer ,
    path_id character varying(1000) ,
    path_descrizione character varying(1000) ,
    "?column?" text ,
    codice text ,
    path_codice character varying(1000) ,
    flag_pnaa boolean ,
    id_lookup_configurazione_validazione integer ,
    id_lookup_tipo_attivita integer ,
    id_lookup_tipo_linee_mobili integer ,
    decodifica_tipo_produzione_bdn text ,
    decodifica_codice_orientamento_bdn text ,
    decodifica_specie_bdn text  )
;

DROP SERVER foreign_server_documentale cascade;
DROP SERVER foreign_server cascade;
DROP SERVER foreign_server_gisa cascade;
DROP SERVER foreign_server_vam cascade;
DROP SERVER foreign_server_guc cascade;


--VAM
DROP FOREIGN TABLE public.registro_tumori_dati_bdu;


create or replace view registro_tumori_dati_bdu as 
select microchip  , tatuaggio  ,  data_decesso     ,  comune_detentore_attuale  ,  comune_decesso   
                  FROM dblink((select * from conf.get_pg_conf('BDU')), 'select microchip  , tatuaggio  ,  data_decesso     ,  comune_detentore_attuale  ,  comune_decesso  from registro_tumori_dati_bdu t') 
                  as t(microchip text ,
    tatuaggio text ,
    data_decesso timestamp without time zone ,
    comune_detentore_attuale text ,
    comune_decesso text )
;

DROP SERVER foreign_server_gisa cascade;
DROP SERVER foreign_server_bdu cascade;



--GISA
DROP FOREIGN TABLE public.guc_utenti_gisa_ext_remote;
DROP FOREIGN TABLE public.guc_utenti_gisa_remote;
DROP FOREIGN TABLE public.r_canili_gisa;
DROP FOREIGN TABLE public.r_documentale_storage_gisa_allegati;

DROP SERVER foreign_server cascade;
DROP SERVER foreign_server_documentale cascade; 
DROP SERVER foreign_server_guc cascade;


--GUC
DROP FOREIGN TABLE public.remote_bdu_access_;

DROP SERVER foreign_server_bdu cascade;
DROP SERVER foreign_server_bdu_priv cascade;

