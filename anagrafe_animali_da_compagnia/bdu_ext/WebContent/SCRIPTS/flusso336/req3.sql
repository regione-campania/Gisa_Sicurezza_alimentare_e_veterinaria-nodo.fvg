--Tracciabilità, fa parte del req. 2
alter table evento_registrazione_bdu add column id_animale_madre integer;

--Permessi BDU
insert into permission(permission,category_id,permission_view,enabled) values('registro_sanzioni',35,true,true);




--Startup tracciabilità, serve per capire quando è iniziata la gestione della tracciabilità
create table configurazione_tracciabilita_cani(
data_inizio timestamp without time zone 
);



--Registro sanzioni
-- DROP FOREIGN TABLE public.controlli_ufficiali_proprietari_cani;
CREATE FOREIGN TABLE public.controlli_ufficiali_proprietari_cani
   (ticketid integer, --id del cu in Gisa
    microchip text,
     tatuaggio text,
    cf_proprietario text,
    data_controllo timestamp without time zone,
    data_chiusura  timestamp without time zone,
    utente_chiusura text,
    numero_sanzione text)
   SERVER foreign_server_gisa
   OPTIONS (schema_name 'public', table_name 'controlli_ufficiali_proprietari_cani', fetch_size '100000');
ALTER FOREIGN TABLE public.controlli_ufficiali_cani_aggressori
  OWNER TO postgres;



drop view registro_sanzioni_proprietari_cani;

 
create or replace view registro_sanzioni_proprietari_cani as 
select distinct a.id as id_animale, 
	a.microchip::text, 
	a.tatuaggio::text, 
	a.id_proprietario, 
	opu_rel.ragione_sociale::text as proprietario, 
	opu_rel.id_asl as id_asl_proprietario, 
	asl.description::text as asl_proprietario, 
	e_bdu.id_proprietario_provenienza, 
	coalesce(opu_rel_prov.ragione_sociale, opu_rel_prov_origine.ragione_sociale, e_bdu.ragione_sociale_provenienza) ::text as proprietario_provenienza,   
	e.id_evento, 
	e.entered as data_inserimento_registrazione, 
	e_bdu.data_registrazione as  data_registrazione,
	a.data_nascita, 
	cont.namelast || ' ' || cont.namefirst as utente_inserimento,
	r.description::text as razza,
	cu.data_chiusura,
	cu.utente_chiusura,
	cu.ticketid as id_cu,
	(e_bdu.id_animale_madre is not null and e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario ) or  e_bdu.id_animale_madre is null  as sanzione_cedente,
	a.flag_mancata_origine as sanzione_proprietario ,
	case when cu.ticketid is not null then 'Chiusa' else 'Aperta' end as stato, 
	case when ((e_bdu.id_animale_madre is not null and e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario ) or  e_bdu.id_animale_madre is null) and (a.flag_mancata_origine is false or a.flag_mancata_origine  is null) then 'Cedente' when a.flag_mancata_origine then 'Proprietario' end as soggetto_sanzionato, 
	e_bdu.id_animale_madre  as id_animale_madre,
	coalesce(a_madre.microchip, e_bdu.microchip_madre)::text as microchip_madre,
	cu.numero_sanzione
from animale a
join evento e on e.id_animale = a.id and 
	e.id_tipologia_evento = 1 and 
	e.trashed_date is null and 
	e.data_cancellazione is null
join evento_registrazione_bdu e_bdu on e.id_evento = e_bdu.id_evento and 
	e_bdu.flag_anagrafe_fr is false and
	--qui si prendono gli animali registrati per i quali si deve fare la sanzione 
	(
	a.flag_mancata_origine or --mancata tracciabilità, sanzione per il proprietario
	(e_bdu.id_animale_madre is not null and e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario ) or  --da proprietario in regione, proprietario provenienza diverso da proprietario animale, sanzione per il cedente
	(e_bdu.id_animale_madre is null )      --da proprietario fuori regione/fuori nazione, si deduce che il proprietario non potrà mai essere lo stesso dell'animale, sanzione per il cedente 
	)
join access_ acc on acc.user_id = a.utente_inserimento and 
	acc.role_id = 24 --inserito da veterinario privato
join contact_ cont on cont.contact_id = acc.contact_id
join opu_operatori_denormalizzati opu_rel on opu_rel.id_rel_stab_lp = e_bdu.id_proprietario and 
	opu_rel.id_linea_produttiva in (1,4,5,6)
left join opu_operatori_denormalizzati opu_rel_prov on opu_rel_prov.id_rel_stab_lp = e_bdu.id_proprietario_provenienza
left join opu_operatori_denormalizzati_origine opu_rel_prov_origine on opu_rel_prov_origine.id_rel_stab_lp = e_bdu.id_proprietario_provenienza
join configurazione_tracciabilita_cani config on config.data_inizio < e.entered
left join animale a_madre on a_madre.id = e_bdu.id_animale_madre
left join lookup_razza r on r.code = a.id_razza
left join lookup_site_id asl on asl.code = opu_rel.id_asl
left join controlli_ufficiali_proprietari_cani cu on cu.data_controllo = e_bdu.data_registrazione and  
                                                     cu.microchip =  a.microchip  
	                                                      and
	                                                     cu.cf_proprietario = (
											case when ((e_bdu.id_animale_madre is not null and e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario ) or  e_bdu.id_animale_madre is null) and (a.flag_mancata_origine is false or a.flag_mancata_origine  is null) then upper(coalesce(opu_rel_prov.codice_fiscale, opu_rel_prov_origine.codice_fiscale, e_bdu.codice_fiscale_proprietario_provenienza) ) 
											when a.flag_mancata_origine then upper(opu_rel.codice_fiscale) end
										  )
									
where a.trashed_date is null and a.data_cancellazione is null and a.id_specie = 1; 



-- DROP FUNCTION public.get_registro_sanzioni(integer, integer);
CREATE OR REPLACE FUNCTION public.get_registro_sanzioni(id_animale_ integer default -1, id_asl_ integer default -1)
  RETURNS TABLE(id_animale integer, microchip text, tatuaggio text, id_proprietario integer, proprietario text, id_asl_proprietario integer, asl_proprietario text,  id_proprietario_provenienza integer, proprietario_provenienza text, id_evento integer, 
                data_inserimento_registrazione timestamp without time zone, data_registrazione timestamp without time zone,
                 data_nascita timestamp without time zone, utente_inserimento text, razza text, data_chiusura  timestamp without time zone, utente_chiusura text, id_cu integer,
                 sanzione_cedente boolean, sanzione_proprietario boolean, stato text, soggetto_sanzionato text, id_animale_madre integer, microchip_madre text, numero_sanzione text) AS



$BODY$

 BEGIN
    
   RETURN QUERY     
 
    select * from registro_sanzioni_proprietari_cani reg
			where (id_animale_ = -1 or reg.id_animale = id_animale_) and (id_asl_ = -1 or reg.id_asl_proprietario = id_asl_) 
			order by data_registrazione;
 

 END;
$BODY$
  LANGUAGE plpgsql  STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_registro_sanzioni(integer,integer)
  OWNER TO postgres;



--usato per vedere se c'è una sanzione nel registro da fare, in tal caso non si può fare la stampa
CREATE OR REPLACE FUNCTION public.esiste_registro_sanzione_proprietario(id_animale_ integer)
  RETURNS boolean AS
$BODY$
DECLARE
	ret text;
BEGIN

select sanzione_proprietario and id_cu is null into ret  from public.get_registro_sanzioni(id_animale_);

 RETURN ret;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100;
ALTER FUNCTION public.esiste_registro_sanzione_proprietario(integer)
  OWNER TO postgres;



--DA LANCIARE SU GISA
-- DROP VIEW public.controlli_ufficiali_proprietari_cani;
CREATE OR REPLACE VIEW public.controlli_ufficiali_proprietari_cani AS 
 SELECT t.ticketid,
    ass.serial_number AS microchip,
    ass.po_number AS tatuaggio--,
    --eventi_motivi.codice_evento
    ,upper(o.codice_fiscale_rappresentante) as cf_proprietario,
    t.assigned_date as data_controllo,
    t.closed as data_chiusura,
    concat (cont.namelast, ' ', cont.namefirst) as utente_chiusura,
    sanz.identificativo as numero_sanzione 
   FROM ticket t
     JOIN asset ass ON ass.idcontrollo = t.ticketid --controllo su che cane è stata messa la sanzione
     join ticket nonconf on nonconf.id_controllo_ufficiale = t.ticketid::text and nonconf.tipologia =8 and nonconf.trashed_date is null 
     join ticket sanz on sanz.id_nonconformita = nonconf.ticketid and sanz.tipologia =1 and sanz.trashed_date is null --controllo se c'è una sanzione il quel cu
     --JOIN tipocontrolloufficialeimprese tip ON tip.idcontrollo = t.ticketid AND tip.enabled
     --JOIN dpat_indicatore_new ind ON ind.id = tip.pianomonitoraggio OR tip.tipoispezione = ind.id
     --JOIN rel_motivi_eventi_cu ON rel_motivi_eventi_cu.cod_raggrup_ind = ind.cod_raggruppamento AND rel_motivi_eventi_cu.trashed_date IS NULL
     --JOIN lookup_eventi_motivi_cu eventi_motivi ON eventi_motivi.code = rel_motivi_eventi_cu.id_evento_cu AND 
	  --(eventi_motivi.codice_evento::text = ANY (ARRAY['isCaniAggressori'::character varying::text, 'isCaniMorsicatori'::character varying::text]))
     join organization o on o.org_id = t.org_id and o.tipologia = 255 --controllo che il cu è stato messo su un operatore di tipo 'cani padronali'
     join access_ acc on acc.user_id = t.modifiedby
     join contact_ cont on cont.contact_id = acc.contact_id 
WHERE t.trashed_date IS NULL AND (t.closed IS NOT NULL OR t.closed_nolista);


ALTER TABLE public.controlli_ufficiali_proprietari_cani OWNER TO postgres;




--Modifiche dopo call del 05/09
alter table evento_registrazione_bdu add column data_chiusura_sanzione timestamp without time zone;
alter table evento_registrazione_bdu add column utente_chiusura_sanzione integer;

drop view registro_sanzioni_proprietari_cani;

--select * from registro_sanzioni_proprietari_cani
CREATE OR REPLACE VIEW public.registro_sanzioni_proprietari_cani
AS SELECT DISTINCT a.id AS id_animale,
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
    case
    -- 1= proprietario
    -- 2= cedente in asl
    -- 3= cedente fuori asl
            WHEN (e_bdu.id_animale_madre IS NOT NULL AND e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario OR e_bdu.id_animale_madre IS NULL) AND (a.flag_mancata_origine IS FALSE OR a.flag_mancata_origine IS NULL) AND (e_bdu.flag_anagrafe_estera IS FALSE OR e_bdu.flag_anagrafe_estera IS NULL) and (asl_ced.description::text is not null) then '2'
            when (e_bdu.id_animale_madre IS NOT NULL AND e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario OR e_bdu.id_animale_madre IS NULL) AND (a.flag_mancata_origine IS FALSE OR a.flag_mancata_origine IS NULL) AND (e_bdu.flag_anagrafe_estera IS FALSE OR e_bdu.flag_anagrafe_estera IS NULL) and (asl_ced.description::text is null) then '3'
            WHEN a.flag_mancata_origine OR e_bdu.flag_anagrafe_estera THEN '1'::text
            ELSE NULL::text
        END AS soggetto_sanzionato_code
    
    
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
     LEFT JOIN controlli_ufficiali_proprietari_cani cu ON cu.data_controllo >= e_bdu.data_registrazione AND cu.microchip = a.microchip::text AND cu.cf_proprietario =
        CASE
            WHEN (e_bdu.id_animale_madre IS NOT NULL AND e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario OR e_bdu.id_animale_madre IS NULL) AND (a.flag_mancata_origine IS FALSE OR a.flag_mancata_origine IS NULL) AND (e_bdu.flag_anagrafe_estera IS FALSE OR e_bdu.flag_anagrafe_estera IS NULL) THEN upper(COALESCE(opu_rel_prov.codice_fiscale, opu_rel_prov_origine.codice_fiscale::text, e_bdu.codice_fiscale_proprietario_provenienza))
            WHEN a.flag_mancata_origine OR e_bdu.flag_anagrafe_estera THEN upper(opu_rel.codice_fiscale)
            ELSE NULL::text
        END
  WHERE a.trashed_date IS NULL AND a.data_cancellazione IS NULL AND a.id_specie = 1;


drop function public.esiste_registro_sanzione_proprietario( integer);

drop function public.esiste_registro_sanzione( integer);

CREATE OR REPLACE FUNCTION public.esiste_registro_sanzione(id_animale_ integer)
  RETURNS TABLE(cedente boolean, proprietario boolean,flag_mancata_origine_return boolean,flag_anagrafe_estera_return boolean) AS



$BODY$

 BEGIN
    
   RETURN QUERY     
 

select sanzione_cedente, sanzione_proprietario and id_cu is null,flag_mancata_origine,flag_anagrafe_estera from public.get_registro_sanzioni(id_animale_,-1,'Aperta');

 

 END;
$BODY$
  LANGUAGE plpgsql  STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION public.esiste_registro_sanzione(integer)
  OWNER TO postgres;



--select * from get_registro_sanzioni( -1,  204, null)
 DROP FUNCTION get_registro_sanzioni(integer,integer);
  DROP FUNCTION get_registro_sanzioni(integer,integer,text);
 
CREATE OR REPLACE FUNCTION public.get_registro_sanzioni(id_animale_ integer, id_asl_ integer, stato_in text)
 RETURNS TABLE(id_animale integer, microchip text, tatuaggio text, id_proprietario integer, proprietario text, id_asl_proprietario integer, id_asl_cedente integer, asl_cedente text, asl_proprietario text, id_proprietario_provenienza integer, proprietario_provenienza text, id_evento integer, data_inserimento_registrazione timestamp without time zone, data_registrazione timestamp without time zone, data_nascita timestamp without time zone, utente_inserimento text, razza text, data_chiusura timestamp without time zone, utente_chiusura text, id_cu integer, sanzione_cedente boolean, sanzione_proprietario boolean, stato text, soggetto_sanzionato text, id_animale_madre integer, microchip_madre text, numero_sanzione text, flag_mancata_origine boolean, flag_anagrafe_estera boolean,stato_apertura boolean,soggetto_sanzionato_code text)
 LANGUAGE plpgsql
 STRICT
AS $function$

 BEGIN
    
   RETURN QUERY     
 
    select * from registro_sanzioni_proprietari_cani reg
			where (id_animale_ = -1 or reg.id_animale = id_animale_) and ( id_asl_ = -1 or 
			                                                               (reg.id_asl_proprietario = id_asl_ and reg.sanzione_proprietario) or
			                                                               (reg.id_asl_cedente = id_asl_ and reg.sanzione_cedente and reg.id_asl_cedente  >=201 and reg.id_asl_cedente <=207) or
			                                                               (reg.id_asl_proprietario = id_asl_ and reg.sanzione_cedente and reg.id_asl_cedente  is null)
			                                                             ) 
			                                                             and (stato_in = 'Tutti' or reg.stato = stato_in)
			order by data_registrazione;
 

 END;
$function$
;


-- NUOVA VERSIONE 23/10--



-- public.registro_sanzioni_proprietari_cani source

CREATE OR REPLACE VIEW public.registro_sanzioni_proprietari_cani
AS SELECT DISTINCT a.id AS id_animale,
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
     LEFT JOIN controlli_ufficiali_proprietari_cani cu ON cu.data_controllo >= e_bdu.data_registrazione AND cu.microchip = a.microchip::text AND cu.cf_proprietario =
        CASE
            WHEN (e_bdu.id_animale_madre IS NOT NULL AND e_bdu.id_proprietario_provenienza <> e_bdu.id_proprietario OR e_bdu.id_animale_madre IS NULL) AND (a.flag_mancata_origine IS FALSE OR a.flag_mancata_origine IS NULL) AND (e_bdu.flag_anagrafe_estera IS FALSE OR e_bdu.flag_anagrafe_estera IS NULL) THEN upper(COALESCE(opu_rel_prov.codice_fiscale, opu_rel_prov_origine.codice_fiscale::text, e_bdu.codice_fiscale_proprietario_provenienza))
            WHEN a.flag_mancata_origine OR e_bdu.flag_anagrafe_estera THEN upper(opu_rel.codice_fiscale)
            ELSE NULL::text
        END
     LEFT JOIN comuni1 c ON opu_rel.comune = c.id
     LEFT JOIN comuni1 c1 ON opu_rel_prov.comune = c1.id
  WHERE a.trashed_date IS NULL AND a.data_cancellazione IS NULL AND a.id_specie = 1;
  
  
  
  
  drop function public.get_registro_sanzioni( integer,  integer,  text);
  CREATE OR REPLACE FUNCTION public.get_registro_sanzioni(id_animale_ integer, id_asl_ integer, stato_in text)
 RETURNS TABLE(id_animale integer, microchip text, tatuaggio text, id_proprietario integer, proprietario text, id_asl_proprietario integer, id_asl_cedente integer, asl_cedente text, asl_proprietario text, id_proprietario_provenienza integer, proprietario_provenienza text, id_evento integer, data_inserimento_registrazione timestamp without time zone, data_registrazione timestamp without time zone, data_nascita timestamp without time zone, utente_inserimento text, razza text, data_chiusura timestamp without time zone, utente_chiusura text, id_cu integer, sanzione_cedente boolean, sanzione_proprietario boolean, stato text, soggetto_sanzionato text, id_animale_madre integer, microchip_madre text, numero_sanzione text, flag_mancata_origine boolean, flag_anagrafe_estera boolean, stato_apertura boolean, soggetto_sanzionato_code text,comune_proprietario varchar(100), comune_proprietario_provenienza varchar(100))
 LANGUAGE plpgsql
 STRICT
AS $function$

 BEGIN
    
   RETURN QUERY     
 
    select * from registro_sanzioni_proprietari_cani reg
			where (id_animale_ = -1 or reg.id_animale = id_animale_) and ( id_asl_ = -1 or 
			                                                               (reg.id_asl_proprietario = id_asl_ and reg.sanzione_proprietario) or
			                                                               (reg.id_asl_cedente = id_asl_ and reg.sanzione_cedente and reg.id_asl_cedente  >=201 and reg.id_asl_cedente <=207) or
			                                                               (reg.id_asl_proprietario = id_asl_ and reg.sanzione_cedente and reg.id_asl_cedente  is null)
			                                                             ) 
			                                                             and (stato_in = 'Tutti' or reg.stato = stato_in)
			order by data_registrazione;
 

 END;
$function$
;


--GISA 

INSERT INTO public.lookup_norme
(code, description, default_item, "level", enabled, gruppo, view_diffida, ordinamento, note_hd, trashed_date, entered, ordinamento_old, ordinamento_new, ordinamento_backup, codice_tariffa, competenza_uod)
VALUES(296, 'D.L. vo n .134/2022', false, 98, true, false, false, 'E2BAAA', NULL, NULL, '2020-06-17 15:42:31.989', '2020-08-10 12:59:56.355599+02;ZA2;2021-03-05 15:10:08.899502+01;D2AAA;2021-03-06 18:02:35.748305+01;D2AAA;2021-03-06 18:08:36.853703+01;D2AAA;2021-03-06 18:09:12.773357+01;D2AAA;2021-03-19 12:00:15.922652+01;D2AAA;2021-03-19 12:02:15.503066+01;D2AAA;2021-03-19 12:03:52.012977+01;D2AAA;2021-05-07 12:27:08.174063+02;D2AAA;2021-05-07 12:50:58.522348+02;D2AAA;2021-05-07 12:52:25.631741+02;D2AAA;2021-05-07 12:54:39.793372+02;D2AAA;2021-05-07 13:13:19.158451+02;D2AAA;2021-05-07 15:01:42.464428+02;D2AAA;2021-05-08 19:28:50.396227+02;D3AAA;2021-05-08 19:31:11.789761+02;D3AAA;2021-05-08 19:47:03.718735+02;D3AAA;2021-05-08 19:49:06.089129+02;D3AAA;2021-05-08 19:50:53.436401+02;D3AAA;2021-05-08 19:51:20.637789+02;D4AAA;2021-05-08 19:51:37.695186+02;D4AAA;2021-05-08 19:52:10.58814+02;D4AAA;2021-05-08 19:52:21.076847+02;D4AAA;2021-05-08 19:53:06.194598+02;D4AAA;2021-05-08 19:53:19.700038+02;D4AAA;2021-05-08 19:54:40.047146+02;D4AAA;2021-05-08 19:54:55.055278+02;D4AAA;2021-05-08 20:11:57.948493+02;D4AAA;2021-05-08 20:12:26.696524+02;D5AAA;2021-05-08 20:12:40.522691+02;D5AAA;2021-05-08 20:22:48.795727+02;D5AAA;2021-05-08 20:23:12.631437+02;D6AAA;2021-05-08 20:25:25.611459+02;D6AAA;2021-05-08 20:39:07.181015+02;D6AAA;2021-05-08 21:25:10.439704+02;D6AAA;2021-05-08 21:28:27.853292+02;D6AAA;2021-05-08 21:37:29.218071+02;D6AAA;2021-05-08 21:44:08.320023+02;D6AAA;2021-05-08 21:44:39.422281+02;D6AAA;2021-05-08 21:50:45.355599+02;D6AAA;2021-05-08 22:00:10.005041+02;D6AAA;2021-05-08 22:04:18.06702+02;D6AAA;2021-05-08 22:04:54.328371+02;D6AAA;2021-05-08 22:05:48.050545+02;D6AAA;2021-05-08 22:06:01.77392+02;D6AAA;2021-05-08 22:06:16.206535+02;D6AAA;2021-05-08 22:06:39.023547+02;D6AAA;2021-05-08 22:16:08.378449+02;D6AAA;2021-05-08 22:17:16.075315+02;D6AAA;2021-05-08 22:19:41.285494+02;D6AAA;2021-05-08 22:20:07.607179+02;D6AAA;2021-05-08 22:24:08.719185+02;D6AAA;2021-05-08 22:26:05.685954+02;D6AAA;2021-05-08 22:30:47.370019+02;D6AAA;2021-05-08 22:34:13.174655+02;D6AAA;2021-05-08 22:35:14.864606+02;D6AAA;2021-05-08 22:39:56.794393+02;D6AAA;2021-05-08 22:43:08.908769+02;D6AAA;2021-05-08 22:53:43.11662+02;D6AAA;2021-05-08 22:54:01.56012+02;D7AAA;2021-05-08 23:05:27.912513+02;D7AAA;2021-05-08 23:05:59.897997+02;D7AAA;2021-05-09 10:04:33.865454+02;D7AAA;2021-05-09 10:05:04.23625+02;D8AAA;2021-05-09 10:05:56.372836+02;D8AAA;2021-05-09 10:06:33.599843+02;D8AAA;2021-05-09 10:07:13.88191+02;D8AAA;2021-05-09 10:07:57.391042+02;D8AAA;2021-05-09 10:08:41.229722+02;D8AAA;2021-05-09 10:09:29.277008+02;D8AAA;2021-05-09 10:09:51.253648+02;D8AAA;2021-05-09 10:10:15.219203+02;D8AAA;2021-05-09 10:10:31.350813+02;D8AAA;2021-05-09 10:10:44.137534+02;D8AAA;2021-05-09 10:10:58.715637+02;D8AAA;2021-05-09 10:11:13.591799+02;D8AAA;2021-05-09 10:11:27.447012+02;D8AAA;2021-05-17 19:51:02.214243+02;D8AAA;2021-05-18 10:52:05.78508+02;D8AAA;2021-05-18 10:52:48.733296+02;D8AAA;2021-05-18 16:43:28.95691+02;D8AAA;2021-05-18 16:43:59.534497+02;D9AAA;2021-05-18 16:46:33.419638+02;D9AAA;2021-05-18 17:05:17.695416+02;D9AAA;2021-05-18 17:17:39.833698+02;D9AAA;2021-05-18 17:53:10.298989+02;D9AAA;2021-05-18 17:55:50.742047+02;D9AAA;2021-05-18 17:57:52.340594+02;D9AAA;2021-05-18 18:00:10.901198+02;D9AAA;2021-05-18 18:02:04.898467+02;D9AAA;2021-05-22 19:22:10.616671+02;D9AAA;2021-05-25 17:01:50.817852+02;D9AAA;2021-05-25 17:06:11.558595+02;E1AAA;2021-05-25 17:08:10.048725+02;E1AAA;2021-05-25 17:13:10.511043+02;E1AAA;2021-05-25 17:27:18.544419+02;E1AAA;2021-05-25 17:32:03.219241+02;E1AAAA;2021-05-25 17:32:25.503793+02;E1AAAAA;2021-05-25 18:07:43.181615+02;E1AAAAA;2021-05-25 18:08:18.713882+02;E1AAAAA;2021-05-25 18:09:15.144611+02;E1AAAAA;2021-05-25 18:09:59.618911+02;E1AAAAA;2021-05-25 18:10:14.860134+02;E1AAAAA;2021-05-25 18:10:31.401828+02;E1AAAAA;2021-05-25 18:11:12.924354+02;E1AAAAA;2021-05-25 18:11:53.248656+02;E1AAAAA;2021-05-25 18:12:25.377517+02;E1AAAAA;2021-05-25 18:12:54.58917+02;E1AAAAA;2021-05-29 08:47:56.754621+02;E1AAAAA;2021-05-29 09:02:17.284304+02;E1AAAAA;2021-05-29 09:14:37.957467+02;E1AAAAA;2021-05-29 09:23:15.885811+02;E1AAAAA;2021-05-29 09:25:11.349376+02;E1AAAAA;2021-05-29 09:31:41.472523+02;E1AAAAA;2021-05-29 09:36:14.270702+02;E1AAAAA;2021-05-29 09:53:08.46825+02;E1AAAAA;2021-05-29 10:06:53.330785+02;E1AAAAA;2021-05-29 10:38:26.79718+02;E1AAAAA;2021-05-29 10:52:56.561963+02;E1AAAAA;2021-05-29 11:12:11.916432+02;E1AAAAA;2021-05-29 11:13:31.824937+02;E1AAAAA;2021-05-29 11:14:26.518304+02;E1AAAAA;2021-05-29 11:15:44.144064+02;E1AAAAA;2021-05-29 11:16:53.37531+02;E1AAAAA;2021-05-29 11:17:42.878808+02;E1AAAAA;2021-05-29 11:25:21.639247+02;E1AAAAA;2021-05-29 11:27:15.034277+02;E1AAAAA;2021-05-29 11:30:36.703066+02;E1AAAAA;2021-05-29 11:36:06.500534+02;E1AAAAA;2021-05-29 12:04:51.646402+02;E1AAAAA;2021-05-29 12:12:42.87299+02;E1AAAAA;2021-05-29 12:23:21.242756+02;E1AAAAA;2021-05-29 12:23:47.382135+02;E1AAAAA;2021-05-29 13:04:33.29908+02;E1AAAAA;2021-05-29 13:16:13.555656+02;E1AAAAA;2021-05-30 15:56:03.161883+02;E1AAAAA;2021-05-30 16:02:53.059092+02;E1AAAAA;2021-05-30 16:29:42.222632+02;E1AAAAA;2021-05-30 16:40:24.448331+02;E1AAAAA;2021-05-30 16:41:12.556282+02;E1AAAAA;2021-05-30 16:43:00.136818+02;E1AAAAA;2021-05-30 16:47:19.646+02;E1AAAAA;2021-05-30 16:49:56.593347+02;E1AAAAA;2021-05-30 16:51:35.899288+02;E1AAAAA;2021-05-30 16:52:02.432027+02;E1AAAAA;2021-05-30 16:53:49.501877+02;E1AAAAA;2021-05-30 16:54:59.250222+02;E1AAAAA;2021-05-30 16:55:26.292745+02;E1AAAAA;2021-05-30 16:55:44.036278+02;E1AAAAA;2021-05-30 16:56:12.499056+02;E1AAAAA;2021-05-30 16:56:35.076839+02;E1AAAAA;2021-05-30 17:00:40.815825+02;E1AAAAA;2021-05-30 17:05:42.485706+02;E1AAAAA;2021-05-30 20:05:16.491044+02;E1AAAAA;2021-05-30 20:05:43.133147+02;E1AAAAA;2021-05-30 20:10:36.85244+02;E1AAAAA;2021-05-30 20:11:09.273029+02;E1AAAAA;2021-05-30 20:20:01.002103+02;E1AAAAA;2021-05-30 20:27:23.62016+02;E1AAAAA;2021-05-30 20:27:58.440261+02;E1AAAAA;2021-05-30 20:43:46.787222+02;E1AAAAA;2021-05-30 20:44:47.187327+02;E1AAAAA;2021-05-30 21:06:31.668817+02;E1AAAAA;2021-05-30 21:07:37.953667+02;E1AAAAA;2021-05-30 21:08:09.529542+02;E1AAAAA;2021-05-30 21:08:41.221633+02;E1AAAAA;2021-05-30 21:16:24.929632+02;E1AAAAA;2021-05-30 21:17:28.665592+02;E1AAAAA;2021-05-30 21:20:35.877789+02;E1AAAAA;2021-05-30 21:28:20.73132+02;E1AAAAAA;2021-05-30 21:43:19.26452+02;E1AAAAAA;2021-05-30 21:43:58.335417+02;E1AAAAAA;2021-05-30 21:44:20.833054+02;E1AAAAAA;2021-05-30 21:44:48.769374+02;E1AAAAAA;2021-05-30 21:47:10.040842+02;E1AAAAAA;2021-05-30 21:49:22.743927+02;E1AAAAAA;2021-05-30 21:49:39.666284+02;E1AAAAAA;2021-05-30 21:49:55.95301+02;E1AAAAAA;2021-05-30 21:50:13.189766+02;E1AAAAAA;2021-05-30 21:50:25.761836+02;E1AAAAAA;2021-05-30 21:50:40.416249+02;E1AAAAAA;2021-05-30 21:50:56.837884+02;E1AAAAAA;2021-05-30 21:51:11.749078+02;E1AAAAAA;2021-05-30 21:51:27.841136+02;E1AAAAAA;2021-05-30 21:51:42.119317+02;E1AAAAAA;2021-05-30 21:57:00.61333+02;E1AAAAAA;2021-05-30 22:04:13.47237+02;E1AAAAAA;2021-05-30 22:04:37.551842+02;E1AAAAAA;2021-05-30 22:09:40.819609+02;E1AAAAAA;2021-05-30 22:10:03.622361+02;E2AAAAAA;2021-05-31 12:30:22.973761+02;E2AAAAAA;2021-10-11 13:06:31.713129+02;E2AAAAAA;2021-10-11 13:07:31.899531+02;E2AAAAAAA;2021-10-11 13:09:03.89513+02;E2AAAAAAAA;2021-11-04 11:41:53.510883+01;E2AAAAAAAAA;2021-11-04 11:42:42.4425+01;E2AAAAAAAAA;2022-01-09 12:46:08.541137+01;E2AAAAAAAAA;2022-01-25 11:30:03.428819+01;E2AAAAAAAAA;2022-03-28 13:06:18.759003+02;E2AAAAAAAAA;2022-04-25 12:25:56.078477+02;E2AAAAAAAAA;2022-05-20 16:02:29.920845+02;E2AAAAAAAAA;2022-05-20 16:03:26.727984+02;E2AAAAAAAAA;2022-05-27 15:03:31.693699+02;E2AAAAAAAAA;2022-05-27 15:05:37.236843+02;E2AAAAAAAAAA;2022-07-21 11:27:29.369805+02;E2BA;2022-09-20 08:00:32.431964+02;E2BA;2022-09-28 14:41:04.348921+02;E2BAA;2022-10-07 08:54:49.064759+02;E2BAAA;2022-11-02 09:38:41.02707+01;E2BAAA;2022-11-02 09:43:18.340265+01;E2BAAA;2022-11-02 09:44:22.638728+01;E2BAAA;2022-11-02 09:45:10.382244+01;E2BAAA;2022-11-02 09:45:26.118638+01;E2BAAA;2022-11-02 09:45:59.210294+01;E2BAAA;2022-11-15 15:39:47.611308+01;E2BAAA;2022-11-15 15:40:54.339597+01;E2BAAA;2022-11-15 15:44:37.76288+01;E2BAAA;2022-11-15 15:45:14.887802+01;E2BAAA;2022-11-15 15:46:07.565443+01;E2BAAA;2022-11-15 15:46:55.770935+01;E2BAAA;2022-11-15 15:51:58.613826+01;E2BAAA;2022-11-15 15:53:02.072832+01;E2BAAA;2022-11-15 15:54:41.70539+01;E2BAAA;2022-11-15 15:56:22.042391+01;E2BAAA;2022-11-15 15:58:30.576585+01;E2BAAA;2022-11-15 16:05:44.893335+01;E2BAAA;2022-12-15 13:11:30.367318+01;E2BAAA;2023-01-03 12:33:38.727413+01;E2BAAA', 'E2BAAA', 'ZA2', '2040', true);
INSERT INTO public.lookup_norme
(code, description, default_item, "level", enabled, gruppo, view_diffida, ordinamento, note_hd, trashed_date, entered, ordinamento_old, ordinamento_new, ordinamento_backup, codice_tariffa, competenza_uod)
VALUES(297, 'L. n. 201/2010', false, 98, true, false, false, 'E2BAAA', NULL, NULL, '2020-06-17 15:42:31.989', '2020-08-10 12:59:56.355599+02;ZA2;2021-03-05 15:10:08.899502+01;D2AAA;2021-03-06 18:02:35.748305+01;D2AAA;2021-03-06 18:08:36.853703+01;D2AAA;2021-03-06 18:09:12.773357+01;D2AAA;2021-03-19 12:00:15.922652+01;D2AAA;2021-03-19 12:02:15.503066+01;D2AAA;2021-03-19 12:03:52.012977+01;D2AAA;2021-05-07 12:27:08.174063+02;D2AAA;2021-05-07 12:50:58.522348+02;D2AAA;2021-05-07 12:52:25.631741+02;D2AAA;2021-05-07 12:54:39.793372+02;D2AAA;2021-05-07 13:13:19.158451+02;D2AAA;2021-05-07 15:01:42.464428+02;D2AAA;2021-05-08 19:28:50.396227+02;D3AAA;2021-05-08 19:31:11.789761+02;D3AAA;2021-05-08 19:47:03.718735+02;D3AAA;2021-05-08 19:49:06.089129+02;D3AAA;2021-05-08 19:50:53.436401+02;D3AAA;2021-05-08 19:51:20.637789+02;D4AAA;2021-05-08 19:51:37.695186+02;D4AAA;2021-05-08 19:52:10.58814+02;D4AAA;2021-05-08 19:52:21.076847+02;D4AAA;2021-05-08 19:53:06.194598+02;D4AAA;2021-05-08 19:53:19.700038+02;D4AAA;2021-05-08 19:54:40.047146+02;D4AAA;2021-05-08 19:54:55.055278+02;D4AAA;2021-05-08 20:11:57.948493+02;D4AAA;2021-05-08 20:12:26.696524+02;D5AAA;2021-05-08 20:12:40.522691+02;D5AAA;2021-05-08 20:22:48.795727+02;D5AAA;2021-05-08 20:23:12.631437+02;D6AAA;2021-05-08 20:25:25.611459+02;D6AAA;2021-05-08 20:39:07.181015+02;D6AAA;2021-05-08 21:25:10.439704+02;D6AAA;2021-05-08 21:28:27.853292+02;D6AAA;2021-05-08 21:37:29.218071+02;D6AAA;2021-05-08 21:44:08.320023+02;D6AAA;2021-05-08 21:44:39.422281+02;D6AAA;2021-05-08 21:50:45.355599+02;D6AAA;2021-05-08 22:00:10.005041+02;D6AAA;2021-05-08 22:04:18.06702+02;D6AAA;2021-05-08 22:04:54.328371+02;D6AAA;2021-05-08 22:05:48.050545+02;D6AAA;2021-05-08 22:06:01.77392+02;D6AAA;2021-05-08 22:06:16.206535+02;D6AAA;2021-05-08 22:06:39.023547+02;D6AAA;2021-05-08 22:16:08.378449+02;D6AAA;2021-05-08 22:17:16.075315+02;D6AAA;2021-05-08 22:19:41.285494+02;D6AAA;2021-05-08 22:20:07.607179+02;D6AAA;2021-05-08 22:24:08.719185+02;D6AAA;2021-05-08 22:26:05.685954+02;D6AAA;2021-05-08 22:30:47.370019+02;D6AAA;2021-05-08 22:34:13.174655+02;D6AAA;2021-05-08 22:35:14.864606+02;D6AAA;2021-05-08 22:39:56.794393+02;D6AAA;2021-05-08 22:43:08.908769+02;D6AAA;2021-05-08 22:53:43.11662+02;D6AAA;2021-05-08 22:54:01.56012+02;D7AAA;2021-05-08 23:05:27.912513+02;D7AAA;2021-05-08 23:05:59.897997+02;D7AAA;2021-05-09 10:04:33.865454+02;D7AAA;2021-05-09 10:05:04.23625+02;D8AAA;2021-05-09 10:05:56.372836+02;D8AAA;2021-05-09 10:06:33.599843+02;D8AAA;2021-05-09 10:07:13.88191+02;D8AAA;2021-05-09 10:07:57.391042+02;D8AAA;2021-05-09 10:08:41.229722+02;D8AAA;2021-05-09 10:09:29.277008+02;D8AAA;2021-05-09 10:09:51.253648+02;D8AAA;2021-05-09 10:10:15.219203+02;D8AAA;2021-05-09 10:10:31.350813+02;D8AAA;2021-05-09 10:10:44.137534+02;D8AAA;2021-05-09 10:10:58.715637+02;D8AAA;2021-05-09 10:11:13.591799+02;D8AAA;2021-05-09 10:11:27.447012+02;D8AAA;2021-05-17 19:51:02.214243+02;D8AAA;2021-05-18 10:52:05.78508+02;D8AAA;2021-05-18 10:52:48.733296+02;D8AAA;2021-05-18 16:43:28.95691+02;D8AAA;2021-05-18 16:43:59.534497+02;D9AAA;2021-05-18 16:46:33.419638+02;D9AAA;2021-05-18 17:05:17.695416+02;D9AAA;2021-05-18 17:17:39.833698+02;D9AAA;2021-05-18 17:53:10.298989+02;D9AAA;2021-05-18 17:55:50.742047+02;D9AAA;2021-05-18 17:57:52.340594+02;D9AAA;2021-05-18 18:00:10.901198+02;D9AAA;2021-05-18 18:02:04.898467+02;D9AAA;2021-05-22 19:22:10.616671+02;D9AAA;2021-05-25 17:01:50.817852+02;D9AAA;2021-05-25 17:06:11.558595+02;E1AAA;2021-05-25 17:08:10.048725+02;E1AAA;2021-05-25 17:13:10.511043+02;E1AAA;2021-05-25 17:27:18.544419+02;E1AAA;2021-05-25 17:32:03.219241+02;E1AAAA;2021-05-25 17:32:25.503793+02;E1AAAAA;2021-05-25 18:07:43.181615+02;E1AAAAA;2021-05-25 18:08:18.713882+02;E1AAAAA;2021-05-25 18:09:15.144611+02;E1AAAAA;2021-05-25 18:09:59.618911+02;E1AAAAA;2021-05-25 18:10:14.860134+02;E1AAAAA;2021-05-25 18:10:31.401828+02;E1AAAAA;2021-05-25 18:11:12.924354+02;E1AAAAA;2021-05-25 18:11:53.248656+02;E1AAAAA;2021-05-25 18:12:25.377517+02;E1AAAAA;2021-05-25 18:12:54.58917+02;E1AAAAA;2021-05-29 08:47:56.754621+02;E1AAAAA;2021-05-29 09:02:17.284304+02;E1AAAAA;2021-05-29 09:14:37.957467+02;E1AAAAA;2021-05-29 09:23:15.885811+02;E1AAAAA;2021-05-29 09:25:11.349376+02;E1AAAAA;2021-05-29 09:31:41.472523+02;E1AAAAA;2021-05-29 09:36:14.270702+02;E1AAAAA;2021-05-29 09:53:08.46825+02;E1AAAAA;2021-05-29 10:06:53.330785+02;E1AAAAA;2021-05-29 10:38:26.79718+02;E1AAAAA;2021-05-29 10:52:56.561963+02;E1AAAAA;2021-05-29 11:12:11.916432+02;E1AAAAA;2021-05-29 11:13:31.824937+02;E1AAAAA;2021-05-29 11:14:26.518304+02;E1AAAAA;2021-05-29 11:15:44.144064+02;E1AAAAA;2021-05-29 11:16:53.37531+02;E1AAAAA;2021-05-29 11:17:42.878808+02;E1AAAAA;2021-05-29 11:25:21.639247+02;E1AAAAA;2021-05-29 11:27:15.034277+02;E1AAAAA;2021-05-29 11:30:36.703066+02;E1AAAAA;2021-05-29 11:36:06.500534+02;E1AAAAA;2021-05-29 12:04:51.646402+02;E1AAAAA;2021-05-29 12:12:42.87299+02;E1AAAAA;2021-05-29 12:23:21.242756+02;E1AAAAA;2021-05-29 12:23:47.382135+02;E1AAAAA;2021-05-29 13:04:33.29908+02;E1AAAAA;2021-05-29 13:16:13.555656+02;E1AAAAA;2021-05-30 15:56:03.161883+02;E1AAAAA;2021-05-30 16:02:53.059092+02;E1AAAAA;2021-05-30 16:29:42.222632+02;E1AAAAA;2021-05-30 16:40:24.448331+02;E1AAAAA;2021-05-30 16:41:12.556282+02;E1AAAAA;2021-05-30 16:43:00.136818+02;E1AAAAA;2021-05-30 16:47:19.646+02;E1AAAAA;2021-05-30 16:49:56.593347+02;E1AAAAA;2021-05-30 16:51:35.899288+02;E1AAAAA;2021-05-30 16:52:02.432027+02;E1AAAAA;2021-05-30 16:53:49.501877+02;E1AAAAA;2021-05-30 16:54:59.250222+02;E1AAAAA;2021-05-30 16:55:26.292745+02;E1AAAAA;2021-05-30 16:55:44.036278+02;E1AAAAA;2021-05-30 16:56:12.499056+02;E1AAAAA;2021-05-30 16:56:35.076839+02;E1AAAAA;2021-05-30 17:00:40.815825+02;E1AAAAA;2021-05-30 17:05:42.485706+02;E1AAAAA;2021-05-30 20:05:16.491044+02;E1AAAAA;2021-05-30 20:05:43.133147+02;E1AAAAA;2021-05-30 20:10:36.85244+02;E1AAAAA;2021-05-30 20:11:09.273029+02;E1AAAAA;2021-05-30 20:20:01.002103+02;E1AAAAA;2021-05-30 20:27:23.62016+02;E1AAAAA;2021-05-30 20:27:58.440261+02;E1AAAAA;2021-05-30 20:43:46.787222+02;E1AAAAA;2021-05-30 20:44:47.187327+02;E1AAAAA;2021-05-30 21:06:31.668817+02;E1AAAAA;2021-05-30 21:07:37.953667+02;E1AAAAA;2021-05-30 21:08:09.529542+02;E1AAAAA;2021-05-30 21:08:41.221633+02;E1AAAAA;2021-05-30 21:16:24.929632+02;E1AAAAA;2021-05-30 21:17:28.665592+02;E1AAAAA;2021-05-30 21:20:35.877789+02;E1AAAAA;2021-05-30 21:28:20.73132+02;E1AAAAAA;2021-05-30 21:43:19.26452+02;E1AAAAAA;2021-05-30 21:43:58.335417+02;E1AAAAAA;2021-05-30 21:44:20.833054+02;E1AAAAAA;2021-05-30 21:44:48.769374+02;E1AAAAAA;2021-05-30 21:47:10.040842+02;E1AAAAAA;2021-05-30 21:49:22.743927+02;E1AAAAAA;2021-05-30 21:49:39.666284+02;E1AAAAAA;2021-05-30 21:49:55.95301+02;E1AAAAAA;2021-05-30 21:50:13.189766+02;E1AAAAAA;2021-05-30 21:50:25.761836+02;E1AAAAAA;2021-05-30 21:50:40.416249+02;E1AAAAAA;2021-05-30 21:50:56.837884+02;E1AAAAAA;2021-05-30 21:51:11.749078+02;E1AAAAAA;2021-05-30 21:51:27.841136+02;E1AAAAAA;2021-05-30 21:51:42.119317+02;E1AAAAAA;2021-05-30 21:57:00.61333+02;E1AAAAAA;2021-05-30 22:04:13.47237+02;E1AAAAAA;2021-05-30 22:04:37.551842+02;E1AAAAAA;2021-05-30 22:09:40.819609+02;E1AAAAAA;2021-05-30 22:10:03.622361+02;E2AAAAAA;2021-05-31 12:30:22.973761+02;E2AAAAAA;2021-10-11 13:06:31.713129+02;E2AAAAAA;2021-10-11 13:07:31.899531+02;E2AAAAAAA;2021-10-11 13:09:03.89513+02;E2AAAAAAAA;2021-11-04 11:41:53.510883+01;E2AAAAAAAAA;2021-11-04 11:42:42.4425+01;E2AAAAAAAAA;2022-01-09 12:46:08.541137+01;E2AAAAAAAAA;2022-01-25 11:30:03.428819+01;E2AAAAAAAAA;2022-03-28 13:06:18.759003+02;E2AAAAAAAAA;2022-04-25 12:25:56.078477+02;E2AAAAAAAAA;2022-05-20 16:02:29.920845+02;E2AAAAAAAAA;2022-05-20 16:03:26.727984+02;E2AAAAAAAAA;2022-05-27 15:03:31.693699+02;E2AAAAAAAAA;2022-05-27 15:05:37.236843+02;E2AAAAAAAAAA;2022-07-21 11:27:29.369805+02;E2BA;2022-09-20 08:00:32.431964+02;E2BA;2022-09-28 14:41:04.348921+02;E2BAA;2022-10-07 08:54:49.064759+02;E2BAAA;2022-11-02 09:38:41.02707+01;E2BAAA;2022-11-02 09:43:18.340265+01;E2BAAA;2022-11-02 09:44:22.638728+01;E2BAAA;2022-11-02 09:45:10.382244+01;E2BAAA;2022-11-02 09:45:26.118638+01;E2BAAA;2022-11-02 09:45:59.210294+01;E2BAAA;2022-11-15 15:39:47.611308+01;E2BAAA;2022-11-15 15:40:54.339597+01;E2BAAA;2022-11-15 15:44:37.76288+01;E2BAAA;2022-11-15 15:45:14.887802+01;E2BAAA;2022-11-15 15:46:07.565443+01;E2BAAA;2022-11-15 15:46:55.770935+01;E2BAAA;2022-11-15 15:51:58.613826+01;E2BAAA;2022-11-15 15:53:02.072832+01;E2BAAA;2022-11-15 15:54:41.70539+01;E2BAAA;2022-11-15 15:56:22.042391+01;E2BAAA;2022-11-15 15:58:30.576585+01;E2BAAA;2022-11-15 16:05:44.893335+01;E2BAAA;2022-12-15 13:11:30.367318+01;E2BAAA;2023-01-03 12:33:38.727413+01;E2BAAA', 'E2BAAA', 'ZA2', '2040', true);




--Disattivazione in collaudo
--Permessi BDU
delete from role_permission where permission_id in (select permission_id from permission where permission = 'registro_sanzioni');

delete from configurazione_tracciabilita_cani;

--Riattivazione in collaudo
--Permessi BDU
insert into role_permission(role_id,permission_id,role_view) values(1,(select permission_id from permission where permission = 'registro_sanzioni'),true);
insert into role_permission(role_id,permission_id,role_view) values(20,(select permission_id from permission where permission = 'registro_sanzioni'),true);
insert into role_permission(role_id,permission_id,role_view) values(18,(select permission_id from permission where permission = 'registro_sanzioni'),true);
insert into role_permission(role_id,permission_id,role_view) values(5,(select permission_id from permission where permission = 'registro_sanzioni'),true);
insert into role_permission(role_id,permission_id,role_view) values(6,(select permission_id from permission where permission = 'registro_sanzioni'),true);
insert into role_permission(role_id,permission_id,role_view) values(34,(select permission_id from permission where permission = 'registro_sanzioni'),true);
insert into configurazione_tracciabilita_cani(data_inizio) values(current_timestamp);

--Attivazione in ufficiale
--Permessi BDU
insert into role_permission(role_id,permission_id,role_view) values(1,(select permission_id from permission where permission = 'registro_sanzioni'),true);
insert into role_permission(role_id,permission_id,role_view) values(20,(select permission_id from permission where permission = 'registro_sanzioni'),true);
insert into role_permission(role_id,permission_id,role_view) values(18,(select permission_id from permission where permission = 'registro_sanzioni'),true);
insert into role_permission(role_id,permission_id,role_view) values(5,(select permission_id from permission where permission = 'registro_sanzioni'),true);
insert into role_permission(role_id,permission_id,role_view) values(6,(select permission_id from permission where permission = 'registro_sanzioni'),true);
insert into role_permission(role_id,permission_id,role_view) values(34,(select permission_id from permission where permission = 'registro_sanzioni'),true);

insert into configurazione_tracciabilita_cani(data_inizio) values(current_timestamp);