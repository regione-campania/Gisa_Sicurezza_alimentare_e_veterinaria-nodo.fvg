-- Modifica tabella broiler

ALTER TABLE chk_bns_mod_ist_v6_broiler ADD COLUMN capacita_massima text;
alter table chk_bns_mod_ist_v6_broiler add column fase_produttiva text;

-- Modifica tabella conigli

ALTER TABLE chk_bns_mod_ist_v6_conigli add column gabbie_parchetto text;

-- Creazione viste per invio

CREATE VIEW bdn_checklist_v6_conigli AS
SELECT id_chk_bns_mod_ist, num_checklist, veterinario_ispettore, gabbie_parchetto, presenza_quarantena, vuoto_sanitario, presenza_manuale, veterinario_aziendale, num_animali_allevati, num_fattrici_morte, num_rimonte_morte, num_ingrasso_morti, num_fori_nido, num_fori_maschio, num_totale_capannoni, num_totale_capannoni_attivi, appartenente_condizionalita, criteri_utilizzati, criteri_utilizzati_altro_descrizione, esito_controllo, intenzionalita, evidenze, evidenze_tse, evidenze_ir, evidenze_sv, prescrizioni_descrizione, assegnate_prescrizioni, data_prescrizioni, sanz_blocco, sanz_amministrativa, sanz_abbattimento, sanz_sequestro, sanz_informativa, sanz_altro, sanz_altro_desc, note_controllore, note_proprietario, nome_proprietario, nome_controllore, eseguite_prescrizioni, prescrizioni_eseguite_descrizione, nome_proprietario_prescrizioni_eseguite, data_verifica, nome_controllore_prescrizioni_eseguite, data_chiusura_relazione, data_primo_controllo
FROM public.chk_bns_mod_ist_v6_conigli; 

CREATE VIEW bdn_checklist_v6_broiler AS
SELECT id_chk_bns_mod_ist, num_checklist, veterinario_ispettore, presenza_manuale, veterinario_aziendale, num_totale_capannoni, num_totale_capannoni_attivi, capannone_1_num, capannone_1_capacita, capannone_1_data, capannone_1_accasati, capannone_1_presenti, capannone_1_ispezionato, capannone_2_num, capannone_2_capacita, capannone_2_data, capannone_2_accasati, capannone_2_presenti, capannone_2_ispezionato, capannone_3_num, capannone_3_capacita, capannone_3_data, capannone_3_accasati, capannone_3_presenti, capannone_3_ispezionato, capannone_4_num, capannone_4_ispezionato, capannone_5_num, capannone_5_ispezionato, appartenente_condizionalita, criteri_utilizzati, criteri_utilizzati_altro_descrizione, esito_controllo, intenzionalita, evidenze, evidenze_tse, evidenze_ir, evidenze_sv, prescrizioni_descrizione, assegnate_prescrizioni, data_prescrizioni, sanz_blocco, sanz_amministrativa, sanz_abbattimento, sanz_sequestro, sanz_informativa, sanz_altro, sanz_altro_desc, note_controllore, note_proprietario, nome_proprietario, nome_controllore, eseguite_prescrizioni, prescrizioni_eseguite_descrizione, nome_proprietario_prescrizioni_eseguite, data_verifica, nome_controllore_prescrizioni_eseguite, data_chiusura_relazione, ibrido_razza_allevata, stima_capannone_1_num, stima_capannone_1_num_capi, stima_capannone_2_num, stima_capannone_2_num_capi, stima_capannone_3_num, stima_capannone_3_num_capi, data_primo_controllo, capacita_massima, fase_produttiva
	FROM public.chk_bns_mod_ist_v6_broiler;
	
-- Nuova vista bdn_chiusi che coinvolge anche isConigli

-- View: public.bdn_cu_chiusi_benessere_animale

-- DROP VIEW public.bdn_cu_chiusi_benessere_animale;

CREATE OR REPLACE VIEW public.bdn_cu_chiusi_benessere_animale
 AS
 SELECT DISTINCT ist.id_alleg,
    ist.id_bdn,
    specie.short_description_ba AS codice_specie_chk_bns,
    o.name AS ragione_sociale,
    o.org_id,
    ticket.ticketid AS id_controllo,
    ticket.assigned_date AS data_controllo,
    concat('R', ticket.site_id) AS codice_asl,
    upper(o.account_number::text) AS codice_azienda,
    COALESCE(btrim(o.partita_iva::text), btrim(o.codice_fiscale_rappresentante::text)) AS id_fiscale_allevamento,
        CASE
            WHEN ROW(nucleo.nucleo_ispettivo, nucleo.nucleo_ispettivo_due, nucleo.nucleo_ispettivo_tre, nucleo.nucleo_ispettivo_quattro, nucleo.nucleo_ispettivo_cinque, nucleo.nucleo_ispettivo_sei, nucleo.nucleo_ispettivo_sette, nucleo.nucleo_ispettivo_otto, nucleo.nucleo_ispettivo_nove, nucleo.nucleo_ispettivo_dieci)::text ~~* '%nas_%'::text THEN '001'::text
            WHEN ROW(nucleo.nucleo_ispettivo, nucleo.nucleo_ispettivo_due, nucleo.nucleo_ispettivo_tre, nucleo.nucleo_ispettivo_quattro, nucleo.nucleo_ispettivo_cinque, nucleo.nucleo_ispettivo_sei, nucleo.nucleo_ispettivo_sette, nucleo.nucleo_ispettivo_otto, nucleo.nucleo_ispettivo_nove, nucleo.nucleo_ispettivo_dieci)::text ~~* '%forestale%'::text THEN '002'::text
            ELSE '003'::text
        END AS occodice,
    false AS flag_cee,
        CASE
            WHEN ticket.closed IS NULL THEN 'APERTO'::text
            WHEN ticket.closed_nolista THEN 'CHIUSO SENZA LISTA PER ASSENZA DI NON CONFORMITA'''::text
            ELSE 'CHIUSO'::text
        END AS stato,
    o.cf_correntista::text AS id_fiscale_detentore,
    op.tipo_produzione_ba,
        CASE
            WHEN op.codice_orientamento_ba IS NOT NULL THEN op.codice_orientamento_ba
            ELSE ''::text
        END AS codice_orientamento_ba,
    ist.data_import,
    ist.esito_import,
    ist.descrizione_errore,
    o.specie_allev,
    lcm.tipo_allegato_bdn AS tipo_allegato,
        CASE
            WHEN o.specie_allev::text !~~* 'pesci'::text THEN '0'::text || o.specie_allevamento::text
            ELSE 'PES'::text
        END AS specie_allevamento,
        CASE
            WHEN lcm.codice_checklist = 'isVitelli'::text THEN 'S'::text
            ELSE 'N'::text
        END AS flag_vitelli,
        CASE
            WHEN (o.specie_allev::text ~~* 'gallus'::text OR o.specie_allev::text ~~* 'oche'::text OR o.specie_allev::text ~~* 'fagiani'::text OR o.specie_allev::text ~~* 'conigli'::text) AND o.codice_tipo_allevamento IS NOT NULL THEN o.codice_tipo_allevamento
            ELSE '11'::text
        END AS tipo_allevamento_codice,
        CASE
            WHEN ticket.flag_preavviso IS NULL OR ticket.flag_preavviso = '-1'::text THEN 'N'::text
            ELSE ticket.flag_preavviso
        END AS flag_preavviso,
    ticket.data_preavviso_ba AS data_preavviso,
    ist.id AS id_chk_bns_mod_ist,
    ticket.flag_checklist,
    lcm.description AS nome_checklist,
    o.codice_fiscale_rappresentante AS id_fiscale_proprietario,
    lcm.codice_checklist
   FROM ticket
     JOIN organization o ON ticket.org_id = o.org_id AND o.tipologia = 2 AND o.account_number IS NOT NULL AND o.trashed_date IS NULL
     LEFT JOIN lookup_site_id asl ON asl.code = o.asl_old
     LEFT JOIN orientamenti_produttivi op ON op.specie_allevata = o.specie_allev::text AND op.descrizione_tipo_produzione = o.tipologia_strutt AND o.orientamento_prod = op.descrizione_codice_orientamento
     LEFT JOIN lookup_specie_allevata specie ON specie.description::text = o.specie_allev::text
     JOIN tipocontrolloufficialeimprese tipi ON ticket.ticketid = tipi.idcontrollo AND tipi.enabled AND tipi.pianomonitoraggio > 0
     JOIN lookup_piano_monitoraggio lp ON lp.code = tipi.pianomonitoraggio
     JOIN rel_motivi_eventi_cu rel ON rel.cod_raggrup_ind = lp.codice_interno_univoco
     JOIN lookup_eventi_motivi_cu ev ON ev.code = rel.id_evento_cu AND ev.codice_evento::text = 'isBenessereAnimale'::text
     LEFT JOIN nucleo_ispettivo_mv nucleo ON nucleo.id_controllo_ufficiale = ticket.ticketid
     JOIN chk_bns_mod_ist ist ON ist.idcu = ticket.ticketid AND ist.trashed_date IS NULL AND ist.bozza IS FALSE AND (ist.esito_import IS NULL OR ist.esito_import = ''::text OR ist.esito_import ~~* '%KO%'::text)
     JOIN lookup_chk_bns_mod lcm ON lcm.code = ist.id_alleg AND (lcm.codice_checklist IS NULL OR (lcm.codice_checklist = ANY (ARRAY['isBoviniBufalini'::text, 'isBroiler'::text, 'isVitelli'::text, 'isSuini'::text, 'isGallus'::text, 'isOviCaprini'::text, 'isConigli'::text, 'isAltreSpecie'::text])))
  WHERE ticket.tipologia = 3 AND (ticket.closed IS NOT NULL OR ticket.closed_nolista) AND ticket.trashed_date IS NULL AND ticket.assigned_date > (now() - '2 years'::interval);

ALTER TABLE public.bdn_cu_chiusi_benessere_animale
    OWNER TO postgres;

-- Nuove funzioni di invio che coinvolgono anche 39 e 40

CREATE OR REPLACE FUNCTION public.get_chiamata_ws_insert_ba_sa(
	_username_ws_bdn text,
	_password_ws_bdn text,
	_id integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

   DECLARE
id_tipo_chk integer;
result text;
BEGIN

     select id_alleg into id_tipo_chk from chk_bns_mod_ist where id = _id;
     raise info '%', id_tipo_chk; 
     IF id_tipo_chk = 24  THEN
	select get_chiamata_ws_insert_ba_v5_suini into result from get_chiamata_ws_insert_ba_v5_suini(_username_ws_bdn, _password_ws_bdn, _id);
     ELSIF id_tipo_chk = 23 THEN
	select get_chiamata_ws_insert_sa_v4 into result from get_chiamata_ws_insert_sa_v4(_username_ws_bdn, _password_ws_bdn, _id);
     ELSIF id_tipo_chk = 29 THEN
	select get_chiamata_ws_insert_ba_v5_bovini into result from public.get_chiamata_ws_insert_ba_v5_bovini(_username_ws_bdn, _password_ws_bdn, _id);	
     ELSIF id_tipo_chk = 30 THEN	
	select get_chiamata_ws_insert_ba_v5_vitelli into result from public.get_chiamata_ws_insert_ba_v5_vitelli(_username_ws_bdn, _password_ws_bdn, _id);	
     ELSIF id_tipo_chk in (25, 27, 28) THEN 
     	select get_chiamata_ws_insert_ba_v4 into result from public.get_chiamata_ws_insert_ba_v4(_username_ws_bdn, _password_ws_bdn, _id);
     ELSIF id_tipo_chk in (31) THEN 
     	select get_chiamata_ws_insert_ba_v5_gallus into result from public.get_chiamata_ws_insert_ba_v5_gallus(_username_ws_bdn, _password_ws_bdn, _id);
     ELSIF id_tipo_chk in (32) THEN 
     	select get_chiamata_ws_insert_ba_v6_ovicaprini into result from public.get_chiamata_ws_insert_ba_v6_ovicaprini(_username_ws_bdn, _password_ws_bdn, _id);
     ELSIF id_tipo_chk in (33) THEN 
     	select get_chiamata_ws_insert_ba_v6_bovini into result from public.get_chiamata_ws_insert_ba_v6_bovini(_username_ws_bdn, _password_ws_bdn, _id);
     ELSIF id_tipo_chk in (34) THEN 
     	select get_chiamata_ws_insert_ba_v6_suini into result from public.get_chiamata_ws_insert_ba_v6_suini(_username_ws_bdn, _password_ws_bdn, _id);
     ELSIF id_tipo_chk in (35) THEN 
     	select get_chiamata_ws_insert_ba_v6_vitelli into result from public.get_chiamata_ws_insert_ba_v6_vitelli(_username_ws_bdn, _password_ws_bdn, _id);
     ELSIF id_tipo_chk in (36) THEN 
     	select get_chiamata_ws_insert_ba_v6_gallus into result from public.get_chiamata_ws_insert_ba_v6_gallus(_username_ws_bdn, _password_ws_bdn, _id);
     ELSIF id_tipo_chk in (37, 38) THEN 
     	select get_chiamata_ws_insert_ba_v3 into result from public.get_chiamata_ws_insert_ba_v3(_username_ws_bdn, _password_ws_bdn, _id);
		 ELSIF id_tipo_chk in (39) THEN 
     	select get_chiamata_ws_insert_ba_v6_broiler into result from public.get_chiamata_ws_insert_ba_v6_broiler(_username_ws_bdn, _password_ws_bdn, _id);
		 ELSIF id_tipo_chk in (40) THEN 
     	select get_chiamata_ws_insert_ba_v6_conigli into result from public.get_chiamata_ws_insert_ba_v6_conigli(_username_ws_bdn, _password_ws_bdn, _id);
     ELSE 
	result :='';
     END IF;
     
    RETURN result;
END;	
$BODY$;

ALTER FUNCTION public.get_chiamata_ws_insert_ba_sa(text, text, integer)
    OWNER TO postgres;



CREATE OR REPLACE FUNCTION public.get_chiamata_ws_insert_ba_v6_conigli(
	_username_ws_bdn text,
	_password_ws_bdn text,
	_id integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$

   DECLARE
msg text ;
BEGIN

  msg := concat('<?xml version="1.0" encoding="UTF-8"?>
<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">','
',
(select get_chiamata_ws_insert_ba_sa_header from get_chiamata_ws_insert_ba_sa_header(_username_ws_bdn, _password_ws_bdn)),'
',
'<S:Body>
      <ns2:insertControlliallevamentiBA xmlns:ns2="http://ws.izs.it">','
      ',(select get_chiamata_ws_insert_ba_v6_conigli_controlli_allevamenti from get_chiamata_ws_insert_ba_v6_conigli_controlli_allevamenti(_id)),'
      ',(select get_chiamata_ws_insert_ba_v6_conigli_dettaglio_checklist from get_chiamata_ws_insert_ba_v6_conigli_dettaglio_checklist(_id)),'
      </ns2:insertControlliallevamentiBA>
      </S:Body> 
      </S:Envelope>');
    
    
 RETURN msg;
 END;
$BODY$;

ALTER FUNCTION public.get_chiamata_ws_insert_ba_v6_conigli(text, text, integer)
    OWNER TO postgres;
	


CREATE OR REPLACE FUNCTION public.get_chiamata_ws_insert_ba_v6_broiler(
	_username_ws_bdn text,
	_password_ws_bdn text,
	_id integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$

   DECLARE
msg text ;
BEGIN

  msg := concat('<?xml version="1.0" encoding="UTF-8"?>
<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">','
',
(select get_chiamata_ws_insert_ba_sa_header from get_chiamata_ws_insert_ba_sa_header(_username_ws_bdn, _password_ws_bdn)),'
',
'<S:Body>
      <ns2:insertControlliallevamentiBA xmlns:ns2="http://ws.izs.it">','
      ',(select get_chiamata_ws_insert_ba_v6_broiler_controlli_allevamenti from get_chiamata_ws_insert_ba_v6_broiler_controlli_allevamenti(_id)),'
      ',(select get_chiamata_ws_insert_ba_v6_broiler_dettaglio_checklist from get_chiamata_ws_insert_ba_v6_broiler_dettaglio_checklist(_id)),'
      </ns2:insertControlliallevamentiBA>
      </S:Body> 
      </S:Envelope>');
    
    
 RETURN msg;
 END;
$BODY$;

ALTER FUNCTION public.get_chiamata_ws_insert_ba_v6_broiler(text, text, integer)
    OWNER TO postgres;
	
	CREATE OR REPLACE FUNCTION public.get_chiamata_ws_insert_ba_v6_conigli_controlli_allevamenti(
	_id integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

   DECLARE
msg text ;
id_tipo_chk integer;
result text;
tag_preavviso text;
BEGIN
select 
concat('<controlliallevamenti>
	  <caId>0</caId>
           <dtControllo>', to_char(data_controllo, 'YYYY-MM-DD"T"00:00:00.000'),'</dtControllo>
            <aslCodice>',codice_asl,'</aslCodice>
            <aziendaCodice>',codice_azienda,'</aziendaCodice>
            <speCodice>',bdn.codice_specie_chk_bns,'</speCodice>
            <allevIdFiscale>',id_fiscale_allevamento,'</allevIdFiscale>
            <propIdFiscale>',id_fiscale_proprietario,'</propIdFiscale>	   
	    <tipoProdCodice>',tipo_produzione_ba,'</tipoProdCodice>
	    <tipoAllevCodice>',tipo_allevamento_codice,'</tipoAllevCodice>
	    <orientamentoCodice>',codice_orientamento_ba,'</orientamentoCodice>
            <ocCodice>',bdn.occodice,'</ocCodice>
            <flagEsito>',conigli.esito_controllo,'</flagEsito>
            <flagVitelli>N</flagVitelli> 
            <detenIdFiscale>',id_fiscale_detentore,'</detenIdFiscale>
            <flagPreavviso>',bdn.flag_preavviso,'</flagPreavviso>
	    ',case when bdn.flag_preavviso <> 'N' then concat('<dataPreavviso>',to_char(bdn.data_preavviso, 'YYYY-MM-DD"T"00:00:00.000'),'</dataPreavviso>') else '' end,'            
            <primoControllore>',conigli.nome_controllore,'</primoControllore>
            <tipoControllo>BA</tipoControllo>
            <flagCopiaCheckList>',bdn.flag_checklist,'</flagCopiaCheckList>
	    ',case when conigli.esito_controllo = 'N' then concat(
	    '<sanzBloccoMov>',conigli.sanz_blocco,'</sanzBloccoMov>
            <sanzAmministrativa>',conigli.sanz_amministrativa,'</sanzAmministrativa>
            <sanzSequestro>',conigli.sanz_sequestro,'</sanzSequestro>
            <sanzAbbattimentoCapi>',conigli.sanz_abbattimento,'</sanzAbbattimentoCapi>
            <sanzInformativa>',conigli.sanz_informativa,'</sanzInformativa>
            <sanzAltro>',conigli.sanz_altro,'</sanzAltro>
            ',case when conigli.sanz_altro <> '0' then concat('<sanzAltroDesc>',conigli.sanz_altro_desc,'</sanzAltroDesc>')
	    else '' end,'
            <noteControllore>',conigli.note_controllore,'</noteControllore>
            <noteDetentore>',conigli.note_proprietario,'</noteDetentore>')
	    else '' end,'             
	    ',case when conigli.esito_controllo <> 'A' then 
	    concat('<flagEvidenze>',conigli.evidenze,'</flagEvidenze>')
	    else '' end,
	    case when conigli.evidenze = 'S' then 
	    concat('<evidenzaIr>',conigli.evidenze_ir,'</evidenzaIr>
            <evidenzaSv>',conigli.evidenze_sv,'</evidenzaSv>
            <evidenzaSa>',conigli.evidenze_tse,'</evidenzaSa>')
            else '' end,'
            <flagCondizionalita>',conigli.appartenente_condizionalita,'</flagCondizionalita>
             ',case when conigli.data_chiusura_relazione <> '' then concat('<dataChiusura>',concat(conigli.data_chiusura_relazione,'T00:00.000'),'</dataChiusura>')
	    else '' end,'    
         </controlliallevamenti>') into msg
from bdn_cu_chiusi_benessere_animale bdn
left join bdn_checklist_v6_conigli conigli on conigli.id_chk_bns_mod_ist = bdn.id_chk_bns_mod_ist
where bdn.id_chk_bns_mod_ist = _id;

     
    RETURN msg;
END;	
$BODY$;

ALTER FUNCTION public.get_chiamata_ws_insert_ba_v6_conigli_controlli_allevamenti(integer)
    OWNER TO postgres;
	

	
	
CREATE OR REPLACE FUNCTION public.get_chiamata_ws_insert_ba_v6_broiler_controlli_allevamenti(
	_id integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

   DECLARE
msg text ;
id_tipo_chk integer;
result text;
tag_preavviso text;
BEGIN
select 
concat('<controlliallevamenti>
	  <caId>0</caId>
           <dtControllo>', to_char(data_controllo, 'YYYY-MM-DD"T"00:00:00.000'),'</dtControllo>
            <aslCodice>',codice_asl,'</aslCodice>
            <aziendaCodice>',codice_azienda,'</aziendaCodice>
            <speCodice>',bdn.codice_specie_chk_bns,'</speCodice>
            <allevIdFiscale>',id_fiscale_allevamento,'</allevIdFiscale>
	    <tipoProdCodice>',tipo_produzione_ba,'</tipoProdCodice>
	    <tipoAllevCodice>',tipo_allevamento_codice,'</tipoAllevCodice>
	    <orientamentoCodice>',codice_orientamento_ba,'</orientamentoCodice>
	    ',case when broiler.fase_produttiva <> '' then concat('<flagFaseProduttiva>',broiler.fase_produttiva,'</flagFaseProduttiva>') else '' end,'            
            <ocCodice>',bdn.occodice,'</ocCodice>
            <flagEsito>',broiler.esito_controllo,'</flagEsito>
            <flagVitelli>N</flagVitelli> 
            <detenIdFiscale>',id_fiscale_detentore,'</detenIdFiscale>
            <flagPreavviso>',bdn.flag_preavviso,'</flagPreavviso>
	    ',case when bdn.flag_preavviso <> 'N' then concat('<dataPreavviso>',to_char(bdn.data_preavviso, 'YYYY-MM-DD"T"00:00:00.000'),'</dataPreavviso>') else '' end,'            
            <primoControllore>',broiler.nome_controllore,'</primoControllore>
            <tipoControllo>BA</tipoControllo>
            <flagCopiaCheckList>',bdn.flag_checklist,'</flagCopiaCheckList>
	    ',case when broiler.esito_controllo = 'N' then concat(
	    '<sanzBloccoMov>',broiler.sanz_blocco,'</sanzBloccoMov>
            <sanzAmministrativa>',broiler.sanz_amministrativa,'</sanzAmministrativa>
            <sanzSequestro>',broiler.sanz_sequestro,'</sanzSequestro>
            <sanzAbbattimentoCapi>',broiler.sanz_abbattimento,'</sanzAbbattimentoCapi>
            <sanzInformativa>',broiler.sanz_informativa,'</sanzInformativa>
            <sanzAltro>',broiler.sanz_altro,'</sanzAltro>
            ',case when broiler.sanz_altro <> '0' then concat('<sanzAltroDesc>',broiler.sanz_altro_desc,'</sanzAltroDesc>')
	    else '' end,'
            <noteControllore>',broiler.note_controllore,'</noteControllore>
            <noteDetentore>',broiler.note_proprietario,'</noteDetentore>')
	    else '' end,'             
	    ',case when broiler.esito_controllo <> 'A' then 
	    concat('<flagEvidenze>',broiler.evidenze,'</flagEvidenze>')
	    else '' end,
	    case when broiler.evidenze = 'S' then 
	    concat('<evidenzaIr>',broiler.evidenze_ir,'</evidenzaIr>
            <evidenzaSv>',broiler.evidenze_sv,'</evidenzaSv>
            <evidenzaSa>',broiler.evidenze_tse,'</evidenzaSa>')
            else '' end,'
            <flagCondizionalita>',broiler.appartenente_condizionalita,'</flagCondizionalita>
             ',case when broiler.data_chiusura_relazione <> '' then concat('<dataChiusura>',concat(broiler.data_chiusura_relazione,'T00:00.000'),'</dataChiusura>')
	    else '' end,'    
         </controlliallevamenti>') into msg
from bdn_cu_chiusi_benessere_animale bdn
left join bdn_checklist_v6_broiler broiler on broiler.id_chk_bns_mod_ist = bdn.id_chk_bns_mod_ist
where bdn.id_chk_bns_mod_ist = _id;

     
    RETURN msg;
END;	
$BODY$;

ALTER FUNCTION public.get_chiamata_ws_insert_ba_v6_broiler_controlli_allevamenti(integer)
    OWNER TO postgres;
	



CREATE OR REPLACE FUNCTION public.get_chiamata_ws_insert_ba_v6_conigli_dettaglio_checklist(
	_id integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

   DECLARE
msg text ;
id_tipo_chk integer;
result text;
BEGIN

select 
concat(
'<dettagliochecklist>
	<clbId>0</clbId>
	<flagVitelli>N</flagVitelli>
	<critCodice>',conigli.criteri_utilizzati,'</critCodice>
	',
	case when conigli.criteri_utilizzati = 'CF13' then concat('<criterioControlloAltro>',conigli.criteri_utilizzati_altro_descrizione,'</criterioControlloAltro>
	') else '' end,
	case when conigli.esito_controllo = 'N' then concat('<flagIntenzionalita>',conigli.intenzionalita,'</flagIntenzionalita>
	') else '' end,
	'<nomeRappresentante>',conigli.nome_proprietario,'</nomeRappresentante>
	',
	'<tipoAllegato>',bdn.tipo_allegato,'</tipoAllegato>
	',
	'<numCapannoni>',conigli.num_totale_capannoni,'</numCapannoni>
	',
	'<numCapannoniAttivi>',conigli.num_totale_capannoni_attivi,'</numCapannoniAttivi>
	',
	
	case when conigli.esito_controllo = 'N' then 
		concat('<prescrizioni>',conigli.prescrizioni_descrizione,'</prescrizioni>
		') else '' end, 
		case when conigli.prescrizioni_descrizione <> '' then 
			concat('<dataScadPrescrizioni>',concat(conigli.data_prescrizioni,'T00:00:00.000'),'</dataScadPrescrizioni>
			        <flagPrescrizioneEsitoBa>',conigli.eseguite_prescrizioni,'</flagPrescrizioneEsitoBa>
			        ',	
				case when conigli.data_verifica <> '' then 
					concat('<dataVerificaBa>',concat(conigli.data_verifica,'T00:00:00.000'),'</dataVerificaBa>
						<secondoControllore>',conigli.nome_controllore,'</secondoControllore>
						<nomeRappresentanteVer>',conigli.nome_proprietario_prescrizioni_eseguite,'</nomeRappresentanteVer>
						'
					       ) else '' end
		               --) end
		      )else '' end,
	'<parametro>2023</parametro>
	<numClb>',conigli.num_checklist,'</numClb>
	<flagLocQuarantena>',conigli.presenza_quarantena,'</flagLocQuarantena>
	<flagVuotoSanitario>',conigli.vuoto_sanitario,'</flagVuotoSanitario>
	',
	case when conigli.esito_controllo <> 'A' then concat('<veterinario>',conigli.veterinario_ispettore,'</veterinario>
	') else '' end, 
	case when conigli.esito_controllo <> 'A' then concat('<presenzaManuale>',conigli.presenza_manuale,'</presenzaManuale>
	') else '' end,
	case when conigli.esito_controllo <> 'A' then (select get_chiamata_ws_insert_ba_v6_requisiti from public.get_chiamata_ws_insert_ba_v6_requisiti(_id)) else '' 
	END,
	CASE     when conigli.esito_controllo <> 'A' then (select get_chiamata_ws_insert_ba_v6_conigli_capannoni from public.get_chiamata_ws_insert_ba_v6_conigli_capannoni(_id)) else ''
	end,'
	</dettagliochecklist>
            ') into msg
from bdn_cu_chiusi_benessere_animale bdn
left join bdn_checklist_v6_conigli conigli on conigli.id_chk_bns_mod_ist = bdn.id_chk_bns_mod_ist
where bdn.id_chk_bns_mod_ist = _id;
   

    RETURN msg;
END;	
$BODY$;

ALTER FUNCTION public.get_chiamata_ws_insert_ba_v6_conigli_dettaglio_checklist(integer)
    OWNER TO postgres;



CREATE OR REPLACE FUNCTION public.get_chiamata_ws_insert_ba_v6_conigli_capannoni(
	_id integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

   DECLARE
msg text ;
id_tipo_chk integer;
result text;
BEGIN
     
   select string_agg(concat('<capannoni>
               <clcapId>0</clcapId>
               <clbId>0</clbId>
               <identificativo>',numero,'</identificativo>
               <numFori>',num_fori,'</numFori>
               <numSvezzati>',num_animali,'</numSvezzati>
               <tipoStruttura>',tipo_struttura,'</tipoStruttura>
               <tipoGabbia>',tipo_gabbia,'</tipoGabbia>
               <altroTipoGabbia>',tipo_gabbia_desc,'</altroTipoGabbia>
               <ventilazione>',ventilazione,'</ventilazione>
               <operation>insert</operation>
            </capannoni>'),'
            ') into msg 
   from
  chk_bns_capannoni_v6 where trashed_date  is null and id_chk_bns_mod_ist = _id
  and (numero <> '' or num_fori <> '' or num_animali <> '' or tipo_struttura <> '' or tipo_gabbia <> '' or ventilazione <> '') ;
    RETURN msg;
END;	
$BODY$;

ALTER FUNCTION public.get_chiamata_ws_insert_ba_v6_conigli_capannoni(integer)
    OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.get_chiamata_ws_insert_ba_v6_broiler_dettaglio_checklist(
	_id integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

   DECLARE
msg text ;
id_tipo_chk integer;
result text;
BEGIN

select 
concat(
'<dettagliochecklist>
	<clbId>0</clbId>
	<flagVitelli>N</flagVitelli>
	<critCodice>',broiler.criteri_utilizzati,'</critCodice>
	',
	case when broiler.criteri_utilizzati = 'CF13' then concat('<criterioControlloAltro>',broiler.criteri_utilizzati_altro_descrizione,'</criterioControlloAltro>
	') else '' end,
	case when broiler.esito_controllo = 'N' then concat('<flagIntenzionalita>',broiler.intenzionalita,'</flagIntenzionalita>
	') else '' end,
	'<nomeRappresentante>',broiler.nome_proprietario,'</nomeRappresentante>
	',
	'<tipoAllegato>',bdn.tipo_allegato,'</tipoAllegato>
	',
	case when broiler.esito_controllo = 'N' then 
		concat('<prescrizioni>',broiler.prescrizioni_descrizione,'</prescrizioni>
		') else '' end, 
		case when broiler.prescrizioni_descrizione <> '' then 
			concat('<dataScadPrescrizioni>',concat(broiler.data_prescrizioni,'T00:00:00.000'),'</dataScadPrescrizioni>
			        <flagPrescrizioneEsitoBa>',broiler.eseguite_prescrizioni,'</flagPrescrizioneEsitoBa>
			        ',	
				case when broiler.data_verifica <> '' then 
					concat('<dataVerificaBa>',concat(broiler.data_verifica,'T00:00:00.000'),'</dataVerificaBa>
						<secondoControllore>',broiler.nome_controllore,'</secondoControllore>
						<nomeRappresentanteVer>',broiler.nome_proprietario_prescrizioni_eseguite,'</nomeRappresentanteVer>
						'
					       ) else '' end
		               --) end
		      )else '' end,
	'<parametro>2023</parametro>
	<numClb>',broiler.num_checklist,'</numClb>
	',
	case when broiler.esito_controllo <> 'A' then concat('<ibridoRazza>',broiler.ibrido_razza_allevata,'</ibridoRazza>
	') else '' end, 
	case when broiler.esito_controllo <> 'A' then concat('<veterinario>',broiler.veterinario_ispettore,'</veterinario>
	') else '' end, 
	case when broiler.esito_controllo <> 'A' then concat('<presenzaManuale>',broiler.presenza_manuale,'</presenzaManuale>
	') else '' end,
	case when broiler.esito_controllo <> 'A' then concat('<flagCapMaxAut>',broiler.capacita_massima,'</flagCapMaxAut>
	') else '' end,
	case when broiler.esito_controllo <> 'A' then (select get_chiamata_ws_insert_ba_v6_requisiti from public.get_chiamata_ws_insert_ba_v6_requisiti(_id)) else '' 
	END,'
	</dettagliochecklist>
            ') into msg
from bdn_cu_chiusi_benessere_animale bdn
left join bdn_checklist_v6_broiler broiler on broiler.id_chk_bns_mod_ist = bdn.id_chk_bns_mod_ist
where bdn.id_chk_bns_mod_ist = _id;
   

    RETURN msg;
END;	
$BODY$;

ALTER FUNCTION public.get_chiamata_ws_insert_ba_v6_broiler_dettaglio_checklist(integer)
    OWNER TO postgres;


