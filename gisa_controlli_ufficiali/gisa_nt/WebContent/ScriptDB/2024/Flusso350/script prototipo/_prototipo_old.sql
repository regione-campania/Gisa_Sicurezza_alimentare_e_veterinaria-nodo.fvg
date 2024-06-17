--Controllare le funzioni e le viste se sono allineate con ufficiale
--FUNZIONI DI SISTEMA
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

CREATE EXTENSION unaccent
  SCHEMA public
  VERSION "1.1";

  CREATE OR REPLACE FUNCTION public.unaccent(text)
 RETURNS text
 LANGUAGE c
 immutable PARALLEL SAFE STRICT
AS '$libdir/unaccent', $function$unaccent_dict$function$
;

CREATE OR REPLACE FUNCTION public.unaccent(regdictionary, text)
 RETURNS text
 LANGUAGE c
 immutable PARALLEL SAFE strict  
AS '$libdir/unaccent', $function$unaccent_dict$function$  
;

ALTER FUNCTION unaccent(regdictionary,text) IMMUTABLE


--TABELLE E RELATIVI CAMPI
ALTER TABLE master_list_flag_linee_attivita drop column codice_tipologia_struttura_sinac;
ALTER TABLE master_list_flag_linee_attivita ADD sinac_codice_struttura_detenzione varchar NULL;
ALTER TABLE master_list_flag_linee_attivita ADD sinac_codice_struttura_veterinaria varchar NULL;
ALTER TABLE master_list_flag_linee_attivita ADD bdu_canile boolean;
ALTER TABLE master_list_flag_linee_attivita ADD bdu_operatore_commerciale boolean;
ALTER TABLE opu_relazione_stabilimento_linee_produttive ADD id_sinaaf text NULL;
ALTER TABLE opu_relazione_stabilimento_linee_produttive ADD codice_sinaaf varchar(200) NULL;
ALTER TABLE opu_relazione_stabilimento_linee_produttive ADD modified_sinaaf timestamp NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE opu_relazione_stabilimento_linee_produttive ADD trashed_date timestamp NULL;
ALTER TABLE opu_relazione_stabilimento_linee_produttive ADD sinaaf_estrazione_invio_pregresso_ok timestamp NULL;
ALTER TABLE opu_relazione_stabilimento_linee_produttive ADD sinaaf_invio_ws_ok timestamp NULL;
ALTER TABLE opu_relazione_stabilimento_linee_produttive ADD bdu_invio_ok timestamp NULL;
ALTER TABLE opu_relazione_stabilimento_linee_produttive ADD vam_invio_ok timestamp NULL;
ALTER TABLE opu_soggetto_fisico ADD codice_fiscale_fittizio text NULL;
ALTER TABLE opu_soggetto_fisico ADD codice_fiscale_fittizio_sinaaf text NULL;
ALTER TABLE opu_soggetto_fisico ADD id_sinaaf text NULL;
ALTER TABLE opu_soggetto_fisico ADD codice_sinaaf text NULL;
ALTER TABLE opu_soggetto_fisico ADD modified_sinaaf timestamp NULL;
ALTER TABLE opu_soggetto_fisico ADD sinaaf_estrazione_invio_pregresso_ok timestamp NULL;
ALTER TABLE opu_soggetto_fisico ADD sinaaf_invio_ws_ok timestamp NULL;
ALTER TABLE opu_relazione_stabilimento_linee_produttive ADD id_sinaaf text NULL;
ALTER TABLE opu_relazione_stabilimento_linee_produttive ADD codice_sinaaf varchar(200) NULL;
ALTER TABLE opu_relazione_stabilimento_linee_produttive ADD modified_sinaaf timestamp NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE opu_relazione_stabilimento_linee_produttive ADD trashed_date timestamp NULL;
ALTER TABLE opu_relazione_stabilimento_linee_produttive ADD sinaaf_estrazione_invio_pregresso_ok timestamp NULL;
ALTER TABLE public.opu_relazione_stabilimento_linee_produttive ADD id_bdu varchar NULL;
ALTER TABLE public.opu_relazione_stabilimento_linee_produttive ADD id_vam varchar NULL;

insert into permission(category_id, permission_view, permission, enabled, description) values (12, true, 'cooperazione_SINAC', true, 'cooperazione_SINAC') returning permission_id;
insert into role_permission(role_id, role_view, permission_id) values (1,  true, 856);
insert into role_permission(role_id, role_view, permission_id) values (32, true, 856);

--CONFIGURAZIONE CODICI SINAC
--Studio veterinario va in Vam?
--Tutta la macroarea IUV è stata disabilitata per Vam
--In Sinac va propagato ciò che in Vam e Bdu non ci va?
--Controllare se quelle già presenti in Gisa-Bdu-Vam sono coerenti con questi flag. Attività da fare quando si farò il resoconto di cosa sta in Gisa-Bdu-Vam-Sinac
--Tutta la macroarea 'Strutture Veterinarie' è stata disabilitata per Bdu
--Toelettatura va in Bdu?Per il momento inviano solo in Sinac
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'FARMACI VETERINARI' and aggregazione ilike 'ALLEVAMENTO DI ANIMALI, PER IL QUALE E'' NECESSARIO IL CODICE AZIENDALE BDN, MUNITO DI SCORTA DI FARMACI VETERINARI' and attivita ilike 'CON SCORTA AD USO DEL O DEI PROPRI ALLEVAMENTI SITI ALL''INTERNO DI UN''UNICA AZIENDA' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'FARMACI VETERINARI' and aggregazione ilike 'CONCENTRAMENTO DI ANIMALI, PER IL QUALE NON E'' NECESSARIO IL CODICE AZIENDALE BDN, MUNITO DI SCORTA DI FARMACI VETERINARI' and attivita ilike 'CONCENTRAMENTO DI ANIMALI, PER IL QUALE NON E'' NECESSARIO IL CODICE AZIENDALE BDN, MUNITO DI SCORTA DI FARMACI VETERINARI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'FARMACI VETERINARI' and aggregazione ilike 'COMMERCIO ALL''INGROSSO' and attivita ilike 'COMMERCIO ALL''INGROSSO SENZA VENDITA AL DETTAGLIO (ART.66) IN LOCALI CON SUPERFICIE TOTALE LORDA COMPRENSIVA DI SERVIZI E DEPOSITI INFERIORE A 400 MQ' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'FARMACI VETERINARI' and aggregazione ilike 'COMMERCIO ALL''INGROSSO' and attivita ilike 'COMMERCIO ALL''INGROSSO SENZA VENDITA AL DETTAGLIO (ART.66) IN LOCALI CON SUPERFICIE TOTALE LORDA COMPRENSIVA DI SERVIZI E DEPOSITI SUPERIORE A 400 MQ' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'FARMACI VETERINARI' and aggregazione ilike 'COMMERCIO ALL''INGROSSO' and attivita ilike 'COMMERCIO ALL''INGROSSO CON VENDITA AL DETTAGLIO (ART. 66 + ART. 70 punto 2) IN LOCALI CON SUPERFICIE TOTALE LORDA COMPRENSIVA DI SERVIZI E DEPOSITI INFERIORE A 400 MQ' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'FARMACI VETERINARI' and aggregazione ilike 'COMMERCIO ALL''INGROSSO' and attivita ilike 'COMMERCIO ALL''INGROSSO CON VENDITA AL DETTAGLIO (ART. 66 + ART. 70 punto 2) IN LOCALI CON SUPERFICIE TOTALE LORDA COMPRENSIVA DI SERVIZI E DEPOSITI SUPERIORE A 400 MQ' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'FARMACI VETERINARI' and aggregazione ilike 'MEDICO VETERINARIO MUNITO DI SCORTA DI FARMACI VETERINARI PER ATTIVITA'' ZOOIATRICA' and attivita ilike 'MEDICO VETERINARIO MUNITO DI SCORTA DI FARMACI VETERINARI PER ATTIVITA'' ZOOIATRICA' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'FARMACI VETERINARI' and aggregazione ilike 'ESERCIZIO DI VENDITA AL DETTAGLIO CHE EFFETTUA LA VENDITA DI FARMACI VETERINARI' and attivita ilike 'ESERCIZIO DI VICINATO CHE EFFETTUA LA VENDITA DI FARMACI VETERINARI (ART. 70 PUNTO 1)' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'FARMACI VETERINARI' and aggregazione ilike 'ESERCIZIO DI VENDITA AL DETTAGLIO CHE EFFETTUA LA VENDITA DI FARMACI VETERINARI' and attivita ilike 'GRANDE STRUTTURA DI VENDITA CHE EFFETTUA LA VENDITA DI FARMACI VETERINARI (ART. 70 PUNTO 1)' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'FARMACI VETERINARI' and aggregazione ilike 'ESERCIZIO DI VENDITA AL DETTAGLIO CHE EFFETTUA LA VENDITA DI FARMACI VETERINARI' and attivita ilike 'MEDIA STRUTTURA DI VENDITA CHE EFFETTUA LA VENDITA DI FARMACI VETERINARI (ART. 70 PUNTO 1)' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'FARMACI VETERINARI' and aggregazione ilike 'STRUTTURA VETERINARIA MUNITA DI SCORTA DI FARMACI VETERINARI' and attivita ilike 'STRUTTURA VETERINARIA MUNITA DI SCORTA DI FARMACI VETERINARI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = 'A' , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'STRUTTURE VETERINARIE' and aggregazione ilike 'AMBULATORIO VETERINARIO' and attivita ilike 'PRIVATO' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = 'A' , vam = true, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'STRUTTURE VETERINARIE' and aggregazione ilike 'AMBULATORIO VETERINARIO' and attivita ilike 'PUBBLICO' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'STRUTTURE VETERINARIE' and aggregazione ilike 'ENTE O IMPRESA CHE UTILIZZA AMBULANZE VETERINARIE' and attivita ilike 'ENTE O IMPRESA CHE UTILIZZA AMBULANZE VETERINARIE' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = 'C' , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'STRUTTURE VETERINARIE' and aggregazione ilike 'CLINICA VETERINARIA - CASA DI CURA VETERINARIA' and attivita ilike 'PRIVATO' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = 'C' , vam = true, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'STRUTTURE VETERINARIE' and aggregazione ilike 'CLINICA VETERINARIA - CASA DI CURA VETERINARIA' and attivita ilike 'PUBBLICO' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = 'L' , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'STRUTTURE VETERINARIE' and aggregazione ilike 'LABORATORIO VETERINARIO DI ANALISI' and attivita ilike 'LABORATORIO VETERINARIO DI ANALISI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = 'O' , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'STRUTTURE VETERINARIE' and aggregazione ilike 'OSPEDALE VETERINARIO' and attivita ilike 'PRIVATO' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = 'O' , vam = true, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'STRUTTURE VETERINARIE' and aggregazione ilike 'OSPEDALE VETERINARIO' and attivita ilike 'PUBBLICO' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = 'S' , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'STRUTTURE VETERINARIE' and aggregazione ilike 'STUDIO VETERINARIO' and attivita ilike 'CON ACCESSO DI ANIMALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = 'S' , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'STRUTTURE VETERINARIE' and aggregazione ilike 'STUDIO VETERINARIO' and attivita ilike 'SENZA ACCESSO DI ANIMALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = 'TC09', sinac_codice_struttura_veterinaria = null , vam = false, bdu = true, bdu_canile = true, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CANILI/STRUTTURE DI DETENZIONE ANIMALI D''AFFEZIONE' and attivita ilike 'CENTRO ADDESTRAMENTO' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = 'TC03', sinac_codice_struttura_veterinaria = null , vam = false, bdu = true, bdu_canile = true, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CANILI/STRUTTURE DI DETENZIONE ANIMALI D''AFFEZIONE' and attivita ilike 'ALLEVAMENTO DI ALTRI ANIMALI D''AFFEZIONE' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = 'TC03', sinac_codice_struttura_veterinaria = null , vam = false, bdu = true, bdu_canile = true, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CANILI/STRUTTURE DI DETENZIONE ANIMALI D''AFFEZIONE' and attivita ilike 'ALLEVAMENTO CANI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = 'TC03', sinac_codice_struttura_veterinaria = null , vam = false, bdu = true, bdu_canile = true, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CANILI/STRUTTURE DI DETENZIONE ANIMALI D''AFFEZIONE' and attivita ilike 'ALLEVAMENTO GATTI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = 'TC10', sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CANILI/STRUTTURE DI DETENZIONE ANIMALI D''AFFEZIONE' and attivita ilike 'AREA DEGENZA' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = 'TC07', sinac_codice_struttura_veterinaria = null , vam = false, bdu = true, bdu_canile = true, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CANILI/STRUTTURE DI DETENZIONE ANIMALI D''AFFEZIONE' and attivita ilike 'PENSIONE' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = 'TC01', sinac_codice_struttura_veterinaria = null , vam = false, bdu = true, bdu_canile = true, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CANILI/STRUTTURE DI DETENZIONE ANIMALI D''AFFEZIONE' and attivita ilike 'RIFUGIO-RICOVERO' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = 'TC02', sinac_codice_struttura_veterinaria = null , vam = false, bdu = true, bdu_canile = true, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CANILI/STRUTTURE DI DETENZIONE ANIMALI D''AFFEZIONE' and attivita ilike 'RIFUGIO SANITARIO' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CIMITERI PER ANIMALI DA COMPAGNIA' and attivita ilike 'CIMITERI PER ANIMALI DA COMPAGNIA' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CENTRI NON SPECIALIZZATI PER INTERVENTI ASSISTITI CON GLI ANIMALI (I)' and attivita ilike 'ATTIVITA ASSISTITA (AAA) CON ANIMALI RESIDENZIALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CENTRI NON SPECIALIZZATI PER INTERVENTI ASSISTITI CON GLI ANIMALI (I)' and attivita ilike 'ATTIVITA ASSISTITA (AAA) SENZA ANIMALI RESIDENZIALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CENTRI NON SPECIALIZZATI PER INTERVENTI ASSISTITI CON GLI ANIMALI (I)' and attivita ilike 'EDUCAZIONE ASSISTITA (EAA) CON ANIMALI RESIDENZIALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CENTRI NON SPECIALIZZATI PER INTERVENTI ASSISTITI CON GLI ANIMALI (I)' and attivita ilike 'EDUCAZIONE ASSISTITA (EAA) SENZA ANIMALI RESIDENZIALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CENTRI NON SPECIALIZZATI PER INTERVENTI ASSISTITI CON GLI ANIMALI (I)' and attivita ilike 'TERAPIA ASSISTITA (TAA) CON ANIMALI RESIDENZIALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CENTRI NON SPECIALIZZATI PER INTERVENTI ASSISTITI CON GLI ANIMALI (I)' and attivita ilike 'TERAPIA ASSISTITA (TAA) SENZA ANIMALI RESIDENZIALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = 'TC06', sinac_codice_struttura_veterinaria = null , vam = false, bdu = true, bdu_canile = false, bdu_operatore_commerciale = true where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CANILI/STRUTTURE DI DETENZIONE ANIMALI D''AFFEZIONE' and attivita ilike 'COMMERCIO AL DETTAGLIO ANIMALI D''AFFEZIONE' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = 'TC06', sinac_codice_struttura_veterinaria = null , vam = false, bdu = true, bdu_canile = false, bdu_operatore_commerciale = true where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CANILI/STRUTTURE DI DETENZIONE ANIMALI D''AFFEZIONE' and attivita ilike 'COMMERCIO ALL''INGROSSO ANIMALI D''AFFEZIONE IN LOCALI CON SUPERFICIE TOTALE LORDA COMPRENSIVA DI SERVIZI E DEPOSITI INFERIORE A 400 MQ' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = 'TC06', sinac_codice_struttura_veterinaria = null , vam = false, bdu = true, bdu_canile = false, bdu_operatore_commerciale = true where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CANILI/STRUTTURE DI DETENZIONE ANIMALI D''AFFEZIONE' and attivita ilike 'COMMERCIO ALL''INGROSSO ANIMALI D''AFFEZIONE IN LOCALI CON SUPERFICIE TOTALE LORDA COMPRENSIVA DI SERVIZI E DEPOSITI SUPERIORE A 400 MQ' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CENTRI SPECIALIZZATI PER INTERVENTI ASSISTITI CON GLI ANIMALI (IAA)' and attivita ilike 'ATTIVITA ASSISTITA (AAA) CON ANIMALI RESIDENZIALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CENTRI SPECIALIZZATI PER INTERVENTI ASSISTITI CON GLI ANIMALI (IAA)' and attivita ilike 'ATTIVITA ASSISTITA (AAA) SENZA ANIMALI RESIDENZIALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CENTRI SPECIALIZZATI PER INTERVENTI ASSISTITI CON GLI ANIMALI (IAA)' and attivita ilike 'EDUCAZIONE ASSISTITA (EAA) CON ANIMALI RESIDENZIALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CENTRI SPECIALIZZATI PER INTERVENTI ASSISTITI CON GLI ANIMALI (IAA)' and attivita ilike 'EDUCAZIONE ASSISTITA (EAA) SENZA ANIMALI RESIDENZIALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CENTRI SPECIALIZZATI PER INTERVENTI ASSISTITI CON GLI ANIMALI (IAA)' and attivita ilike 'TERAPIA ASSISTITA (TAA) CON ANIMALI RESIDENZIALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'CENTRI SPECIALIZZATI PER INTERVENTI ASSISTITI CON GLI ANIMALI (IAA)' and attivita ilike 'TERAPIA ASSISTITA (TAA) SENZA ANIMALI RESIDENZIALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = false, sinac_codice_struttura_detenzione = null, sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'MOSTRA, FIERA O EVENTO A CARATTERE TEMPORANEO CON PRESENZA DI ANIMALI' and attivita ilike 'MOSTRA, FIERA O EVENTO A CARATTERE TEMPORANEO CON PRESENZA DI ANIMALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = 'TC17', sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'TOELETTATURA ANIMALI' and attivita ilike 'TOELETTATURA ANIMALI' and rev = 11) and rev = 11; 
update master_list_flag_linee_attivita set sinac = true, sinac_codice_struttura_detenzione = 'TC17', sinac_codice_struttura_veterinaria = null , vam = false, bdu = false, bdu_canile = false, bdu_operatore_commerciale = false where trashed is null and id_linea = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where enabled and macroarea ilike 'IGIENE URBANA VETERINARIA' and aggregazione ilike 'ATTIVITA'' DI TOELETTATURA ITINERANTE' and attivita ilike 'ATTIVITA'' DI TOELETTATURA ITINERANTE' and rev = 11) and rev = 11; 



--STORICO CHIAMATE VERSO SINAC e BDU/VAM
--db storico
alter table gisa_ws_storico_chiamate add column tabella text;
alter table gisa_ws_storico_chiamate add column esito text;
alter table gisa_ws_storico_chiamate add column id_tabella text;
alter table gisa_ws_storico_chiamate add column metodo text;


--db gisa
CREATE OR REPLACE FUNCTION public.ws_salva_storico_chiamate(
    _url text,
    _request text,
    _response text,
    _idutente integer,
    id_tabella_input text default null,
    tabella_input text default null,
    esito_input text default null,
    metodo_input text default null
    )
  RETURNS json AS
$BODY$
   DECLARE
   	conf_dblink text;
   	query_upd text;
_id integer;
_output json;
BEGIN

	select * from conf.get_pg_conf('STORICO') into conf_dblink;


SELECT COALESCE(_url, '') into _url;
SELECT COALESCE(_request, '') into _request;
SELECT COALESCE(_response, '') into _response;
SELECT COALESCE(_idutente, -1) into _idutente;

SELECT replace(_request, '''', '''''') into _request;
SELECT replace(_response, '''', '''''') into _response;

_id := (select * FROM dblink(conf_dblink::text, 
'insert into gisa_ws_storico_chiamate(url, request, response, id_utente, data, id_tabella, tabella, esito,metodo) values (''' ||_url||''', '''||_request||''','''||_response||''', '||_idutente ||', now(),' || 
case when id_tabella_input is null then 'null' else '''' || id_tabella_input || '''' end  || ', ' || case when tabella_input is null then 'null' else '''' || tabella_input || '''' end || ',' || case when esito_input is null then 'null' else '''' || esito_input || '''' end || ', ' || 
case when metodo_input is null then 'null' else '''' || metodo_input || '''' end || ') returning id;')  as t1(output integer));

query_upd := concat ('update ',tabella_input,' set sinaaf_invio_ws_ok = now() where id = ' , id_tabella_input);

raise info 'query_upd: %' , query_upd;

execute query_upd;


_output:= (select * FROM dblink(conf_dblink::text, 
'SELECT row_to_json (gisa_ws_storico_chiamate) from gisa_ws_storico_chiamate where id = '||_id||';') as t1(output json));

return _output;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.ws_salva_storico_chiamate(text, text, text, integer)
  OWNER TO postgres;


--db storico
CREATE TABLE public.gisa_bdu_storico_chiamate (
id serial4 NOT NULL,
url varchar NULL,
request_dbi varchar NULL,
id_utente integer,
response varchar NULL,
"data" timestamp NULL,
id_tabella varchar NULL,
tabella varchar NULL,
caller varchar NULL,
endpoint varchar NULL,
esito varchar NULL
);

CREATE TABLE public.gisa_vam_storico_chiamate (
id serial4 NOT NULL,
url varchar NULL,
request_dbi varchar NULL,
id_utente integer,
response varchar NULL,
"data" timestamp NULL,
id_tabella varchar NULL,
tabella varchar NULL,
caller varchar NULL,
endpoint varchar NULL,
esito varchar NULL
);

--db gisa
CREATE OR REPLACE FUNCTION public.gisa_bdu_salva_storico_chiamate(
    url_input text,
    _request text,
    _response text,
    _idutente integer,
    id_tabella_input text default null,
    tabella_input text default null,
    esito_input text default null,
    caller_ text default null, 
    endpoint_ text default null    
    )
	RETURNS json AS
$BODY$
   DECLARE
   	conf_dblink text;
_id integer;
_output json;
query_upd text;
BEGIN

	select * from conf.get_pg_conf('STORICO') into conf_dblink;


SELECT COALESCE(url_input, '') into url_input;
SELECT COALESCE(_request, '') into _request;
SELECT COALESCE(_response, '') into _response;
SELECT COALESCE(_idutente, -1) into _idutente;

SELECT replace(_request, '''', '''''') into _request;
SELECT replace(_response, '''', '''''') into _response;

_id := (select * FROM dblink(conf_dblink::text, 
'insert into gisa_bdu_storico_chiamate(url, request_dbi , response, data, id_utente, id_tabella, tabella, esito, caller,endpoint) values ('''||url_input||''', '''||_request||''', 
'''||_response||''', now(), '||_idutente ||', ''' || id_tabella_input || ''', ''' || tabella_input || ''',''' || esito_input || ''',''' || caller_ || ''', ''' || endpoint_   || ''') returning id;')  as t1(output integer));


query_upd := concat ('update ',tabella_input,' set bdu_invio_ok = now() where id = ' , id_tabella_input);

raise info 'query_upd: %' , query_upd;
 execute query_upd;

_output:= (select * FROM dblink('host=dbSTORICOL dbname=storico'::text, 
'SELECT row_to_json (gisa_bdu_storico_chiamate) from gisa_bdu_storico_chiamate where id = '||_id||';') as t1(output json));

return _output;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.ws_salva_storico_chiamate(text, text, text, integer)
  OWNER TO postgres;


CREATE OR REPLACE FUNCTION public.gisa_vam_salva_storico_chiamate(
    url_input text,
    _request text,
    _response text,
    _idutente integer,
    id_tabella_input text default null,
    tabella_input text default null,
    esito_input text default null,
    caller_ text default null, 
    endpoint_ text  default null   
    )
	RETURNS json AS
$BODY$
   DECLARE
   	conf_dblink text;
   	_url text;
_id integer;
_output json;
query_upd text;
BEGIN

	select * from conf.get_pg_conf('STORICO') into conf_dblink;


SELECT COALESCE(url_input, '') into _url;
SELECT COALESCE(_request, '') into _request;
SELECT COALESCE(_response, '') into _response;
SELECT COALESCE(_idutente, -1) into _idutente;

SELECT replace(_request, '''', '''''') into _request;
SELECT replace(_response, '''', '''''') into _response;

_id := (select * FROM dblink(conf_dblink::text, 
'insert into gisa_vam_storico_chiamate(url, request_dbi , response, data, id_utente, id_tabella, tabella, esito, caller,endpoint) values ('''||_url||''', '''||_request||''', 
'''||_response||''', now(), '||_idutente ||',''' || id_tabella_input || ''',''' || tabella_input || ''','''  || esito_input || ''',''' || caller_ || ''', ''' || endpoint_   || ''') returning id;')  as t1(output integer));


query_upd := concat ('update ',tabella_input,' set vam_invio_ok = now() where id = ' , id_tabella_input);

raise info 'query_upd: %' , query_upd;
 execute query_upd;
 
_output:= (select * FROM dblink('host=dbSTORICOL dbname=storico'::text, 
'SELECT row_to_json (gisa_vam_storico_chiamate) from gisa_vam_storico_chiamate where id = '||_id||';') as t1(output json));

return _output;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.ws_salva_storico_chiamate(text, text, text, integer)
  OWNER TO postgres;





--FUNZIONI DI COOPERAZIONE GISA-SINAC
--su update_stato delle chiamate ws e delle chiamate verso bdu, quando esito= ''OK'' and (metodo is null or upper(ws.metodo) <> ''GET'') --> memorizzare sinaaf_invio_ws_ok o bdu_invio_ok su tabella

CREATE OR REPLACE FUNCTION public.update_stato(
    tabella text,
    id_ws text,
    response json,
    campo_id_sinaaf_da_aggiornare_bdu text,
    valore_id_sinaaf_da_ws text,
    valore_codice_sinaaf_da_ws text)
  RETURNS void AS
$BODY$
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

		
if(tabella = 'struttura' or tabella = 'opu_relazione_stabilimento_linee_produttive')
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
query = concat('update ',tabella,' set ' , campo_id_sinaaf_da_aggiornare_bdu,'=''',valore1::text,''',codice_sinaaf =''',valore2,''' where ',id_tabella1,'::text=''',id_ws,''';');
end if;


 RAISE NOTICE 'string: %', query;


execute query;	
	END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.update_stato(text, text, json, text, text, text)
  OWNER TO postgres;


drop function sinaaf_is_sincronizzato(text,text,text);


--select * from opu_relazione_stabilimento_linee_produttive order by id desc  limit 3
--select * from sinaaf_is_sincronizzato('448506','struttura','id')
CREATE OR REPLACE FUNCTION public.sinaaf_is_sincronizzato(IN _identita text,IN entita text,IN nomeidtabella text)
 RETURNS TABLE(sincronizzato integer, id_sinaaf text, codice_sinaaf text, cancellato boolean, id_sinaaf_secondario text) AS
$BODY$
DECLARE
sincronizzato_return boolean;
id_sinaaf text;
query text;
id_base text;
inviabile boolean;
_idstabilimento integer;
_numero_scheda_da_valutare text;
 begin

 inviabile := true;

 
 if (entita = 'struttura') then
 entita = 'opu_relazione_stabilimento_linee_produttive';
 select id_stabilimento into _idstabilimento from opu_relazione_stabilimento_linee_produttive orslp  where orslp.id =_identita::integer;


 
_numero_scheda_da_valutare:=(
select case when flag.sinac_codice_struttura_detenzione is not null then '164' else '165' end 
from opu_relazione_stabilimento_linee_produttive rel  
join ml8_linee_attivita_nuove_materializzata linee  on linee.id_nuova_linea_attivita = rel.id_linea_produttiva   
join master_list_flag_linee_attivita flag on flag.id_linea = rel.id_linea_produttiva and flag.sinac and flag.rev = linee.rev
where rel.trashed_date is null and rel.enabled and rel.id =  _identita::integer  
limit 1);



 select entered is not null into inviabile from schede_supplementari.get_scheda_supplementare(_idstabilimento, 'opu_stabilimento', _identita::integer, _numero_scheda_da_valutare);
end if;

if(inviabile is null) then
	inviabile := false;
end if;

query := '  select (
           (id_sinaaf is not null or codice_sinaaf is not null) and 
           (
             (t1.sinaaf_invio_ws_ok is not null and t1.sinaaf_invio_ws_ok >= GREATEST (t1.modified_sinaaf,trashed_date)) or
             (t1.sinaaf_estrazione_invio_pregresso_ok is not null and t1.sinaaf_estrazione_invio_pregresso_ok >= GREATEST (t1.modified_sinaaf,trashed_date))
           )
          ),id_sinaaf,codice_sinaaf, t1.trashed_date is not null as cancellato from ' || entita || ' as t1 where t1.' || nomeidtabella || '::text = ''' || _identita || '''';
raise info 'query costruita per verificare if entita is sincronizzato: %', query;
EXECUTE query INTO  sincronizzato_return,id_sinaaf,codice_sinaaf,cancellato;
if sincronizzato_return is null then sincronizzato_return:=false; end if;
RETURN QUERY     
select case when sincronizzato_return then 0 when sincronizzato_return is false and inviabile then 1 when sincronizzato_return is false and inviabile is false then 2 end  ,id_sinaaf,codice_sinaaf,cancellato,'';    
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.sinaaf_is_sincronizzato(text, text, text)
  OWNER TO postgres;


CREATE OR REPLACE FUNCTION public.sinaaf_is_linea_bloccata(IN _identita text, IN _entita text, IN nomeidtabella text)
 RETURNS  boolean AS
$BODY$
DECLARE
bloccato_return boolean;
id_rel_stab_lp integer;
 begin

 for 
id_rel_stab_lp
 IN
select id 
from opu_relazione_stabilimento_linee_produttive rel 
where rel.id_stabilimento=_identita::integer and enabled and trashed_date is null

LOOP
	
	bloccato_return := (select sincronizzato =2 from sinaaf_is_sincronizzato( id_rel_stab_lp::text , _entita , nomeidtabella )  ) and   (select * from sinaaf_get_propagabilita( id_rel_stab_lp::text , _entita  )  );

	if(bloccato_return) then
		return true;
	end if;
	

END LOOP;

return false;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.sinaaf_is_linea_bloccata(text,text,text)
  OWNER TO postgres;






--select * from sinaaf_get_step_allineamento_entita('434791@struttura',null,1,null,'true') order by step desc;
--select * from sinaaf_get_step_allineamento_entita('296943@proprietario',null,2,'434791@struttura','false');

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
elsif(id_sinaaf_return is not null and id_sinaaf_return <> '') then
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

--select * from sinaaf_get_info_ws('448506','struttura')
CREATE OR REPLACE FUNCTION public.sinaaf_get_info_ws(
    IN _identita text,
    IN entita text,
    IN method text DEFAULT NULL::text)
  RETURNS TABLE(propagazione_sinaaf boolean, nome_ws text, dbi_get_envelope text, id_tabella text, tabella text, dipendenze text, nome_campo_id_sinaaf text, presente_in_gisa text, sincronizzato boolean, id_sinaaf text, nome_campo_codice_sinaaf_get text, nome_campo_codice_sinaaf text, codice_sinaaf text, cancellato boolean, codice_semantico text) AS
$BODY$
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
sincronizzato_to_return integer;
id_sinaaf_to_return text;
id_sinaaf_secondario_to_return text;
codice_sinaaf_to_return text;
_id_proprietario text;
_controllo_detentore_cambiato boolean;
cancellato_return boolean;
codice_semantico_to_return text;
_cambio_proprietario boolean;

id_persona text;
propagazione_struttura_detenzione boolean;
 BEGIN
propagazione_sinaaf_return:=false;
sincronizzato_to_return:=1;




if(entita='struttura')then
propagazione_struttura_detenzione:=(
select flag.sinac_codice_struttura_detenzione is not null 
from opu_relazione_stabilimento_linee_produttive rel  
join ml8_linee_attivita_nuove_materializzata linee  on linee.id_nuova_linea_attivita = rel.id_linea_produttiva   
join master_list_flag_linee_attivita flag on flag.id_linea = rel.id_linea_produttiva and flag.sinac and flag.rev = linee.rev
where rel.trashed_date is null and rel.enabled and rel.id =  _identita::integer  
limit 1);


id_tabella_return:='id';
tabella_return:='opu_relazione_stabilimento_linee_produttive';
propagazione_sinaaf_return:=true;
nome_ws_return:='canile';
nome_campo_id_sinaaf_return:='canId';
nome_campo_codice_sinaaf_get_return:='cancodice';
nome_campo_codice_sinaaf_return:='canCodice';
dbi_get_envelope_return:='sinaaf_strutture_detenzione_get_envelope';
if(propagazione_struttura_detenzione is false) then
	nome_ws_return:='ente';
	nome_campo_id_sinaaf_return:='entId';
	nome_campo_codice_sinaaf_get_return:='entcodice';
	nome_campo_codice_sinaaf_return:='entCodice';
	dbi_get_envelope_return:='sinaaf_strutture_veterinarie_get_envelope';
end if;

select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
select orosf.id_soggetto_fisico into id_persona from opu_relazione_stabilimento_linee_produttive orslp join opu_stabilimento os on orslp.id_stabilimento=os.id join opu_rel_operatore_soggetto_fisico orosf on os.id_operatore = orosf.id_operatore where orslp.id =  _identita::integer;
dipendenze_return := concat(dipendenze_return, id_persona,';proprietario');
if(propagazione_struttura_detenzione is false or (select upper(nome) from opu_soggetto_fisico where id = id_persona::integer)='DIRETTORE GENERALE ASL') then
	dipendenze_return := null;
end if;
end if;




if(entita='proprietario') then
id_tabella_return:='id';
tabella_return:='opu_soggetto_fisico';
 if(select flag.sinac 
from opu_relazione_stabilimento_linee_produttive rel  
join opu_stabilimento stab on stab.id = rel.id_stabilimento and stab.trashed_date is null 
join opu_rel_operatore_soggetto_fisico rel_sogg on rel_sogg.id_operatore=stab.id_operatore and rel_sogg.id_soggetto_fisico =  _identita::integer  
join ml8_linee_attivita_nuove_materializzata linee  on linee.id_nuova_linea_attivita = rel.id_linea_produttiva   
join master_list_flag_linee_attivita flag on flag.id_linea = rel.id_linea_produttiva and flag.sinac and flag.rev = linee.rev
where rel.trashed_date is null and rel.enabled
limit 1) then
propagazione_sinaaf_return:=true;
nome_ws_return:='persona';
nome_campo_id_sinaaf_return:='perId';
                        nome_campo_codice_sinaaf_get_return:='idfiscale';
nome_campo_codice_sinaaf_return:='perIdFiscale';
dbi_get_envelope_return:='sinaaf_persone_get_envelope';
--codice_semantico_to_return:= (select codice_fiscale from opu_operatori_denormalizzati where id_rel_stab_lp = _identita::integer);
select * into sincronizzato_to_return, id_sinaaf_to_return,codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
elsif(_id_linea_produttiva=8) then
propagazione_sinaaf_return:=true;
nome_ws_return:='canile';
nome_campo_id_sinaaf_return:='canId';
nome_campo_codice_sinaaf_get_return:='cancodice';
nome_campo_codice_sinaaf_return:='canCodice';
dbi_get_envelope_return:='sinaaf_colonie_get_envelope';
select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
elsif(false) then
               --elsif(_id_linea_produttiva in (4,5,6)) then
propagazione_sinaaf_return:=true;
nome_ws_return:='canile';
nome_campo_id_sinaaf_return:='canId';
nome_campo_codice_sinaaf_get_return:='cancodice';
nome_campo_codice_sinaaf_return:='canCodice';
dbi_get_envelope_return:='sinaaf_strutture_detenzione_get_envelope';
select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
end if;
end if;

if(entita='veterinari') then
nome_campo_id_sinaaf_return:='vetIdFiscale';
                nome_campo_codice_sinaaf_get_return:='vetidfiscale';
nome_ws_return:='veterinario';
        end if;


   RETURN QUERY     
select propagazione_sinaaf_return,nome_ws_return,dbi_get_envelope_return,id_tabella_return,tabella_return,dipendenze_return, nome_campo_id_sinaaf_return, presente_in_gisa_return,sincronizzato_to_return = 0,coalesce(id_sinaaf_to_return,id_sinaaf_secondario_to_return),nome_campo_codice_sinaaf_get_return,nome_campo_codice_sinaaf_return, codice_sinaaf_to_return, cancellato_return, codice_semantico_to_return;    
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.sinaaf_get_info_ws(text, text, text)
  OWNER TO postgres;



--select * from sinaaf_get_propagabilita('448509','struttura')
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

if(entita='struttura') then
select id_linea_produttiva into _id_linea_produttiva from opu_relazione_stabilimento_linee_produttive where  id::text = _identita;
if(select sinac from master_list_flag_linee_attivita where id_linea = _id_linea_produttiva )then
propagazione_sinaaf_return:=true; 
end if;
end if;


        RETURN propagazione_sinaaf_return;   
 END;
$function$
;



CREATE OR REPLACE FUNCTION public.sinaaf_bdu_get_propagabilita(_identita text, entita text)
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

if(entita='struttura') then
propagazione_sinaaf_return:=(select bdu or sinac or vam sinac from master_list_flag_linee_attivita where id_linea in (select id_linea_produttiva from opu_relazione_stabilimento_linee_produttive  where id_stabilimento =  _identita::integer) and  (bdu or sinac) limit 1);
end if;


        RETURN (propagazione_sinaaf_return is not null and propagazione_sinaaf_return);   
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



--FUNZIONI DI DOMINIO PER COOPERAZIONE GISA-SINAC

--select * from sinaaf_persone_get_dati_envelope('296943')
DROP FUNCTION public.sinaaf_persone_get_dati_envelope(integer, text);

CREATE OR REPLACE FUNCTION public.sinaaf_persone_get_dati_envelope(IN _idproprietario text)
  RETURNS TABLE(perid text, percognome text, pernome text, perragionesociale text, peridfiscale text, tipoidfiscale text, perflagtipologia text, perdtnascita text, nascitacomistat text, nascitaprosigla text, 
                nascitastatoisocode text, perindirizzo text, comistat text, prosigla text, comcap text, Localita text,
                domperindirizzo text, domcomistat text, domprosigla text, domcomcap text, domLocalita text, pernumtelfisso text, pernumtelmobile text, permail text, 
		perNote text, flagPatentino text, patentini text, perTipoDocumento text, perNumDocumento text, dtScadenzaDocum text,
                dtaccprivacy text, flagconsenservizi text, dtconsensoservizi text) AS
$BODY$

 begin

    
   RETURN QUERY     
select sogg.id_sinaaf::text as perId, 
sogg.cognome as perCognome,
sogg.nome as perNome,
'' as perRagioneSociale,
case
when naz.codice_iso_alpha2 = 'IT' then sogg.codice_fiscale::text
when naz.codice_iso_alpha2 is not null and naz.codice_iso_alpha2 != 'IT' then sogg.codice_fiscale::text
when (naz.codice_iso_alpha2 is null and _cf_check_char("substring"(sogg.codice_fiscale, 1, 15)) = substring(sogg.codice_fiscale, 16, 16))  then sogg.codice_fiscale::text
else ''
end as perIdFiscale,
case
when naz.codice_iso_alpha2 = 'IT' then 'I'
when naz.codice_iso_alpha2 is not null and naz.codice_iso_alpha2 != 'IT' then 'E'
when (naz.codice_iso_alpha2 is null and _cf_check_char("substring"(sogg.codice_fiscale, 1, 15)) = substring(sogg.codice_fiscale, 16, 16))  then 'I'
else 'N'
end as tipoIdFiscale,
'F' as perFlagTipologia,
coalesce(to_char(sogg.data_nascita, 'dd-mm-yyyy'), '')::text as perDtNascita,
com_nascita.cod_comune::text as nascitaComIstat,
upper(prov_nascita.cod_provincia)::text as nascitaProSigla,
coalesce(naz.codice_iso_alpha2,'')::text as nascitaStatoIsoCode,
regexp_replace(public.unaccent(coalesce(ind.via, '') ),'[\°\\''\²\/]',' ','g') as perIndirizzo, 
com_residenza.cod_comune::text as comIstat,
upper(prov_residenza.cod_provincia)::text as proSigla ,
case when ind.cap::text not ilike '%n.d%' then ind.cap::text else com_residenza.cap::text end as comCap ,
'' as Localita,
regexp_replace(public.unaccent(coalesce(ind.via, '') ),'[\°\\''\²\/]',' ','g') as domPerIndirizzo, 
com_residenza.cod_comune::text as domComIstat ,
upper(prov_residenza.cod_provincia)::text as domProSigla ,
case when ind.cap::text not ilike '%n.d%' then ind.cap::text else com_residenza.cap::text end as domComCap ,
'' as domLocalita,
coalesce(sogg.telefono,sogg.telefono,'N.D.')::text as perNumTelFisso ,
coalesce(sogg.telefono1,sogg.telefono1,'N.D.')::text as perNumTelMobile,
sogg.email::text as perMail ,
'' as perNote , '' as flagPatentino, '' as patentini, '' as perTipoDocumento, '' as perNumDocumento, '' as dtScadenzaDocum,
coalesce(to_char(current_timestamp, 'dd-mm-yyyy'), '')::text as dtAccPrivacy ,
'S' as flagConsenServizi,
coalesce(to_char(current_timestamp, 'dd-mm-yyyy'), '')::text as dtConsensoServizi
from opu_soggetto_fisico sogg
left join comuni1 com_nascita on com_nascita.nome ilike sogg.comune_nascita
left join lookup_province prov_nascita ON prov_nascita.code::integer = com_nascita.cod_provincia::integer
left join opu_indirizzo ind on ind.id = sogg.indirizzo_id 
left join comuni1 com_residenza on com_residenza.id = ind.comune
left join lookup_province prov_residenza ON prov_residenza.code::integer = com_residenza.cod_provincia::integer
left join sinaaf_nazioni_codici_iso naz on ind.nazione ilike naz.denominazione_it  or (_cf_check_char("substring"(sogg.codice_fiscale, 1, 15)) = substring(sogg.codice_fiscale, 16, 16) and SUBSTRING(sogg.codice_fiscale,12,4) ilike naz.codice_at)
where sogg.trashed_date is null and (sogg.id = _idproprietario::integer)  ; 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.sinaaf_persone_get_dati_envelope(text)
  OWNER TO postgres;



         
DROP FUNCTION public.sinaaf_persone_get_envelope(text);

CREATE OR REPLACE FUNCTION public.sinaaf_persone_get_envelope(_idproprietario text)
  RETURNS text AS
$BODY$
DECLARE
ret text;
BEGIN


select 
concat('{"perId": "', perId,
'","perCognome": "', perCognome, 
'","perNome": "', perNome, 
'","perRagioneSociale": "', perragionesociale, 
'","perIdFiscale": "', perIdFiscale, 
'","tipoIdFiscale": "', tipoIdFiscale, 
'","perFlagTipologia": "', perFlagTipologia, 
'","perDtNascita": "', perDtNascita, 
'","nascitaComIstat": "', nascitaComIstat, 
'","nascitaProSigla": "', nascitaProSigla, 
'","nascitaStatoIsoCode": "', nascitaStatoIsoCode, 
'","perIndirizzo": "', perIndirizzo, 
'","comIstat": "', comIstat, 
'","proSigla": "', proSigla, 
'","comCap": "', comCap, 
'","Localita": "', Localita, 
'","domPerIndirizzo": "', domPerIndirizzo, 
'","domComIstat": "', domComIstat, 
'","domProSigla": "', domProSigla, 
'","domComCap": "', domComCap,  
'","domLocalita": "', domLocalita, 
'","perNumTelFisso": "', perNumTelFisso, 
'","perNumTelMobile": "', perNumTelMobile, 
'","perMail": "', perMail, 
'","perNote": "', perNote, 
'","flagPatentino": "', flagPatentino,
'","patentini": "', patentini,
'","perTipoDocumento": "', perTipoDocumento,
'","perNumDocumento": "', perNumDocumento,
'","dtScadenzaDocum": "', dtScadenzaDocum,
'","dtAccPrivacy": "', dtAccPrivacy,
'","flagConsenServizi": "', flagConsenServizi,
'","dtConsensoServizi": "', dtConsensoServizi,'"}') into ret

from sinaaf_persone_get_dati_envelope(_idproprietario);


 RETURN ret;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100;
ALTER FUNCTION public.sinaaf_persone_get_envelope(text)
  OWNER TO postgres;



drop table sinaaf_nazioni_codici_iso;

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



INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Italia', 'n.d.', 'IT', 'ITA', 1, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Andorra', 'Z101', 'AD', 'AND', 2, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Albania', 'Z100', 'AL', 'ALB', 3, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Austria', 'Z102', 'AT', 'AUT', 4, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Belgio', 'Z103', 'BE', 'BEL', 5, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Bulgaria', 'Z104', 'BG', 'BGR', 6, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Danimarca', 'Z107', 'DK', 'DNK', 7, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Finlandia', 'Z109', 'FI', 'FIN', 8, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Francia', 'Z110', 'FR', 'FRA', 9, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Germania', 'Z112', 'DE', 'DEU', 10, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Grecia', 'Z115', 'GR', 'GRC', 12, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Irlanda', 'Z116', 'IE', 'IRL', 13, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Islanda', 'Z117', 'IS', 'ISL', 14, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Liechtenstein', 'Z119', 'LI', 'LIE', 15, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Lussemburgo', 'Z120', 'LU', 'LUX', 16, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Malta', 'Z121', 'MT', 'MLT', 17, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Monaco', 'Z123', 'MC', 'MCO', 18, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Norvegia', 'Z125', 'NO', 'NOR', 19, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Paesi Bassi', 'Z126', 'NL', 'NLD', 20, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Polonia', 'Z127', 'PL', 'POL', 21, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Portogallo', 'Z128', 'PT', 'PRT', 22, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Romania', 'Z129', 'RO', 'ROU', 23, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('San Marino', 'Z130', 'SM', 'SMR', 24, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Spagna', 'Z131', 'ES', 'ESP', 25, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Svezia', 'Z132', 'SE', 'SWE', 26, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Svizzera', 'Z133', 'CH', 'CHE', 27, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Ucraina', 'Z138', 'UA', 'UKR', 28, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Ungheria', 'Z134', 'HU', 'HUN', 29, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Stato della Città del Vaticano', 'Z106', 'VA', 'VAT', 31, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Estonia', 'Z144', 'EE', 'EST', 32, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Lettonia', 'Z145', 'LV', 'LVA', 33, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Lituania', 'Z146', 'LT', 'LTU', 34, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Croazia', 'Z149', 'HR', 'HRV', 35, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Slovenia', 'Z150', 'SI', 'SVN', 36, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Bosnia-Erzegovina', 'Z153', 'BA', 'BIH', 37, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Macedonia del Nord', 'Z148', 'MK', 'MKD', 38, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Moldova', 'Z140', 'MD', 'MDA', 39, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Slovacchia', 'Z155', 'SK', 'SVK', 40, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Bielorussia', 'Z139', 'BY', 'BLR', 41, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Montenegro', 'Z159', 'ME', 'MNE', 43, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Serbia', 'Z158', 'RS', 'SRB', 44, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Kosovo', 'Z160', 'n.d.', 'KOS', 45, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Afghanistan', 'Z200', 'AF', 'AFG', 46, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Arabia Saudita', 'Z203', 'SA', 'SAU', 47, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Bahrein', 'Z204', 'BH', 'BHR', 48, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Bangladesh', 'Z249', 'BD', 'BGD', 49, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Bhutan', 'Z205', 'BT', 'BTN', 50, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Myanmar/Birmania', 'Z206', 'MM', 'MMR', 51, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Brunei Darussalam', 'Z207', 'BN', 'BRN', 52, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Cambogia', 'Z208', 'KH', 'KHM', 53, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Sri Lanka', 'Z209', 'LK', 'LKA', 54, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Cina', 'Z210', 'CN', 'CHN', 55, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Cipro', 'Z211', 'CY', 'CYP', 56, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Corea del Nord', 'Z214', 'KP', 'PRK', 57, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Corea del Sud', 'Z213', 'KR', 'KOR', 58, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Emirati Arabi Uniti', 'Z215', 'AE', 'ARE', 59, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Filippine', 'Z216', 'PH', 'PHL', 60, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Palestina', 'Z161', 'PS', 'PSE', 61, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Giappone', 'Z219', 'JP', 'JPN', 62, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Giordania', 'Z220', 'JO', 'JOR', 63, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('India', 'Z222', 'IN', 'IND', 64, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Indonesia', 'Z223', 'ID', 'IDN', 65, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Iran', 'Z224', 'IR', 'IRN', 66, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Iraq', 'Z225', 'IQ', 'IRQ', 67, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Israele', 'Z226', 'IL', 'ISR', 68, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Kuwait', 'Z227', 'KW', 'KWT', 69, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Laos', 'Z228', 'LA', 'LAO', 70, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Libano', 'Z229', 'LB', 'LBN', 71, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Timor Leste', 'Z242', 'TL', 'TLS', 72, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Maldive', 'Z232', 'MV', 'MDV', 73, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Malaysia', 'Z247', 'MY', 'MYS', 74, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Mongolia', 'Z233', 'MN', 'MNG', 75, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Nepal', 'Z234', 'NP', 'NPL', 76, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Oman', 'Z235', 'OM', 'OMN', 77, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Pakistan', 'Z236', 'PK', 'PAK', 78, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Qatar', 'Z237', 'QA', 'QAT', 79, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Singapore', 'Z248', 'SG', 'SGP', 80, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Siria', 'Z240', 'SY', 'SYR', 81, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Thailandia', 'Z241', 'TH', 'THA', 82, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Turchia', 'Z243', 'TR', 'TUR', 83, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Vietnam', 'Z251', 'VN', 'VNM', 84, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Yemen', 'Z246', 'YE', 'YEM', 85, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Kazakhstan', 'Z255', 'KZ', 'KAZ', 86, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Uzbekistan', 'Z259', 'UZ', 'UZB', 87, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Armenia', 'Z252', 'AM', 'ARM', 88, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Azerbaigian', 'Z253', 'AZ', 'AZE', 89, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Georgia', 'Z254', 'GE', 'GEO', 90, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Kirghizistan', 'Z256', 'KG', 'KGZ', 91, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Tagikistan', 'Z257', 'TJ', 'TJK', 92, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Taiwan', 'Z217', 'TW', 'TWN', 93, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Turkmenistan', 'Z258', 'TM', 'TKM', 94, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Algeria', 'Z301', 'DZ', 'DZA', 95, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Angola', 'Z302', 'AO', 'AGO', 96, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Costa d''Avorio', 'Z313', 'CI', 'CIV', 97, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Benin', 'Z314', 'BJ', 'BEN', 98, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Botswana', 'Z358', 'BW', 'BWA', 99, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Burkina Faso', 'Z354', 'BF', 'BFA', 100, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Burundi', 'Z305', 'BI', 'BDI', 101, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Camerun', 'Z306', 'CM', 'CMR', 102, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Capo Verde', 'Z307', 'CV', 'CPV', 103, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Repubblica Centrafricana', 'Z308', 'CF', 'CAF', 104, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Russia', 'Z154', 'RU', 'RUS', 30, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Repubblica ceca', 'Z156', 'CZ', 'CZE', 42, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Regno Unito', 'Z114', 'GB', 'GBR', 11, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Ciad', 'Z309', 'TD', 'TCD', 105, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Comore', 'Z310', 'KM', 'COM', 106, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Congo', 'Z311', 'CG', 'COG', 107, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Egitto', 'Z336', 'EG', 'EGY', 108, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Etiopia', 'Z315', 'ET', 'ETH', 109, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Gabon', 'Z316', 'GA', 'GAB', 110, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Gambia', 'Z317', 'GM', 'GMB', 111, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Ghana', 'Z318', 'GH', 'GHA', 112, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Gibuti', 'Z361', 'DJ', 'DJI', 113, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Guinea', 'Z319', 'GN', 'GIN', 114, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Guinea-Bissau', 'Z320', 'GW', 'GNB', 115, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Guinea equatoriale', 'Z321', 'GQ', 'GNQ', 116, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Kenya', 'Z322', 'KE', 'KEN', 117, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Lesotho', 'Z359', 'LS', 'LSO', 118, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Liberia', 'Z325', 'LR', 'LBR', 119, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Libia', 'Z326', 'LY', 'LBY', 120, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Madagascar', 'Z327', 'MG', 'MDG', 121, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Malawi', 'Z328', 'MW', 'MWI', 122, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Mali', 'Z329', 'ML', 'MLI', 123, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Marocco', 'Z330', 'MA', 'MAR', 124, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Mauritania', 'Z331', 'MR', 'MRT', 125, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Maurizio', 'Z332', 'MU', 'MUS', 126, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Mozambico', 'Z333', 'MZ', 'MOZ', 127, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Namibia', 'Z300', 'NA', 'NAM', 128, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Niger', 'Z334', 'NE', 'NER', 129, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Nigeria', 'Z335', 'NG', 'NGA', 130, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Ruanda', 'Z338', 'RW', 'RWA', 131, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Sao Tomé e Principe', 'Z341', 'ST', 'STP', 132, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Seychelles', 'Z342', 'SC', 'SYC', 133, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Senegal', 'Z343', 'SN', 'SEN', 134, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Sierra Leone', 'Z344', 'SL', 'SLE', 135, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Somalia', 'Z345', 'SO', 'SOM', 136, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Sudafrica', 'Z347', 'ZA', 'ZAF', 137, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Sudan', 'Z348', 'SD', 'SDN', 138, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Eswatini', 'Z349', 'SZ', 'SWZ', 139, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Tanzania', 'Z357', 'TZ', 'TZA', 140, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Togo', 'Z351', 'TG', 'TGO', 141, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Tunisia', 'Z352', 'TN', 'TUN', 142, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Uganda', 'Z353', 'UG', 'UGA', 143, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Repubblica Democratica del Congo', 'Z312', 'CD', 'COD', 144, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Zambia', 'Z355', 'ZM', 'ZMB', 145, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Zimbabwe', 'Z337', 'ZW', 'ZWE', 146, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Eritrea', 'Z368', 'ER', 'ERI', 147, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Sud Sudan', 'Z907', 'SS', 'SSD', 148, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Antigua e Barbuda', 'Z532', 'AG', 'ATG', 149, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Bahamas', 'Z502', 'BS', 'BHS', 150, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Barbados', 'Z522', 'BB', 'BRB', 151, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Belize', 'Z512', 'BZ', 'BLZ', 152, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Canada', 'Z401', 'CA', 'CAN', 153, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Costa Rica', 'Z503', 'CR', 'CRI', 154, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Cuba', 'Z504', 'CU', 'CUB', 155, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Dominica', 'Z526', 'DM', 'DMA', 156, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Repubblica Dominicana', 'Z505', 'DO', 'DOM', 157, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('El Salvador', 'Z506', 'SV', 'SLV', 158, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Giamaica', 'Z507', 'JM', 'JAM', 159, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Grenada', 'Z524', 'GD', 'GRD', 160, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Guatemala', 'Z509', 'GT', 'GTM', 161, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Haiti', 'Z510', 'HT', 'HTI', 162, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Honduras', 'Z511', 'HN', 'HND', 163, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Messico', 'Z514', 'MX', 'MEX', 164, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Nicaragua', 'Z515', 'NI', 'NIC', 165, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Panama', 'Z516', 'PA', 'PAN', 166, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Santa Lucia', 'Z527', 'LC', 'LCA', 167, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Saint Vincent e Grenadine', 'Z528', 'VC', 'VCT', 168, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Saint Kitts e Nevis', 'Z533', 'KN', 'KNA', 169, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Stati Uniti d''America', 'Z404', 'US', 'USA', 170, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Argentina', 'Z600', 'AR', 'ARG', 171, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Bolivia', 'Z601', 'BO', 'BOL', 172, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Brasile', 'Z602', 'BR', 'BRA', 173, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Cile', 'Z603', 'CL', 'CHL', 174, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Colombia', 'Z604', 'CO', 'COL', 175, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Ecuador', 'Z605', 'EC', 'ECU', 176, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Guyana', 'Z606', 'GY', 'GUY', 177, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Paraguay', 'Z610', 'PY', 'PRY', 178, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Perù', 'Z611', 'PE', 'PER', 179, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Suriname', 'Z608', 'SR', 'SUR', 180, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Trinidad e Tobago', 'Z612', 'TT', 'TTO', 181, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Uruguay', 'Z613', 'UY', 'URY', 182, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Venezuela', 'Z614', 'VE', 'VEN', 183, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Australia', 'Z700', 'AU', 'AUS', 184, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Figi', 'Z704', 'FJ', 'FJI', 185, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Kiribati', 'Z731', 'KI', 'KIR', 186, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Isole Marshall', 'Z711', 'MH', 'MHL', 187, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Stati Federati di Micronesia', 'Z735', 'FM', 'FSM', 188, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Nauru', 'Z713', 'NR', 'NRU', 189, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Nuova Zelanda', 'Z719', 'NZ', 'NZL', 190, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Palau', 'Z734', 'PW', 'PLW', 191, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Papua Nuova Guinea', 'Z730', 'PG', 'PNG', 192, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Isole Salomone', 'Z724', 'SB', 'SLB', 193, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Samoa', 'Z726', 'WS', 'WSM', 194, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Tonga', 'Z728', 'TO', 'TON', 195, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Tuvalu', 'Z732', 'TV', 'TUV', 196, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Vanuatu', 'Z733', 'VU', 'VUT', 197, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Nuova Caledonia', 'Z716', 'NC', 'NCL', 198, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Saint-Martin (FR)', 'n.d.', 'MF', 'MAF', 199, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Sahara occidentale', 'Z339', 'EH', 'ESH', 200, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Saint-Barthélemy', 'n.d.', 'BL', 'BLM', 201, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Bermuda', 'Z400', 'BM', 'BMU', 202, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Isole Cook (NZ)', 'Z703', 'CK', 'COK', 203, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Gibilterra', 'Z113', 'GI', 'GIB', 204, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Isole Cayman', 'Z530', 'KY', 'CYM', 205, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Anguilla', 'Z529', 'AI', 'AIA', 206, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Polinesia francese', 'Z723', 'PF', 'PYF', 207, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Isole Fær Øer', 'Z108', 'FO', 'FRO', 208, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Jersey', 'n.d.', 'JE', 'JEY', 209, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Aruba', 'Z501', 'AW', 'ABW', 210, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Sint Maarten (NL)', 'n.d.', 'SX', 'SXM', 211, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Groenlandia', 'Z402', 'GL', 'GRL', 212, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Sark', 'n.d.', 'n.d.', 'n.d.', 213, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Guernsey', 'n.d.', 'GG', 'GGY', 214, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Isole Falkland (Malvine)', 'Z609', 'FK', 'FLK', 215, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Isola di Man', 'Z122', 'IM', 'IMN', 216, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Montserrat', 'Z531', 'MS', 'MSR', 217, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Curaçao', 'n.d.', 'CW', 'CUW', 218, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Isole Pitcairn', 'Z722', 'PN', 'PCN', 219, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Saint Pierre e Miquelon', 'Z403', 'PM', 'SPM', 220, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Sant''Elena', 'Z340', 'SH', 'SHN', 221, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Terre australi e antartiche francesi', 'n.d.', 'TF', 'ATF', 222, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Isole Turks e Caicos', 'Z519', 'TC', 'TCA', 223, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Isole Vergini britanniche', 'Z525', 'VG', 'VGB', 224, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Wallis e Futuna', 'Z729', 'WF', 'WLF', 225, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Bulgaria', 'Z10Q', 'BG', NULL, 304, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Germania', 'Z11N', 'DE', NULL, 307, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Romania', 'Z12V', 'RO', NULL, 308, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Georgia', 'Z136', 'GE', NULL, 310, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Armenia', 'Z137', 'AM', NULL, 311, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Ucraina', 'Z13U', 'UA', NULL, 312, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Azerbaigian', 'Z141', 'AZ', NULL, 313, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Uzbekistan', 'Z143', 'UZ', NULL, 314, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Kazakhstan', 'Z152', 'KZ', NULL, 315, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Unione repubbliche socialiste sovietiche', 'Z135', 'RU', NULL, 309, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Cecoslovacchia', 'Z105', 'CS', NULL, 303, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Iugoslavia', 'Z118', 'YU', NULL, 306, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('GERMANIA - REPUBBLICA DEMOCRATICA', 'Z111', 'DD', NULL, 305, false, 0, true, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Serbia', 'Z157', 'RS', NULL, 316, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Hong kong', 'Z221', 'HK', NULL, 317, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Malaysia', 'Z230', 'MY', NULL, 318, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Yemen', 'Z250', 'YS', NULL, 320, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Pakistan', 'Z2P6', 'PK', NULL, 321, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Marocco', 'Z33L', 'MA', NULL, 322, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Marocco', 'Z3PL', 'MA', NULL, 323, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Puerto rico', 'Z518', 'PR', NULL, 324, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Vergini americane', 'Z520', 'VI', NULL, 325, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Guam ', 'Z706', 'GU', NULL, 326, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Norfolk island', 'Z715', 'NF', NULL, 327, false, 0, false, NULL, NULL);
INSERT INTO public.sinaaf_nazioni_codici_iso (denominazione_it, codice_at, codice_iso_alpha2, codice_iso_alpha3, code, default_item, level, enabled, entered, modified) VALUES ('Vietnam del Sud', 'Z244', 'VNS', 'VNS', 319, false, 0, true, NULL, NULL);

drop function sinaaf_strutture_veterinarie_get_dati_envelope( text);

--select * from sinaaf_strutture_veterinarie_get_dati_envelope('448533');
CREATE OR REPLACE FUNCTION public.sinaaf_strutture_veterinarie_get_dati_envelope(IN _idstruttura text)
  RETURNS TABLE(entid text, entcodice text, entdenominazione text, enttipologia text, entResponsabileIdFiscale text, entrespdtinizio text, comistat text, prosigla text, entindirizzo text, entcap text, 
  entNumDecreto text, entnumtelfisso text, entnumtelmobile text, entNumFax text, entEmail text ,entpartitaiva text, entH24 text , entAreaDegenza text ,entlatitudine text, entlongitudine text, 
  entdtinizioattivita text, entdtfineattivita text, entflagfineattivita text, forzaDuplicato text, aslCodice text, note text) AS
$BODY$

 BEGIN

    
   RETURN QUERY     
select lps.id_sinaaf as entId,
       lps.codice_sinaaf::text as entcodice,
       op.ragione_sociale::text as entDenominazione,
       pp2.sinac_codice_struttura_veterinaria::text as entTipologia,
       --sogg.codice_fiscale::text as entResponsabileIdFiscale,
       _165.cf_veterinario as entResponsabileIdFiscale,
       coalesce(to_char(_165.data_inizio_nomina, 'dd-mm-yyyy'), '')::text as entRespDtInizio,
       com_stab.cod_comune::text as comIstat,
       upper(provsedestab.cod_provincia)::text as proSigla,
       regexp_replace(public.unaccent(coalesce(ind_stab.via, '') ),'[\°\\''\²\/]',' ','g') as entIndirizzo, 
       ind_stab.cap::text as entCap,
       '' as entNumDecreto, 
       _165.telefono_fisso as entNumTelFisso,
       _165.telefono_mobile as entNumTelMobile,
       _165.fax as entNumFax, 
       '' as entEmail,
       op.partita_iva::text as entPartitaIva,
       case when _165.flag_h24 is true then 'S' else 'N' end as entH24, 
       case when _165.flag_area_degenza is true then 'S' else 'N' end as entAreaDegenza,
       substring(ind_stab.latitudine::text,  1, 8)::text as entLatitudine,
       substring(ind_stab.longitudine::text, 1, 8)::text ::text as entLongitudine,
       coalesce(to_char(lps.data_inizio, 'dd-mm-yyyy'), '')::text as entDtInizioAttivita, 
       coalesce(to_char(lps.data_fine, 'dd-mm-yyyy'), '')::text as entDtFineAttivita, 
       case when lps.data_fine is not null then 'C' else null end as entFlagFineAttivita,
       'S' as forzaDuplicato, 
       --('R' || asl.codiceistat)::text as aslCodice,
       '' as aslCodice,
       '' as note 
from opu_operatore op
left join opu_rel_operatore_soggetto_fisico rel_sogg on rel_sogg.id_operatore = op.id and (rel_sogg.enabled or rel_sogg.enabled is null) and (rel_sogg.data_fine is null or rel_sogg.data_fine > current_timestamp)
left join opu_soggetto_fisico sogg on sogg.id = rel_sogg.id_soggetto_fisico 
join opu_stabilimento stab on op.id = stab.id_operatore
left join opu_indirizzo ind_stab on ind_stab.id = stab.id_indirizzo
left join comuni1 com_stab on com_stab.id = ind_stab.comune
left join lookup_province provsedestab ON provsedestab.code::integer = ind_stab.provincia::integer
--left join lookup_site_id asl on asl.code::text = com_stab.codiceistatasl
join opu_relazione_stabilimento_linee_produttive lps on lps.id_stabilimento = stab.id 
left join master_list_flag_linee_attivita pp2 on pp2.id_linea = lps.id_linea_produttiva 
left join (select m.id, trim(unnest(string_to_array(m.scheda_supplementare, ','))) as num_scheda from master_list_linea_attivita m) att on att.id = lps.id_linea_produttiva
left join schede_supplementari.istanze s on s.riferimento_id = stab.id and s.riferimento_id_nome_tab = 'opu_stabilimento' and s.trashed_date is null and s.id_istanza_linea = lps.id and s.num_scheda = '165'
left join schede_supplementari.lookup_schede_supplementari l on l.num_scheda = att.num_scheda
left join schede_supplementari.dati_generici_165 _165 on _165.id_istanza = s.id	
where op.trashed_date is null and lps.id = _idstruttura::integer;   
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.sinaaf_strutture_veterinarie_get_dati_envelope(text)
  OWNER TO postgres;




CREATE OR REPLACE FUNCTION public.sinaaf_strutture_veterinarie_get_envelope(_idstruttura text)
  RETURNS text AS
$BODY$
DECLARE
ret text;
BEGIN
select 
concat('{"entId": "', entid,
'","entCodice": "', entcodice, 
'","entDenominazione": "', entdenominazione,
'","entTipologia": "', enttipologia,
'","entResponsabileIdFiscale": "', entresponsabileidfiscale,
'","entRespDtInizio": "', entRespDtInizio,
'","comIstat": "', comIstat,
'","proSigla": "', proSigla,
'","entIndirizzo": "', entIndirizzo,
'","entCap": "', entCap,
'","entNumDecreto": "', entNumDecreto,
'","entNumTelFisso": "', entNumTelFisso,
'","entNumTelMobile": "', entNumTelMobile,
'","entNumFax": "', entNumFax,
'","entEmail": "', entEmail,
'","entPartitaIva": "', entPartitaIva,
'","entH24": "', entH24,
'","entAreaDegenza": "', entAreaDegenza,
'","entLatitudine": "', entLatitudine,
'","entLongitudine": "', entLongitudine,
'","entDtInizioAttivita": "', entDtInizioAttivita,
'","entDtFineAttivita": "', entDtFineAttivita,
'","entFlagFineAttivita": ', case when entFlagFineAttivita is null then 'null' else '"' || entFlagFineAttivita || '"' end,
',"forzaDuplicato": "', forzaDuplicato,
'","aslCodice": "', aslCodice,
 '", "Note": "', note, '"}') into ret
from sinaaf_strutture_veterinarie_get_dati_envelope(_idstruttura);

 RETURN ret;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100;
ALTER FUNCTION public.sinaaf_strutture_veterinarie_get_envelope(text)
  OWNER TO postgres;



CREATE OR REPLACE FUNCTION public.sinaaf_strutture_detenzione_get_envelope(_idstruttura text)
  RETURNS text AS
$BODY$
DECLARE
ret text;
BEGIN
select 
concat('{"canId": "', canId,
'","canCodice": "', canCodice, 
'","canCodiceRegione": "', canCodiceRegione,
'","canRagioneSociale": "', canRagioneSociale,
'","ticCodice": "', ticCodice,
'","canFlagPrivato": "', canFlagPrivato, 
'","prpIdFiscale": "', prpIdFiscale,
'","canPrpDtInizioAttivita": "', canPrpDtInizioAttivita,
'","prpComIstat": "', prpComIstat,
'","prpProSigla": "', prpProSigla,
'","gesIdFiscale": "', gesIdFiscale,
'","canGesDtInizioAttivita": "', canGesDtInizioAttivita,
'","comIstat": "', comIstat,
'","proSigla": "', proSigla,
'","comCap": "', comCap,
'","canIndirizzo": "', canIndirizzo,
'","canDtRegistrazione": "', canDtRegistrazione,
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
'", "canNumDecreto": "', canNumDecreto, 
'", "flagPresenzaCani": "', flagPresenzaCani, 
'", "flagPresenzaGatti": "', flagPresenzaGatti,
'", "flagPresenzaAltriAnimali": "', flagPresenzaAltriAnimali,
'", "flagStrutturaBloccata": "', flagStrutturaBloccata,
'", "forzaDuplicato": "', forzaDuplicato,
'", "autorizzazioneScorta": "', autorizzazioneScorta,
'", "vetResponsabileScortaIdFiscale": "', vetResponsabileScortaIdFiscale,
'", "numAutorizzazioneScorta": "', numAutorizzazioneScorta,
'", "dtInizioScorta": "', dtInizioScorta,
'","aslCodice": "', aslCodice,
'","note": "', note,'"}') into ret

from sinaaf_strutture_detenzione_get_dati_envelope(_idstruttura);

 RETURN ret;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100;
ALTER FUNCTION public.sinaaf_strutture_detenzione_get_envelope(text)
  OWNER TO postgres;


--sinaaf_strutture_detenzione_get_dati_envelope è da confrontare con la vista che sta dopo
drop function sinaaf_strutture_detenzione_get_dati_envelope( text);

--select * from sinaaf_strutture_detenzione_get_dati_envelope('448506');
CREATE OR REPLACE FUNCTION public.sinaaf_strutture_detenzione_get_dati_envelope(IN _idstruttura text)
  RETURNS TABLE(canid text, cancodice text, cancodiceregione text, canragionesociale text, ticcodice text, canFlagPrivato text, prpidfiscale text, canPrpDtInizioAttivita text,prpComIstat text,prpProSigla text,
gesIdFiscale text,canGesDtInizioAttivita text,comIstat text,proSigla text,comCap text,canIndirizzo text,canDtRegistrazione text,canDtInizioAttivita text,canDtFineAttivita text,canFlagFineAttivita text,canNumTelFisso text, 
 canNumTelMobile text,  canNumFax text,  canEmail text,  canCapacita text, canLatitudine text, canLongitudine text,  canNumDecreto text,  flagPresenzaCani text,  flagPresenzaGatti text, flagPresenzaAltriAnimali text,
 flagStrutturaBloccata text, forzaDuplicato text, autorizzazioneScorta text, vetResponsabileScortaIdFiscale text, numAutorizzazioneScorta text, dtInizioScorta text, aslCodice text,note text) AS
$BODY$

 BEGIN
    
   RETURN QUERY
select distinct lps.id_sinaaf as canId,
       lps.codice_sinaaf::text as canCodice,
       lps.id::text as canCodiceRegione,
 op.ragione_sociale::text as canRagioneSociale,
       sinac_codice_struttura_detenzione::text
       as ticCodice,
       case 
	when _164.flag_privato then 'S'
        else 'N'  end as canFlagPrivato,
	case 
	when _164.flag_privato is false then ''
	else upper(_164.cf_proprietario)  end as prpIdFiscale,
	case 
	when _164.flag_privato is false then ''
        else coalesce(to_char(_164.data_inizio_proprietario, 'dd-mm-yyyy'), '')::text  end as canPrpDtInizioAttivita,
	case 
	when _164.flag_privato is false then com_prop.cod_comune::text
        else ''  end as prpComIstat,
        case 
	when _164.flag_privato is false then prov_prop.cod_provincia
        else '' end as prpProSigla,
	upper(_164.cf_gestore) as gesIdFiscale,
        coalesce(to_char(_164.data_inizio_gestione, 'dd-mm-yyyy'), '')::text as canGesDtInizioAttivita,
        case when com_stab.cod_comune != '-1' then com_stab.cod_comune::text else '' end as comIstat,
       upper(provsedestab.cod_provincia)::text as proSigla,
        coalesce( case when com_stab.cap != 'N.D' then com_stab.cap else null end  , case when ind_stab.cap != 'N.D' then ind_stab.cap else null end )::text as comCap,
regexp_replace(public.unaccent(coalesce(ind_stab.via, '') ),'[\°\\''\²\/]',' ','g') as canIndirizzo,

''  as canDtRegistrazione,
coalesce(to_char(lps.data_inizio, 'dd-mm-yyyy'), to_char(op.entered, 'dd-mm-yyyy')) as canDtInizioAttivita,
       coalesce(to_char(lps.data_fine, 'dd-mm-yyyy'), '') as canDtFineAttivita,
 case when lps.data_fine is not null then 'C' else '' end as canFlagFineAttivita, 
_164.telefono_fisso::text as canNumTelFisso,
       _164.telefono_mobile::text as canNumTelMobile,
       _164.fax::text as canNumFax,
       lps.mail1 as canEmail,
       _164.capacita::text as canCapacita,
substring(ind_stab.latitudine::text,1,8)  as canLatitudine,
 substring(ind_stab.longitudine::text,1,8) as canLongitudine,
'' as canNumDecreto,
case when _164.specie_presenti_cane then 'S' else 'N' end as flagPresenzaCani,
  case when _164.specie_presenti_gatto then 'S' else 'N' end as flagPresenzaGatti,
       case when _164.specie_presenti_altro then 'S' else 'N' end as flagPresenzaAltriAnimali,
'N' as flagStrutturaBloccata,
'S' as forzaDuplicato, '' as autorizzazioneScorta, '' as vetResponsabileScortaIdFiscale , '' as numAutorizzazioneScorta, '' as dtInizioScorta, 
'R' || asl.codiceistat as aslCodice,
       '' as note
from opu_operatore op 
left join opu_rel_operatore_soggetto_fisico rel_sogg on rel_sogg.id_operatore = op.id and (rel_sogg.enabled or rel_sogg.enabled is null) and (rel_sogg.data_fine is null or rel_sogg.data_fine > current_timestamp)
left join opu_soggetto_fisico sogg on sogg.id = rel_sogg.id_soggetto_fisico and sogg.trashed_date is null 
left join opu_stabilimento stab on op.id = stab.id_operatore
left join opu_indirizzo ind_stab on ind_stab.id = stab.id_indirizzo
left join comuni1 com_stab on com_stab.id = ind_stab.comune 
left join lookup_site_id asl on asl.code::text = com_stab.codiceistatasl
left join lookup_province provsedestab ON provsedestab.code = com_stab.cod_provincia::integer
left join opu_relazione_stabilimento_linee_produttive lps on lps.id_stabilimento = stab.id 
left join master_list_flag_linee_attivita pp2 on pp2.id_linea = lps.id_linea_produttiva
left join (select m.id, trim(unnest(string_to_array(m.scheda_supplementare, ','))) as num_scheda from master_list_linea_attivita m) att on att.id = lps.id_linea_produttiva
left join schede_supplementari.istanze s on s.riferimento_id = stab.id and s.riferimento_id_nome_tab = 'opu_stabilimento' and s.trashed_date is null and s.id_istanza_linea = lps.id and s.num_scheda = '164'
left join schede_supplementari.lookup_schede_supplementari l on l.num_scheda = att.num_scheda
left join schede_supplementari.dati_generici_164 _164 on _164.id_istanza = s.id	
left join comuni1 com_prop on com_prop.id = _164.comune_proprietario 
left join lookup_province prov_prop ON prov_prop.code = com_prop.cod_provincia::integer
where op.trashed_date is null and lps.id::text = _idstruttura;   
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.sinaaf_strutture_detenzione_get_dati_envelope(text)
  OWNER TO postgres;




--select * from sinaaf_strutture_detenzione_get_envelope('434791')




--FUNZIONI DI DOMINIO PER COOPERAZIONE GISA-BDU/VAM
CREATE OR REPLACE FUNCTION public.gisa_bdu_get_propagabilita(id_stab text, entita text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$

DECLARE
propagazione_bdu_return boolean;
_id_linea_produttiva integer;
id_registrazione_inserimento_bdu integer;
_controllo_detentore_cambiato boolean;

 begin

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



CREATE OR REPLACE FUNCTION public.gisa_vam_get_propagabilita(id_stab text, entita text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$

DECLARE
propagazione_vam_return boolean;
_id_linea_produttiva integer;
id_registrazione_inserimento_vam integer;
_controllo_detentore_cambiato boolean;

 begin

if(entita='struttura') then
_id_linea_produttiva:=(select id_linea_produttiva from opu_relazione_stabilimento_linee_produttive r where r.id=id_stab::integer );
if(select distinct vam from master_list_flag_linee_attivita where id_linea = _id_linea_produttiva::integer)then
propagazione_vam_return:=true; 
end if;
end if;


        RETURN propagazione_vam_return;   
 END;
$function$
;
--select * from gisa_vam_is_sincronizzato('448531','struttura','id')

drop function gisa_vam_is_sincronizzato( text,  text,  text);
CREATE OR REPLACE FUNCTION public.gisa_vam_is_sincronizzato(_identita text, entita text, nomeidtabella text)
 RETURNS TABLE(sincronizzato integer, id_vam text, cancellato boolean)
 LANGUAGE plpgsql
AS $function$
DECLARE
_idstabilimento integer;
inviabile boolean;
sincronizzato_return boolean;
id_vam text;
query text;
id_base text;
 begin
 inviabile:=true;
 if (entita = 'struttura') then
 entita = 'opu_relazione_stabilimento_linee_produttive';
 select id_stabilimento into _idstabilimento from opu_relazione_stabilimento_linee_produttive orslp  where orslp.id =_identita::integer;
 select entered is not null into inviabile from schede_supplementari.get_scheda_supplementare(_idstabilimento, 'opu_stabilimento', _identita::integer, '165');
end if;
query := '  select (
           (id_vam is not null ) and 
           (
             (t1.vam_invio_ok is not null and t1.vam_invio_ok >= GREATEST (t1.modified_sinaaf,trashed_date)) or
             (t1.sinaaf_estrazione_invio_pregresso_ok is not null and t1.sinaaf_estrazione_invio_pregresso_ok >= GREATEST (t1.modified_sinaaf,trashed_date))
           )
          ),id_vam, t1.trashed_date is not null as cancellato from ' || entita || ' as t1 where  t1.' || nomeidtabella || '::text = ''' || _identita || '''';
raise info 'query costruita per verificare if entita is sincronizzato: %', query;
EXECUTE query INTO  sincronizzato_return,id_vam,cancellato;
if sincronizzato_return is null then sincronizzato_return:=false; end if;

RETURN QUERY     
select case when sincronizzato_return then 0 when sincronizzato_return is false and inviabile then 1 when sincronizzato_return is false and inviabile is false then 2 end,id_vam,cancellato;    
 END;
$function$
;

drop function public.gisa_bdu_get_info_dbi( text,  text);


--select * from opu_relazione_stabilimento_linee_produttive order by id desc  limit 3
--select * from gisa_bdu_is_sincronizzato('448518','struttura','id')

drop function  gisa_bdu_is_sincronizzato( text,  text,  text);
CREATE OR REPLACE FUNCTION public.gisa_bdu_is_sincronizzato(_identita text, entita text, nomeidtabella text)
 RETURNS TABLE(sincronizzato integer, id_bdu text, cancellato boolean)
 LANGUAGE plpgsql
AS $function$
DECLARE
sincronizzato_return boolean;
id_bdu text;
query text;
id_base text;
inviabile boolean;
_idstabilimento integer;
 begin

 inviabile :=true;
 if (entita = 'struttura') then
 entita = 'opu_relazione_stabilimento_linee_produttive';
    select id_stabilimento into _idstabilimento from opu_relazione_stabilimento_linee_produttive orslp  where orslp.id =_identita::integer;
 select entered is not null into inviabile from schede_supplementari.get_scheda_supplementare(_idstabilimento, 'opu_stabilimento', _identita::integer, '164');
end if;
query := '  select (
           (id_bdu is not null ) and 
           (
             (t1.bdu_invio_ok is not null and t1.bdu_invio_ok >= GREATEST (t1.modified_sinaaf,trashed_date)) or
             (t1.sinaaf_estrazione_invio_pregresso_ok is not null and t1.sinaaf_estrazione_invio_pregresso_ok >= GREATEST (t1.modified_sinaaf,trashed_date))
           )
          ),id_bdu, t1.trashed_date is not null as cancellato from ' || entita || ' as t1 where  t1.' || nomeidtabella || '::text = ''' || _identita || '''';
raise info 'query costruita per verificare if entita is sincronizzato: %', query;
EXECUTE query INTO  sincronizzato_return,id_bdu,cancellato;
if sincronizzato_return is null then sincronizzato_return:=false; end if;

RETURN QUERY     
select case when sincronizzato_return then 0 when sincronizzato_return is false and inviabile then 1 when sincronizzato_return is false and inviabile is false then 2 end  ,id_bdu,cancellato;    
 END;
$function$
;

--select * from gisa_bdu_get_info_dbi('434826','struttura');
CREATE OR REPLACE FUNCTION public.gisa_bdu_get_info_dbi(_identita text, entita text)
 RETURNS TABLE(propagazione_bdu boolean, nome_app text, dbi_g2b text, id_tabella text, tabella text, sincronizzato boolean, cancellato boolean, id_struttura text, flagCanile boolean)
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
	tabella_return:='opu_relazione_stabilimento_linee_produttive';
	id_tabella:='id';
	propagazione_bdu:=(select * from g2b_get_propagabilita(_identita,entita));
	nome_app:='2bdu';
	dbi_g2b:='public_functions.strutture_detenzione_inserisci';   
	flagCanile := (select flag.bdu_canile is not null and flag.bdu_canile from opu_relazione_stabilimento_linee_produttive rel join ml8_linee_attivita_nuove_materializzata  linee on linee.id_nuova_linea_attivita = rel.id_linea_produttiva join master_list_flag_linee_attivita flag on flag.id_linea = rel.id_linea_produttiva and flag.rev = linee.rev where rel.id = _identita::integer  );
end if;








   RETURN QUERY     
select propagazione_bdu boolean, nome_app text, dbi_g2b text, id_tabella text, tabella_return text, sincronizzato boolean, cancellato boolean,_identita text, flagCanile boolean;    
 END;
$function$
;



CREATE OR REPLACE FUNCTION public.gisa_vam_get_info_dbi(_identita text, entita text)
 RETURNS TABLE(propagazione_vam boolean, nome_app text, dbi_g2v text, id_tabella text, tabella text, sincronizzato boolean, cancellato boolean, id_struttura text)
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
	tabella_return:='clinica';
	id_tabella:='id';
	propagazione_vam:=(select * from g2v_get_propagabilita(_identita,entita));
	nome_app:='2vam';
	dbi_g2v:='public_functions.strutture_veterinarie_inserisci';
end if;


   RETURN QUERY     
select propagazione_vam boolean, nome_app text, dbi_g2v text, id_tabella text, tabella_return text, sincronizzato boolean, cancellato boolean,_identita text;    
 END;
$function$
;



CREATE OR REPLACE FUNCTION public.g2b_get_propagabilita(
    id_stab text,
    entita text)
  RETURNS boolean AS
$BODY$

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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.g2b_get_propagabilita(text, text)
  OWNER TO postgres;



CREATE OR REPLACE FUNCTION public.g2v_get_propagabilita(
    id_stab text,
    entita text)
  RETURNS boolean AS
$BODY$

DECLARE
propagazione_vam_return boolean;
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
		if(select distinct vam from master_list_flag_linee_attivita where id_linea = _id_linea_produttiva::integer)then
			propagazione_vam_return:=true; 
		end if;
	end if;


        RETURN propagazione_vam_return;   
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.g2v_get_propagabilita(text, text)
  OWNER TO postgres;



--FUNZIONI PROPAGAZIONE BDU
CREATE OR REPLACE FUNCTION public_functions.suap_inserisci_stabilimento_bdu(
    id_operatore_in integer,
    idstabilimentogisa integer)
  RETURNS integer AS
$BODY$
DECLARE
idStabilimento int ;
id_stabilimento_opu integer;
id_indirizzo_out integer;
opu_impresa impresa;


id_asl_in integer;
    prov_stabilimento text;
    comune_stabilimento text;
    indirizzo_stabilimento text;
    toponimo text;
    civico_stailimento text;
    cap_stabilimento text;
    nazione_stabilimento text;

    
BEGIN

select distinct v.id_asl,v.sigla_prov_operativa,v.comune_stab ,v.via_stabilimento_calcolata ,v.toponimo_sede_stab,
v.civico_sede_stab,
v.cap_stab,v.nazione_stab
into id_asl_in ,
    prov_stabilimento ,
    comune_stabilimento ,
    indirizzo_stabilimento ,
    toponimo ,
    civico_stailimento ,
    cap_stabilimento ,
    nazione_stabilimento 
from opu_operatori_denormalizzati_canili_opc_gisa v where  v.id_linea_attivita =idStabilimentoGisa;   


    
select * into id_indirizzo_out from public_functions.suap_convergenza_indirizzo(prov_stabilimento, comune_stabilimento, indirizzo_stabilimento, toponimo,
civico_stailimento, cap_stabilimento, nazione_stabilimento);

for 
opu_impresa.partita_iva,opu_impresa.id,id_stabilimento_opu
 IN
/*VERIFICO SE PER QUELLA PARTITA IVA ESISTE UNO STABILIMENTO A QUELL'INDIRIZZO*/
select opu.partita_iva, opu.id, os.id 
from opu_operatore opu 
join opu_stabilimento os on os.id_operatore=opu.id 
where opu.id=id_operatore_in and os.id_indirizzo = id_indirizzo_out

LOOP
/*SE ESISTE LO STABILIMENTO PARTITA IVA ED INDIRIZZO, LA FUNZIONE TERMINA */
if id_stabilimento_opu>0
then 
	return id_stabilimento_opu;
end if;

END LOOP;
idStabilimento:=(select nextval('opu_stabilimento_id_seq'));
insert into opu_stabilimento (id,id_operatore,id_asl,id_indirizzo,entered_by,modified_by,entered,modified,id_stabilimento_gisa)
values
(
idStabilimento,id_operatore_in,id_asl_in,id_indirizzo_out,0,0,current_Timestamp,current_timestamp,idStabilimentoGisa
);

return idStabilimento;

 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public_functions.suap_inserisci_stabilimento_bdu(integer, integer)
  OWNER TO postgres;



CREATE OR REPLACE FUNCTION public_functions.strutture_detenzione_inserisci_operatore(
    idstabilimentogisa integer,
    id_soggetto_fisico_in integer)
  RETURNS impresa AS
$BODY$
DECLARE

opu_impresa impresa ;
occorrenzeEsistenti integer  ;
numIndirizzi integer; 
impresa_id integer;
suap_id_sede integer;
id_indirizzo integer;


    partita_iva_in character varying ;
    codice_fiscale_impresa_in character varying ;
        ragione_sociale_in character varying;
    sigla_prov_sede_legale text;
    comune_sede_legale text;
    indirizzo_legale text;
    toponimo text;
    civico_legale text;
    cap_legale text;
    nazione_legale text;

    
BEGIN
occorrenzeEsistenti:=0;
opu_impresa.id_esito:=1; /*NON ESISTENTE*/
/*CONTROLLO SE L'IMPRESA ESISTE IN OPU*/


select distinct
v.partita_iva,
v.codice_fiscale_impresa ,
v.ragione_sociale,
v.sigla_prov_legale,
v.comune_sede_legale,
v.via_sede_legale,
v.toponimo_sede_legale,
v.civico_sede_legale,
v.cap_sede_legale,
v.nazione_sede_legale
into 
    partita_iva_in ,
    codice_fiscale_impresa_in ,
        ragione_sociale_in ,
    sigla_prov_sede_legale ,
    comune_sede_legale ,
    indirizzo_legale ,
    toponimo ,
    civico_legale ,
    cap_legale ,
    nazione_legale 
    from opu_operatori_denormalizzati_canili_opc_gisa v where  v.id_linea_attivita = idStabilimentoGisa;
    

for 
opu_impresa.id, opu_impresa.partita_iva,opu_impresa.codice_fiscale_impresa,opu_impresa.ragione_sociale
 IN
select opu_operatore.id,partita_iva,codice_fiscale_impresa,ragione_sociale 
from  opu_operatore
join opu_rel_operatore_soggetto_fisico rel on rel.id_operatore=opu_operatore.id --and rel.enabled
where (opu_operatore.partita_iva=partita_iva_in or opu_operatore.codice_fiscale_impresa = codice_fiscale_impresa_in) and opu_operatore.trashed_date is null 
and rel.tipo_soggetto_fisico=2 and rel.stato_ruolo=1 and rel.id_soggetto_fisico=id_soggetto_fisico_in

LOOP
occorrenzeEsistenti:=occorrenzeEsistenti+1;
	numIndirizzi:=(select count(*) from(select  distinct upper (trim(via)) ,upper (trim(cap)),upper (trim(provincia)),comune
	from opu_indirizzo where id in(select sede.id_indirizzo from opu_relazione_operatore_sede sede where sede.id_operatore = opu_impresa.id ))a);
	
raise info 'numIndirizzi : %',numIndirizzi;
/*SE ESISTE UNA IMPRESACON GLI STESSI DATI NON LA  INSERISCO E RITORNO QUELLA ESISTENTE*/
if 	partita_iva_in=opu_impresa.partita_iva and 
	codice_fiscale_impresa_in = opu_impresa.codice_fiscale_impresa and 
	ragione_sociale_in=opu_impresa.ragione_sociale and 
        numIndirizzi=1
then	
	return opu_impresa ;
end if;	
numIndirizzi:=0;
	
	END LOOP;

impresa_id:=(select nextval('opu_operatore_id_seq'));

insert into opu_operatore (id,partita_iva,codice_fiscale_impresa,ragione_sociale,enteredby,modifiedby,entered,modified)
values (
impresa_id,
partita_iva_in,
codice_fiscale_impresa_in,
ragione_sociale_in,
13622,
13622,
current_timestamp,current_timestamp
);



--inserimento del record di relazione tra soggetto_fisico e id_operatore
insert into opu_rel_operatore_soggetto_fisico (id_soggetto_fisico,id_operatore,tipo_soggetto_fisico,data_inizio,stato_ruolo)
values(id_soggetto_fisico_in,impresa_id,2,current_timestamp,1);	

--verifico esistenza id_indirizzo sede legale
select * into id_indirizzo from public_functions.suap_convergenza_indirizzo(sigla_prov_sede_legale, comune_sede_legale, indirizzo_legale, toponimo, civico_legale, cap_legale, nazione_legale);

suap_id_sede :=(select nextval('opu_relazione_operatore_sede_id_seq'));
--da approfondire stato e tipologia sede

insert into opu_relazione_operatore_sede(id,id_operatore,id_indirizzo,tipologia_sede,stato_sede)
values(suap_id_sede, impresa_id,id_indirizzo,1,1);	


opu_impresa.id = impresa_id;
return opu_impresa ;

 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public_functions.strutture_detenzione_inserisci_operatore(integer, integer)
  OWNER TO postgres;



drop function public_functions.strutture_detenzione_inserisci(integer);
drop function public_functions.strutture_detenzione_inserisci( integer,  boolean);

select * from public_functions.strutture_detenzione_inserisci(448491, true);

CREATE OR REPLACE FUNCTION public_functions.strutture_detenzione_inserisci(idstabilimentogisa integer, flagCanile boolean)
 RETURNS text
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
idStabBdu int ;
flagOpComm boolean;
id_linea_attivita_gisa integer;

BEGIN

flagOpComm := flagCanile is false;

select st.id into idStabBdu from opu_stabilimento st join opu_operatore op on op.id=st.id_operatore 
where id_stabilimento_gisa =idstabilimentogisa and op.trashed_date is null;

raise info 'flagCanile: %', flagCanile;
raise info 'flagOpComm: %', flagOpComm;

-- 1. soggetto fisico ed indirizzo rappresentante legale che ritorna id_soggetto fisico
id_soggetto_out := (select * from public_functions.insert_soggetto_fisico_bdu(idStabilimentoGisa));
raise info 'id_soggetto_out: %', id_soggetto_out;

--2 impresa in relazione al soggetto fisico e all'indirizzo restituisce una tupla con id operatore partita_iva, ragione sociale e cf...
id_impresa := (select id from public_functions.strutture_detenzione_inserisci_operatore(idStabilimentoGisa,id_soggetto_out));
raise info 'id_impresa: %', id_impresa;
-- 3 stabilimento restituisce l'id dello stabilimento
id_stab_out := (select * from public_functions.suap_inserisci_stabilimento_bdu(id_impresa,idStabilimentoGisa));
raise info 'id_stab_out: %', id_stab_out;
-- 4 linea produttiva, esegue una insert e restituisce un booleano. 5 è un canile, 6 l'operatore commerciale
	select id_linea_attivita_stab into id_linea_attivita_gisa from opu_operatori_denormalizzati_canili_opc_gisa v where  v.id_linea_attivita = idStabilimentoGisa;
	raise info 'id_linea_attivita_gisa: %', id_linea_attivita_gisa;
	insert into opu_relazione_stabilimento_linee_produttive (id_linea_produttiva,id_stabilimento,id_linea_gisa) values(case when flagCanile then 5 else 6 end ,id_stab_out, id_linea_attivita_gisa) returning id into id_stabl_out ;  
	raise info 'id_stabl_out: %', id_stabl_out;

if  flagCanile=true then
	raise info '(select * from public_functions.aggiorna_info_canile(%,%,%))', idstabilimentogisa::int, id_stab_out, id_stabl_out;
	esito_estesi:= (select * from public_functions.aggiorna_info_canile(idstabilimentogisa::int, id_stab_out, id_stabl_out));
end if;

if flagOpComm=true then 
	raise info '(select * from public_functions.aggiorna_info_operatore(%,%))', idstabilimentogisa::int, id_stab_out;
	esito_estesi:= (select * from public_functions.aggiorna_info_operatore(idstabilimentogisa::int, id_stab_out));
end if;


delete from opu_operatori_denormalizzati where id_opu_operatore =id_impresa;
esito := (select * from public_functions.update_opu_materializato(id_impresa));
raise info 'esito: %', esito;

return id_stabl_out::text;




 END;
$function$
;





--FUNZIONI PROPAGAZIONE VAM
--GISA  
CREATE OR REPLACE VIEW public.opu_operatori_denormalizzati_view AS 
 SELECT DISTINCT
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
    COALESCE(o.tipo_impresa, o.tipo_societa) AS impresa_id_tipo_impresa,
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
    lps.id_sinaaf,
    lps.codice_sinaaf
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

ALTER TABLE public.opu_operatori_denormalizzati_view
  OWNER TO postgres;




drop VIEW opu_operatori_denormalizzati_view_vam;

CREATE OR REPLACE VIEW public.opu_operatori_denormalizzati_view_vam AS 
 SELECT o.id_stabilimento  ,
    o.id_opu_operatore  ,
    o.partita_iva  ,
    o.codice_fiscale_impresa  ,
    o.ragione_sociale  ,
    o.comune_stab  ,
    o.via_stabilimento_calcolata  ,
    o.civico_sede_stab  ,
    o.cap_stab  ,
    o.id_asl  ,
    o.toponimo_sede_stab  ,
    o.id_linea_attivita  ,
    o.lat_stab   ,
    o.long_stab   ,
    o.id_sinaaf  ,
    o.codice_sinaaf 

   FROM opu_operatori_denormalizzati_view o
     LEFT JOIN master_list_flag_linee_attivita ON master_list_flag_linee_attivita.id_linea = o.id_linea_attivita_stab
  WHERE master_list_flag_linee_attivita.vam = true;

ALTER TABLE public.opu_operatori_denormalizzati_view_vam
  OWNER TO postgres;

--VAM
create or replace view opu_operatori_denormalizzati_canili_opc_gisa as 
select t.id_stabilimento  ,
    t.id_opu_operatore  ,
    t.partita_iva  ,
    t.codice_fiscale_impresa  ,
    t.ragione_sociale  ,
    t.comune_stab  ,
    t.via_stabilimento_calcolata  ,
    t.civico_sede_stab  ,
    t.cap_stab  ,
    t.id_asl  ,
    t.toponimo_sede_stab  ,
    t.id_linea_attivita  ,
    t.lat_stab   ,
    t.long_stab   ,
    t.id_sinaaf  ,
    t.codice_sinaaf   
                  FROM dblink((select * from conf.get_pg_conf('GISA')), 'select t.id_stabilimento  ,  t.id_opu_operatore  , t.partita_iva  , t.codice_fiscale_impresa  , t.ragione_sociale  ,  t.comune_stab  ,
    t.via_stabilimento_calcolata  , t.civico_sede_stab  , t.cap_stab  , t.id_asl  , t.toponimo_sede_stab  ,  t.id_linea_attivita  , t.lat_stab   ,  t.long_stab   , t.id_sinaaf  , t.codice_sinaaf      from opu_operatori_denormalizzati_view_vam t') 
                  as t(id_stabilimento  integer,
    id_opu_operatore integer ,   partita_iva text ,  codice_fiscale_impresa text , ragione_sociale text ,  comune_stab text ,  via_stabilimento_calcolata text , civico_sede_stab  text,   cap_stab text ,
    id_asl integer ,  toponimo_sede_stab text , id_linea_attivita integer , lat_stab  text , long_stab  text , id_sinaaf integer , codice_sinaaf text);



--select * from public_functions.strutture_veterinarie_inserisci(434834)
CREATE OR REPLACE FUNCTION public_functions.strutture_veterinarie_inserisci(inputidgisa integer)
  RETURNS text AS
$BODY$
DECLARE
inputIdAsl integer;
inputIdComune integer;
outputIdClinica integer; 
outputMsg text;
inputnome text;
inputnomebreve text;
inputasl text;
inputcomune text;
inputindirizzo text;

BEGIN 

select ragione_sociale, ragione_sociale, id_asl, c.id , concat (toponimo_sede_Stab, ' ', via_stabilimento_calcolata , ', ', civico_sede_Stab, ' - ', comune_stab) 

INTO 
inputNome,
inputNomeBreve,
inputIdAsl,
inputIdComune,
inputIndirizzo

from opu_operatori_denormalizzati_canili_opc_gisa v left join lookup_comuni c on c.description ilike v.comune_stab where  v.id_linea_attivita =inputidgisa ;

insert into clinica (nome, nome_breve, asl, comune, indirizzo, entered, id_stabilimento_gisa) 
values (inputNome, inputNomeBreve, inputIdAsl, inputIdComune, inputIndirizzo, now(), inputIdGisa) returning id into outputMsg ;

INSERT INTO lookup_detentori_sinantropi(description, enabled,  fax,      indirizzo, level,              comune,   zoo, entered, id_stabilimento_gisa)
VALUES                                 (inputNome  , true, null, inputIndirizzo,   160, inputIdComune, false,   now(), inputIdGisa);

        
return outputMsg;
	
END 

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public_functions.strutture_veterinarie_inserisci(integer)
  OWNER TO postgres;



--RAPPRESENTAZIONE LINEA IN BDU
--GISA
drop view linee_propagazione_bdu;
create or replace view linee_propagazione_bdu as 
select  flag.id_linea as code, l.path_descrizione as description_long, l.attivita as description, flag.codice_univoco, flag.bdu_canile, flag.bdu_operatore_commerciale from master_list_flag_linee_attivita flag
left join ml8_linee_attivita_nuove_materializzata l on l.id_nuova_linea_attivita = flag.id_linea
where flag.trashed is null and flag.rev = 11 and flag.bdu ;



--BDU -Versione con le linee gisa incorporate nelle linee bdu
CREATE OR REPLACE VIEW public.opu_operatori_denormalizzati_canili_opc_gisa AS 
 SELECT t.id_stabilimento,
    t.id_opu_operatore,
    t.partita_iva,
    t.codice_fiscale_impresa,
    t.ragione_sociale,
    t.nome_rapp_sede_legale,
    t.cognome_rapp_sede_legale,
    t.cf_rapp_sede_legale,
    t.data_nascita_rapp_sede_legale,
    t.sesso,
    t.comune_nascita_rapp_sede_legale,
    t.sigla_prov_soggfisico,
    t.comune_residenza,
    t.via_rapp_sede_legale,
    t.civico,
    t.cap_residenza,
    t.nazione_residenza,
    t.sigla_prov_legale,
    t.comune_sede_legale,
    t.via_sede_legale,
    t.civico_sede_legale,
    t.cap_sede_legale,
    t.nazione_sede_legale,
    t.sigla_prov_operativa,
    t.comune_stab,
    t.via_stabilimento_calcolata,
    t.civico_sede_stab,
    t.cap_stab,
    t.nazione_stab,
    t.id_asl,
    t.toponimo_residenza,
    t.toponimo_sede_legale,
    t.toponimo_sede_stab,
    t.id_linea_attivita,
    t.modifiedby,
    t.modified,
    t.enteredby,
    t.entered,
    t.id_linea_bdu,
    t.lat_stab,
    t.long_stab, t.id_linea_attivita_stab
   FROM dblink(( SELECT get_pg_conf.get_pg_conf
           FROM conf.get_pg_conf('GISA'::text) get_pg_conf(get_pg_conf)), 'select id_stabilimento  ,
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
    long_stab , id_linea_attivita_stab  from opu_operatori_denormalizzati_view_bdu t'::text) t(id_stabilimento integer, id_opu_operatore integer, partita_iva text, codice_fiscale_impresa text, ragione_sociale text, nome_rapp_sede_legale text, cognome_rapp_sede_legale text, 
    cf_rapp_sede_legale text, data_nascita_rapp_sede_legale timestamp without time zone, sesso text, comune_nascita_rapp_sede_legale text, sigla_prov_soggfisico text, comune_residenza text, 
    via_rapp_sede_legale text, civico text, cap_residenza text, nazione_residenza text, sigla_prov_legale text, comune_sede_legale text, via_sede_legale text, civico_sede_legale text, cap_sede_legale text, 
    nazione_sede_legale text, sigla_prov_operativa text, comune_stab text, via_stabilimento_calcolata text, civico_sede_stab text, cap_stab text, nazione_stab text, id_asl integer, toponimo_residenza text, 
    toponimo_sede_legale text, toponimo_sede_stab text, id_linea_attivita integer, modifiedby integer, modified timestamp without time zone, enteredby integer, entered timestamp without time zone, 
    id_linea_bdu integer, lat_stab double precision, long_stab double precision, id_linea_attivita_stab integer);

ALTER TABLE public.opu_operatori_denormalizzati_canili_opc_gisa
  OWNER TO postgres;



alter table opu_lookup_attivita_linee_produttive_aggregazioni add column description_long text;
alter table opu_lookup_attivita_linee_produttive_aggregazioni add column codice_univoco text;
alter table opu_lookup_attivita_linee_produttive_aggregazioni add column bdu_canile boolean;
alter table opu_lookup_attivita_linee_produttive_aggregazioni add column bdu_operatore_commerciale boolean;
alter table opu_lookup_attivita_linee_produttive_aggregazioni drop column short_description;

drop view linee_gisa_view;
create or replace view linee_gisa_view as 
select  t.code, t.description, false as default_item, 0 as level, true as enabled, -1 as id_aggregazione, null as codice, null::timestamp without time zone as entered, null::timestamp without time zone as modified, t.codice_univoco, t.bdu_canile, t.bdu_operatore_commerciale, t.description_long FROM dblink((select * from conf.get_pg_conf('GISA')), 'select t.code, t.description, t.codice_univoco, t.bdu_canile, t.bdu_operatore_commerciale, t.description_long from linee_propagazione_bdu t') 
                  as t(code integer, description text,  codice_univoco text, bdu_canile boolean, bdu_operatore_commerciale boolean, description_long text);

--create table linee_gisa
--(code integer, description text, short_description text, codice_univoco text, bdu_canile boolean, bdu_operatore_commerciale boolean);

delete from opu_relazione_attivita_produttive_aggregazioni where id > 10;
delete from opu_lookup_attivita_linee_produttive_aggregazioni where bdu_canile is not null;
insert into opu_lookup_attivita_linee_produttive_aggregazioni (select * from linee_gisa_view);

 select * from opu_lookup_attivita_linee_produttive_aggregazioni
insert into opu_relazione_attivita_produttive_aggregazioni  (select t.code, t.code,  1  from opu_lookup_attivita_linee_produttive_aggregazioni t where bdu_canile is true                and bdu_canile                is not null );
insert into opu_relazione_attivita_produttive_aggregazioni  (select t.code, t.code,  1  from opu_lookup_attivita_linee_produttive_aggregazioni t where bdu_operatore_commerciale is true and bdu_operatore_commerciale is not null );

alter table opu_relazione_stabilimento_linee_produttive add column id_linea_gisa integer;

update opu_relazione_stabilimento_linee_produttive set id_linea_gisa = id_linea_produttiva;


CREATE OR REPLACE VIEW public.opu_operatori_denormalizzati_view AS 
 SELECT o.id AS id_opu_operatore,
    rel.id AS id_rel_stab_lp,
    o.ragione_sociale,
    o.partita_iva,
    o.codice_fiscale_impresa,
    o.note,
    o.entered,
    o.modified,
    o.enteredby,
    o.modifiedby,
    sogg.nome,
    sogg.cognome,
    sogg.codice_fiscale,
    i.comune,
    rel.id_linea_produttiva,
    stab.id_asl,
    rel.data_inizio,
    rel.data_fine,
    rel.id_linea_gisa
   FROM opu_relazione_stabilimento_linee_produttive rel
     LEFT JOIN opu_stabilimento stab ON rel.id_stabilimento = stab.id
     LEFT JOIN opu_indirizzo i ON i.id = stab.id_indirizzo
     LEFT JOIN opu_operatore o ON stab.id_operatore = o.id
     LEFT JOIN opu_rel_operatore_soggetto_fisico rels ON rels.id_operatore = o.id
     LEFT JOIN opu_soggetto_fisico sogg ON sogg.id = rels.id_soggetto_fisico
  WHERE o.trashed_date IS NULL AND rel.trashed_date IS NULL;


alter table opu_operatori_denormalizzati add column id_linea_gisa integer;



delete from opu_operatori_denormalizzati ;
insert into opu_operatori_denormalizzati (select * from opu_operatori_denormalizzati_view where id_opu_operatore is not null);

--BDU -Versione con le linee gisa separate da quelle bdu
delete  from opu_relazione_attivita_produttive_aggregazioni where id > 10;
delete from opu_lookup_attivita_linee_produttive_aggregazioni where bdu_canile or bdu_operatore_commerciale;

insert into opu_lookup_attivita_linee_produttive_aggregazioni (code,description,default_item,level,enabled,id_aggregazione) values (8,'Struttura di detenzione',false,0,true,-1);

insert into opu_relazione_attivita_produttive_aggregazioni  values(9,8,1 );



--BDU -Riattivare versione con le linee gisa incorporate nelle linee bdu
insert into opu_lookup_attivita_linee_produttive_aggregazioni (select * from linee_gisa_view);
insert into opu_relazione_attivita_produttive_aggregazioni  (select t.code, t.code,  1  from opu_lookup_attivita_linee_produttive_aggregazioni t where bdu_canile is true                and bdu_canile                is not null );
insert into opu_relazione_attivita_produttive_aggregazioni  (select t.code, t.code,  1  from opu_lookup_attivita_linee_produttive_aggregazioni t where bdu_operatore_commerciale is true and bdu_operatore_commerciale is not null );

update opu_lookup_attivita_linee_produttive_aggregazioni set enabled = true where code = 8;

--BDU - Versione con solo linee gisa

--Schede supplementari
insert into schede_supplementari.lookup_schede_supplementari(description, num_scheda, level, enabled, return_view) values('Scheda N. 164 – Dati integrativi per caricamento SINAC Strutture di detenzione', '164',1,true,'164');
insert into schede_supplementari.lookup_schede_supplementari(description, num_scheda, level, enabled, return_view) values('Scheda N. 165 – Dati integrativi per caricamento SINAC Strutture veterinarie', '165',1,true,'165');
insert into schede_supplementari.lookup_schede_supplementari(description, num_scheda, level, enabled, return_view) values('Scheda N. 119 – Veterinario responsabile scorta farmaci', '119',1,true,'119');
update role_permission set role_view = true where role_id = 32 and permission_id = 793;

update master_list_linea_attivita set scheda_supplementare = '111,164' where scheda_supplementare ilike '%111%';
update master_list_linea_attivita set scheda_supplementare = '118,165' where scheda_supplementare ilike '%118%';



CREATE OR REPLACE FUNCTION schede_supplementari.insert_dati_generici_164(
    _id_istanza integer,
    _flag_privato boolean,
    _cf_proprietario text,
    _data_inizio_proprietario timestamp without time zone,
    _comune_proprietario integer,
    _cf_gestore text,
    _data_inizio_gestione timestamp without time zone,
    _capacita integer,
    _specie_presenti_cane boolean,
    _specie_presenti_gatto boolean,
    _specie_presenti_altro boolean,
    _telefono_fisso text,
    _telefono_mobile text,
    _fax text
   )
		
  RETURNS integer AS
$BODY$

  DECLARE ret_id integer;
  
  BEGIN
	INSERT INTO schede_supplementari.dati_generici_164(id, id_istanza, flag_privato ,cf_proprietario ,data_inizio_proprietario ,comune_proprietario ,cf_gestore ,data_inizio_gestione ,capacita ,specie_presenti_cane ,specie_presenti_gatto ,specie_presenti_altro,telefono_fisso,telefono_mobile,fax )
	 VALUES ((select nextval('schede_supplementari.dati_generici_formazione_iaa_id_seq')), _id_istanza,_flag_privato ,_cf_proprietario ,_data_inizio_proprietario ,_comune_proprietario ,_cf_gestore ,_data_inizio_gestione ,_capacita ,_specie_presenti_cane ,_specie_presenti_gatto ,_specie_presenti_altro,_telefono_fisso,_telefono_mobile,_fax)
		RETURNING id into ret_id;
		  
 RETURN ret_id;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION schede_supplementari.insert_dati_generici_164( integer, boolean, text, timestamp without time zone, integer,  text, timestamp without time zone, integer, boolean, boolean, boolean,text, text, text)
  OWNER TO postgres;


CREATE TABLE schede_supplementari.dati_generici_164
(
  id serial NOT NULL,
  flag_privato boolean,
  cf_proprietario text,
  data_inizio_proprietario timestamp without time zone,
  comune_proprietario integer,
  cf_gestore text,
  data_inizio_gestione timestamp without time zone,
  capacita integer,
  specie_presenti_cane boolean,
  specie_presenti_gatto boolean,
  specie_presenti_altro boolean,
  id_istanza integer,
  telefono_fisso text,
  telefono_mobile text,
  fax text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE schede_supplementari.dati_generici_164
  OWNER TO postgres;



CREATE OR REPLACE FUNCTION schede_supplementari.get_dati_generici_164(_id_istanza integer)
  RETURNS SETOF schede_supplementari.dati_generici_164 AS
$BODY$
DECLARE
	
BEGIN
		return query
			select * FROM schede_supplementari.dati_generici_164 WHERE id_istanza = _id_istanza;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION schede_supplementari.get_dati_generici_164(integer)
  OWNER TO postgres;



  
CREATE OR REPLACE FUNCTION schede_supplementari.insert_dati_generici_165(
    _id_istanza integer,
    _flag_h24 boolean,
    _flag_area_degenza boolean,
    _cf_veterinario text,
    _data_inizio_nomina timestamp without time zone,
    _telefono_fisso text,
    _telefono_mobile text,
    _fax text
   )
		
  RETURNS integer AS
$BODY$

  DECLARE ret_id integer;
  
  BEGIN
	INSERT INTO schede_supplementari.dati_generici_165(id, id_istanza, flag_h24,flag_area_degenza,cf_veterinario, data_inizio_nomina, telefono_fisso , telefono_mobile, fax )
	 VALUES ((select nextval('schede_supplementari.dati_generici_formazione_iaa_id_seq')), _id_istanza,_flag_h24 , _flag_area_degenza , _cf_veterinario , _data_inizio_nomina ,_telefono_fisso , _telefono_mobile ,_fax )
		RETURNING id into ret_id;
		  
 RETURN ret_id;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION schede_supplementari.insert_dati_generici_165(  integer,boolean, boolean,text,timestamp without time zone,text, text,text)
  OWNER TO postgres;



CREATE TABLE schede_supplementari.dati_generici_165
(
  id serial NOT NULL,
  flag_h24 boolean,
  flag_area_degenza boolean,
  cf_veterinario text, 
  data_inizio_nomina timestamp without time zone, 
  telefono_fisso text, 
  telefono_mobile text, 
  fax text,
  id_istanza integer
)
WITH (
  OIDS=FALSE
);
ALTER TABLE schede_supplementari.dati_generici_165
  OWNER TO postgres;



CREATE OR REPLACE FUNCTION schede_supplementari.get_dati_generici_165(_id_istanza integer)
  RETURNS SETOF schede_supplementari.dati_generici_165 AS
$BODY$
DECLARE
	
BEGIN
		return query
			select * FROM schede_supplementari.dati_generici_165 WHERE id_istanza = _id_istanza;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION schede_supplementari.get_dati_generici_165(integer)
  OWNER TO postgres;





CREATE OR REPLACE FUNCTION schede_supplementari.insert_dati_generici_119(
    _id_istanza integer,
    _flag_privato boolean,
    _cf_proprietario text,
    _data_inizio_proprietario timestamp without time zone,
    _comune_proprietario integer,
    _cf_gestore text,
    _data_inizio_gestione timestamp without time zone,
    _capacita integer,
    _specie_presenti_cane boolean,
    _specie_presenti_gatto boolean,
    _specie_presenti_altro boolean,
    _telefono_fisso text,
    _telefono_mobile text,
    _fax text
   )
		
  RETURNS integer AS
$BODY$

  DECLARE ret_id integer;
  
  BEGIN
	INSERT INTO schede_supplementari.dati_generici_164(id, id_istanza, flag_privato ,cf_proprietario ,data_inizio_proprietario ,comune_proprietario ,cf_gestore ,data_inizio_gestione ,capacita ,specie_presenti_cane ,specie_presenti_gatto ,specie_presenti_altro,telefono_fisso,telefono_mobile,fax )
	 VALUES ((select nextval('schede_supplementari.dati_generici_formazione_iaa_id_seq')), _id_istanza,_flag_privato ,_cf_proprietario ,_data_inizio_proprietario ,_comune_proprietario ,_cf_gestore ,_data_inizio_gestione ,_capacita ,_specie_presenti_cane ,_specie_presenti_gatto ,_specie_presenti_altro,_telefono_fisso,_telefono_mobile,_fax)
		RETURNING id into ret_id;
		  
 RETURN ret_id;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION schede_supplementari.insert_dati_generici_164( integer, boolean, text, timestamp without time zone, integer,  text, timestamp without time zone, integer, boolean, boolean, boolean,text, text, text)
  OWNER TO postgres;


CREATE TABLE schede_supplementari.dati_generici_164
(
  id serial NOT NULL,
  flag_privato boolean,
  cf_proprietario text,
  data_inizio_proprietario timestamp without time zone,
  comune_proprietario integer,
  cf_gestore text,
  data_inizio_gestione timestamp without time zone,
  capacita integer,
  specie_presenti_cane boolean,
  specie_presenti_gatto boolean,
  specie_presenti_altro boolean,
  id_istanza integer,
  telefono_fisso text,
  telefono_mobile text,
  fax text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE schede_supplementari.dati_generici_164
  OWNER TO postgres;



CREATE OR REPLACE FUNCTION schede_supplementari.get_dati_generici_164(_id_istanza integer)
  RETURNS SETOF schede_supplementari.dati_generici_164 AS
$BODY$
DECLARE
	
BEGIN
		return query
			select * FROM schede_supplementari.dati_generici_164 WHERE id_istanza = _id_istanza;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION schede_supplementari.get_dati_generici_164(integer)
  OWNER TO postgres;



