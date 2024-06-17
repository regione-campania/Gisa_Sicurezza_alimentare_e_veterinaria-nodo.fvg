--DROP FUNCTION get_modello_5(integer)
-- FUNCTION: public.get_modello_5(integer)

-- DROP FUNCTION IF EXISTS public.get_modello_5(integer);

CREATE OR REPLACE FUNCTION public.get_modello_5(
	_idcu integer)
    RETURNS TABLE(controllo_id integer, enteredby integer, entered timestamp without time zone, modifiedby integer, modified timestamp without time zone, id integer, bozza boolean, controllo_asl text, controllo_anno integer, controllo_mese text, controllo_giorno integer, controllo_ore text, controllo_nucleo text, controllo_oggetto text, controllo_piano text, controllo_attivita text, controllo_ncformali text, controllo_ncsignificative text, controllo_ncgravi text, controllo_ncformalipunti text, controllo_ncsignificativepunti text, controllo_ncgravipunti text, controllo_ncformalival text, controllo_ncsignificativeval text, stabilimento_comune text, stabilimento_indirizzo text, stabilimento_civico text, stabilimento_num_registrazione text, stabilimento_ce text, operatore_ragione_sociale text, operatore_comune text, operatore_indirizzo text, operatore_civico text, operatore_partita_iva text, rappresentante_nome text, rappresentante_comune_nascita text, rappresentante_data_nascita text, rappresentante_comune text, rappresentante_indirizzo text, rappresentante_civico text, rappresentante_domicilio_digitale text, controllo_linea text, controllo_data_fine text, header_servizio text, header_pec1 text, header_uo text, header_pec2 text, presente_nome text, presente_comune_nascita text, presente_data_nascita text, presente_comune text, presente_indirizzo text, presente_civico text, presente_documento text, presente_documento_numeri text, presente_modalita_ispezione text, responsabile_procedimento text, provvedimenti_non_imputabili text, nc_formali_giorni_risoluzione text, nc_significative_giorni_risoluzione text, nc_significative_ulteriore_ispezione text, nc_significative_prove_inviate text, nc_significative_verifica text, nc_significative_verifica_data text, nc_significative_verifica_ora text, nc_significative_verifica_piattaforma text, nc_significative_verifica_stanza text, nc_gravi_constestazione text, nc_gravi_accertamento text, nc_gravi_diffida text, nc_gravi_sequestro_amministrativo text, nc_gravi_sequestro_penale text, nc_gravi_blocco text, nc_gravi_dispone text, nc_gravi_constestazione_desc text, nc_gravi_diffida_desc text, nc_gravi_sequestro_amministrativo_desc text, nc_gravi_sequestro_penale_desc text, nc_gravi_blocco_desc text, nc_gravi_dispone_desc text, nc_gravi_diffida_eliminazione text, nc_gravi_diffida_eliminazione_numero text, valutazione_rischio text, presente_dichiarazione text, note text, ispezione_verifica text, azioni_descrizione text, nc_punteggio_totale text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
	 	
BEGIN

FOR controllo_id, enteredby, entered, modifiedby, modified, id, bozza, controllo_asl, controllo_anno, controllo_mese, controllo_giorno, controllo_ore, controllo_nucleo, controllo_oggetto, controllo_piano, controllo_attivita, controllo_ncformali, controllo_ncsignificative, controllo_ncgravi, controllo_ncformalipunti, controllo_ncsignificativepunti, controllo_ncgravipunti, controllo_ncformalival,  controllo_ncsignificativeval, stabilimento_comune, stabilimento_indirizzo, stabilimento_civico, stabilimento_num_registrazione, stabilimento_ce, operatore_ragione_sociale, operatore_comune, operatore_indirizzo, operatore_civico, operatore_partita_iva, rappresentante_nome, rappresentante_comune_nascita, rappresentante_data_nascita, rappresentante_comune, rappresentante_indirizzo, rappresentante_civico, rappresentante_domicilio_digitale, controllo_linea, controllo_data_fine, header_servizio,header_pec1,header_uo,header_pec2,presente_nome,presente_comune_nascita,presente_data_nascita,presente_comune, presente_indirizzo,presente_civico,presente_documento,presente_documento_numeri,presente_modalita_ispezione, responsabile_procedimento,
provvedimenti_non_imputabili, nc_formali_giorni_risoluzione, nc_significative_giorni_risoluzione, 
--new 08/09/22
nc_significative_ulteriore_ispezione,
nc_significative_prove_inviate,
nc_significative_verifica,
nc_significative_verifica_data,
nc_significative_verifica_ora,
nc_significative_verifica_piattaforma,
nc_significative_verifica_stanza,
--
nc_gravi_constestazione, 
nc_gravi_accertamento, nc_gravi_diffida, nc_gravi_sequestro_amministrativo, nc_gravi_sequestro_penale, nc_gravi_blocco, nc_gravi_dispone, 
nc_gravi_constestazione_desc, 
nc_gravi_diffida_desc, 
nc_gravi_sequestro_amministrativo_desc, nc_gravi_sequestro_penale_desc, nc_gravi_blocco_desc, nc_gravi_dispone_desc, 
--new 08/09/22
nc_gravi_diffida_eliminazione,
nc_gravi_diffida_eliminazione_numero,
--
valutazione_rischio, presente_dichiarazione, note, ispezione_verifica, azioni_descrizione , nc_punteggio_totale
		in

SELECT distinct
t.ticketid as controllo_id
,v.enteredby
,v.entered
,v.modifiedby
,v.modified
,v.id
,case when t.flag_mod5 = 'false' then false else true end as bozza
,asl.description as controllo_asl
,date_part('year', t.assigned_date) as controllo_anno
, CASE WHEN date_part('month', t.assigned_date)= 1 then 'GENNAIO' WHEN date_part('month', t.assigned_date)= 2 then 'FEBBRAIO' WHEN date_part('month', t.assigned_date)= 3 then 'MARZO' WHEN date_part('month', t.assigned_date)= 4 then 'APRILE' WHEN date_part('month', t.assigned_date)= 5 then 'MAGGIO' WHEN date_part('month', t.assigned_date)= 6 then 'GIUGNO' WHEN date_part('month', t.assigned_date)= 7 then 'LUGLIO' WHEN date_part('month', t.assigned_date)= 8 then 'AGOSTO' WHEN date_part('month', t.assigned_date)= 9 then 'SETTEMBRE' WHEN date_part('month', t.assigned_date)= 10 then 'OTTOBRE' WHEN date_part('month', t.assigned_date)= 11 then 'NOVEMBRE' WHEN date_part('month', t.assigned_date)= 12 then 'DICEMBRE' END as controllo_mese
, date_part('day', t.assigned_date) as controllo_giorno
,v.controllo_ore
,(select string_agg(CASE WHEN a.user_id > 0 THEN concat_ws(' ', c.namefirst, c.namelast) ELSE concat_ws(' ', ce.namefirst, ce.namelast) END, ', ') from cu_nucleo cun left join access_ a on a.user_id = cun.id_componente left join contact_ c on c.contact_id = a.contact_id left join access_ext_ ae on ae.user_id = cun.id_componente left join contact_ext_ ce on ce.contact_id = ae.contact_id where cun.id_controllo_ufficiale = _idcu) as controllo_nucleo
,(select CONCAT_WS(E'\n', string_agg(a.oggetti, E'\n'), (select
CONCAT( 
case when num_documento_accompagnamento <> '' then 'Num. Documento di Accompagnam. Controllati: '||num_documento_accompagnamento else '' end , 
case when num_specie1 > 0 or num_specie2 > 0 or num_specie3 > 0 or num_specie6 > 0 or num_specie5 > 0 or num_specie9 > 0 or num_specie14 > 0 or num_specie15 > 0 or num_specie22 > 0 or num_specie23 > 0 or num_specie24 > 0 or num_specie25 > 0 or num_specie26 > 0  then ' Specie controllate: ' else '' end ,
case when num_specie1 > 0 then ' Bovini: '||num_specie1 else '' end ,
case when num_specie2 > 0 then ' Suini: '||num_specie2 else '' end ,
case when num_specie3 > 0 then ' Equidi: '||num_specie3 else '' end ,
case when num_specie6 > 0 then ' Altre specie: '||num_specie6 else '' end ,
case when num_specie5 > 0 then ' Bufali: '||num_specie5 else '' end ,
case when num_specie9 > 0 then ' Conigli: '||num_specie9 else '' end ,
case when num_specie14 > 0 then ' Cani: '||num_specie14 else '' end ,
case when num_specie15 > 0 then ' Ovicaprini: '||num_specie15 else '' end ,
case when num_specie22 > 0 then ' Pollame: '||num_specie22 else '' end ,
case when num_specie23 > 0 then ' Pesci: '||num_specie23 else '' end ,
case when num_specie24 > 0 then ' Uccelli: '||num_specie24 else '' end ,
case when num_specie25 > 0 then ' Rettili: '||num_specie25 else '' end ,
case when num_specie26 > 0 then ' Altro: '||num_specie26 else '' end 
) from ticket where ticketid = _idcu)) FROM
(select concat_ws(' -> ', m.description,string_agg(i.description, ';')) as oggetti
from tipocontrolloufficialeimprese tcu
join lookup_ispezione i on i.code = tcu.ispezione and i.enabled
join lookup_ispezione_macrocategorie m on m.code = i.level and m.enabled
where tcu.idcontrollo  = _idcu and tcu.enabled group by m.description) a) as controllo_oggetto
, (select string_agg(p.short_description, E'\n') from tipocontrolloufficialeimprese tcu 
join lookup_piano_monitoraggio p on tcu.pianomonitoraggio = p.code
and tcu.idcontrollo = _idcu and tcu.enabled and tcu.pianomonitoraggio>0) as controllo_piano
, (select string_agg(concat_ws(' ', i.alias, i.description), E'\n') from tipocontrolloufficialeimprese tcu 
join lookup_tipo_ispezione i on tcu.tipoispezione = i.code
and tcu.idcontrollo = _idcu and tcu.enabled and tcu.pianomonitoraggio<0) as controllo_attivita
, (SELECT string_agg(CONCAT('[NC', aa.rnum,'] ', aa.note), ' ') from (SELECT nc.note,
    row_number() OVER () as rnum
  FROM salvataggio_nc_note nc where nc.idticket in (select ticketid from ticket where  id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and tipologia = 1) aa) as controllo_ncformali
, (SELECT string_agg(CONCAT('[NC', aa.rnum,'] ', aa.note), ' ') from (SELECT nc.note,
    row_number() OVER () as rnum
  FROM salvataggio_nc_note nc where nc.idticket in (select ticketid from ticket where  id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and tipologia = 2) aa) as controllo_ncsignificative
, (SELECT string_agg(CONCAT('[NC', aa.rnum,'] ', aa.note), ' ') from (SELECT nc.note,
    row_number() OVER () as rnum
  FROM salvataggio_nc_note nc where nc.idticket in (select ticketid from ticket where  id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and tipologia = 3) aa) as controllo_ncgravi
, (select puntiformali from ticket where ticketid in (select ticketid from ticket where id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and trashed_date is null) as controllo_ncformalipunti
, (select puntisignificativi from ticket where ticketid in (select ticketid from ticket where id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and trashed_date is null) as controllo_ncsignificativepunti
, (select puntigravi from ticket where ticketid in (select ticketid from ticket where id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and trashed_date is null) as controllo_ncgravipunti
, (select nc_formali_valutazione from ticket where ticketid in (select ticketid from ticket where id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and trashed_date is null) as controllo_ncformalival
, (select nc_significative_valutazione from ticket where ticketid in (select ticketid from ticket where id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and trashed_date is null) as controllo_ncsignificativeval
, r.comune as stabilimento_comune
,r.indirizzo as stabilimento_indirizzo
,COALESCE(opu_ind.civico, sin_ind.civico, org_ind.civico) as stabilimento_civico
,r.n_reg as stabilimento_num_registrazione
,v.stabilimento_ce
,r.ragione_sociale as operatore_ragione_sociale
,r.comune_leg as operatore_comune
,r.indirizzo_leg as operatore_indirizzo
,COALESCE(opu_ind_leg.civico, sin_ind_leg.civico, org_ind_leg.civico) as operatore_civico
,r.partita_iva as operatore_partita_iva
,r.nominativo_rappresentante as rappresentante_nome
,COALESCE(opu_sog.comune_nascita, sin_sog.comune_nascita) as rappresentante_comune_nascita
,to_char(COALESCE(opu_sog.data_nascita, sin_sog.data_nascita), 'dd/MM/yyyy') as rappresentante_data_nascita
,COALESCE(opu_com_sog.nome, sin_com_sog.nome) as rappresentante_comune
,COALESCE(opu_sog_ind.via, sin_sog_ind.via) as rappresentante_indirizzo
,COALESCE(opu_sog_ind.civico, sin_sog_ind.civico) as rappresentante_civico
,COALESCE(opu_sog.email, sin_sog.email) as rappresentante_domicilio_digitale
, (select linea_attivita from public.get_linee_attivita(r.riferimento_id, r.riferimento_id_nome_tab,false, _idcu))
 as controllo_linea
,case when t.data_fine_controllo is null then to_char(t.assigned_date, 'dd/MM/yyyy') else to_char(t.data_fine_controllo, 'dd/MM/yyyy')  end  as controllo_data_fine     
,v.header_servizio
,v.header_pec1
,v.header_uo
,v.header_pec2
,v.presente_nome
,v.presente_comune_nascita
,v.presente_data_nascita
,v.presente_comune
,v.presente_indirizzo
,v.presente_civico
,v.presente_documento
,v.presente_documento_numeri
,v.presente_modalita_ispezione
,v.responsabile_procedimento
,v.provvedimenti_non_imputabili
,v.nc_formali_giorni_risoluzione
,v.nc_significative_giorni_risoluzione
,v.nc_significative_ulteriore_ispezione
,v.nc_significative_prove_inviate
,v.nc_significative_verifica
,v.nc_significative_verifica_data
,v.nc_significative_verifica_ora
,v.nc_significative_verifica_piattaforma
,v.nc_significative_verifica_stanza
,v.nc_gravi_constestazione
,v.nc_gravi_accertamento
,v.nc_gravi_diffida
,v.nc_gravi_sequestro_amministrativo
,v.nc_gravi_sequestro_penale
,v.nc_gravi_blocco
,v.nc_gravi_dispone
,v.nc_gravi_constestazione_desc
,v.nc_gravi_diffida_desc
,v.nc_gravi_sequestro_amministrativo_desc
,v.nc_gravi_sequestro_penale_desc
,v.nc_gravi_blocco_desc
,v.nc_gravi_dispone_desc
,v.nc_gravi_diffida_eliminazione
,v.nc_gravi_diffida_eliminazione_numero
,v.valutazione_rischio
,v.presente_dichiarazione
,v.note
,v.ispezione_verifica
,v.azioni_descrizione
,v.nc_punteggio_totale

from ticket t
left join lookup_site_id asl on asl.code = t.site_id
left join ricerche_anagrafiche_old_materializzata r on 
((t.org_id > 0 and r.riferimento_id = t.org_id and r.riferimento_id_nome_tab = 'organization')
or (t.id_stabilimento > 0 and r.riferimento_id = t.id_stabilimento and r.riferimento_id_nome_tab = 'opu_stabilimento')
or (t.alt_id > 0 and r.riferimento_id = t.alt_id)
or (t.id_apiario > 0 and r.riferimento_id = t.id_apiario and r.riferimento_id_nome_tab='apicoltura_imprese'))
--left join linee_attivita_controlli_ufficiali lacu on lacu.id_controllo_ufficiale = t.ticketid
--left join ml8_linee_attivita_nuove_materializzata ml8 on ml8.codice_attivita = lacu.codice_linea
left join modello_5_values v on v.id_controllo = t.ticketid and v.trashed_date is null
left join opu_indirizzo opu_ind on opu_ind.id = r.id_sede_operativa and r.riferimento_id_nome_tab = 'opu_stabilimento'
left join sintesis_indirizzo sin_ind on sin_ind.id = r.id_sede_operativa and r.riferimento_id_nome_tab = 'sintesis_stabilimento'
left join organization_address org_ind on org_ind.address_id= r.id_sede_operativa and r.riferimento_id_nome_tab = 'organization'
left join opu_indirizzo opu_ind_leg on opu_ind_leg.id = r.id_indirizzo_impresa and r.riferimento_id_nome_tab = 'opu_stabilimento'
left join sintesis_indirizzo sin_ind_leg on sin_ind_leg.id = r.id_indirizzo_impresa and r.riferimento_id_nome_tab = 'sintesis_stabilimento'
left join organization_address org_ind_leg on org_ind_leg.address_id= r.id_indirizzo_impresa and r.riferimento_id_nome_tab = 'organization'
left join opu_soggetto_fisico opu_sog on opu_sog.id = r.id_soggetto_fisico and r.riferimento_id_nome_tab = 'opu_stabilimento'
left join sintesis_soggetto_fisico sin_sog on sin_sog.id = r.id_soggetto_fisico and r.riferimento_id_nome_tab = 'sintesis_stabilimento'
left join opu_indirizzo opu_sog_ind on opu_sog_ind.id = opu_sog.indirizzo_id
left join sintesis_indirizzo sin_sog_ind on sin_sog_ind.id = sin_sog.indirizzo_id
left join comuni1 opu_com_sog on opu_com_sog.id = opu_sog_ind.comune
left join comuni1 sin_com_sog on sin_com_sog.id = sin_sog_ind.comune
where t.ticketid = _idcu

 LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
    
 END;
$BODY$;

ALTER FUNCTION public.get_modello_5(integer)
    OWNER TO postgres;



alter TABLE  modello_5_values add column nc_gravi_diffida_eliminazione text;
alter TABLE  modello_5_values  add column nc_gravi_diffida_eliminazione_numero text;
alter TABLE  modello_5_values  add column nc_significative_ulteriore_ispezione text;
alter TABLE  modello_5_values  add column nc_significative_prove_inviate text;
alter TABLE  modello_5_values  add column nc_significative_verifica text;
alter TABLE  modello_5_values  add column nc_significative_verifica_data text;
alter TABLE  modello_5_values  add column nc_significative_verifica_ora text;
alter TABLE  modello_5_values  add column nc_significative_verifica_piattaforma text;
alter TABLE  modello_5_values  add column nc_significative_verifica_stanza text;


--select * from public.get_modello_5(1710760)
-- View: public.opu_operatori_denormalizzati_view

-- DROP VIEW public.opu_operatori_denormalizzati_view;

CREATE OR REPLACE VIEW public.opu_operatori_denormalizzati_view
 AS
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
    coalesce(o.tipo_impresa, o.tipo_societa) AS impresa_id_tipo_impresa,
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
    latt.codice_attivita AS codice_attivita_only
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

delete from ricerche_anagrafiche_old_materializzata  where riferimento_id_nome_tab='opu_stabilimento';
insert into ricerche_anagrafiche_old_materializzata (select * from ricerca_anagrafiche where riferimento_id_nome_tab = 'opu_stabilimento');
		

