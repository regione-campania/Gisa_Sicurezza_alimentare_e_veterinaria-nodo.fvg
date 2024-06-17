--DROP function public.get_registro_trasgressori_rate_pagate(integer);
--DROP function public.get_registro_trasgressori_tutte_rate_pagate(integer);
--DROP function public.get_registro_trasgressori_rate_pagate();
--DROP function public.get_registro_trasgressori_tutte_rate_pagate();
--DROP function registro_trasgressori_get_dati_registro(integer);
--DROP TABLE registro_trasgressori_materializzato;

CREATE OR REPLACE FUNCTION public.get_registro_trasgressori_rate_pagate(
    _id_sanzione integer)
  RETURNS text AS
$BODY$
   DECLARE
   
      rate text[];
	  ratepagate text;

   BEGIN
   
       rate := array ['PRIMA RATA',
'SECONDA RATA',
'TERZA RATA',
'QUARTA RATA',
'QUINTA RATA',
'SESTA RATA',
'SETTIMA RATA',
'OTTAVA RATA',
'NONA RATA',
'DECIMA RATA',
'UNDICESIMA RATA',
'DODICESIMA RATA',
'TREDICESIMA RATA',
'QUATTORDICESIMA RATA',
'QUINDICESIMA RATA',
'SEDICESIMA RATA',
'DICIASSETTESIMA RATA',
'DICIOTTESIMA RATA',
'DICIANNOVESIMA RATA',
'VENTESIMA RATA',
'VENTUNESIMA RATA',
'VENTIDUESIMA RATA',
'VENTITREESIMA RATA',
'VENTIQUATTRESIMA RATA',
'VENTICINQUESIMA RATA',
'VENTISEIESIMA RATA',
'VENTISETTESIMA RATA',
'VENTOTTESIMA RATA',
'VENTINOVESIMA RATA',
'TRENTESIMA RATA',
'TRENTUNESIMA RATA',
'TRENTADUESIMA RATA',
'TRENTATREESIMA RATA',
'TRENTAQUATTRESIMA RATA',
'TRENTACINQUESIMA RATA',
'TRENTASEIESIMA RATA',
'TRENTASETTESIMA RATA',
'TRENTOTTESIMA RATA',
'TRENTANOVESIMA RATA',
'QUARANTESIMA RATA',
'QUARANTUNESIMA RATA',
'QUARANTADUESIMA RATA',
'QUARANTATREESIMA RATA',
'QUARANTAQUATTRESIMA RATA',
'QUARANTACINQUESIMA RATA',
'QUARANTASEIESIMA RATA',
'QUARANTASETTESIMA RATA',
'QUARANTOTTESIMA RATA',
'QUARANTANOVESIMA RATA',
'CINQUANTESIMA RATA',
'CINQUANTUNESIMA RATA',
'CINQUANTADUESIMA RATA',
'CINQUANTATREESIMA RATA',
'CINQUANTAQUATTRESIMA RATA',
'CINQUANTACINQUESIMA RATA',
'CINQUANTASEIESIMA RATA',
'CINQUANTASETTESIMA RATA',
'CINQUANTOTTESIMA RATA',
'CINQUANTANOVESIMA RATA',
'SESSANTESIMA RATA',
'SESSANTUNESIMA RATA',
'SESSANTADUESIMA RATA',
'SESSANTATREESIMA RATA',
'SESSANTAQUATTRESIMA RATA',
'SESSANTACINQUESIMA RATA',
'SESSANTASEIESIMA RATA',
'SESSANTASETTESIMA RATA',
'SESSANTOTTESIMA RATA',
'SESSANTANOVESIMA RATA',
'SETTANTESIMA RATA',
'SETTANTUNESIMA RATA',
'SETTANTADUESIMA RATA',
'SETTANTATREESIMA RATA',
'SETTANTAQUATTRESIMA RATA',
'SETTANTACINQUESIMA RATA',
'SETTANTASEIESIMA RATA',
'SETTANTASETTESIMA RATA',
'SETTANTOTTESIMA RATA',
'SETTANTANOVESIMA RATA',
'OTTANTESIMA RATA',
'OTTANTUNESIMA RATA',
'OTTANTADUESIMA RATA',
'OTTANTATREESIMA RATA',
'OTTANTAQUATTRESIMA RATA',
'OTTANTACINQUESIMA RATA',
'OTTANTASEIESIMA RATA',
'OTTANTASETTESIMA RATA',
'OTTANTOTTESIMA RATA',
'OTTANTANOVESIMA RATA',
'NOVANTESIMA RATA',
'NOVANTUNESIMA RATA',
'NOVANTADUESIMA RATA',
'NOVANTATREESIMA RATA',
'NOVANTAQUATTRESIMA RATA',
'NOVANTACINQUESIMA RATA',
'NOVANTASEIESIMA RATA',
'NOVANTASETTESIMA RATA',
'NOVANTOTTESIMA RATA',
'NOVANTANOVESIMA RATA',
'CENTESIMA RATA'];

select COALESCE(string_agg(rate[indice], ', '), '') into ratepagate from (
	SELECT indice FROM pagopa_pagamenti where tipo_pagamento = 'NO' and trashed_date is null and id_sanzione = _id_sanzione and stato_pagamento = 'PAGAMENTO COMPLETATO' order by indice asc) aa ;

return ratepagate;

   END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;  

CREATE OR REPLACE FUNCTION public.get_registro_trasgressori_tutte_rate_pagate(
    _id_sanzione integer)
  RETURNS boolean AS
$BODY$
   DECLARE
   
   	  numrate integer;
	  numratepagate integer;
	  tutteratepagate boolean;

   BEGIN
   
      tutteratepagate := false; 

select count(*) into numrate FROM pagopa_pagamenti where tipo_pagamento = 'NO' and trashed_date is null and id_sanzione = _id_sanzione;

IF numrate = 0 THEN
return false;
END IF;

select count(*) into numratepagate FROM pagopa_pagamenti where tipo_pagamento = 'NO' and trashed_date is null and id_sanzione = _id_sanzione and stato_pagamento = 'PAGAMENTO COMPLETATO';

IF numrate = numratepagate THEN
tutteratepagate := true;
END IF;

return tutteratepagate;

   END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

CREATE OR REPLACE FUNCTION public.registro_trasgressori_get_dati_sanzioni(_anno integer)
    RETURNS TABLE(anno_controllo integer, id_controllo integer, id_sanzione integer, data_accertamento timestamp without time zone, asl text, ente1 text, ente2 text, ente3 text, numero_verbale text, numero_verbale_sequestro text, trasgressore text, obbligato text, importo_sanzione_ridotta text, importo_sanzione_ultraridotta text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
r RECORD;	
BEGIN


FOR 

anno_controllo, id_controllo, id_sanzione, data_accertamento, asl, ente1, ente2, ente3, numero_verbale, numero_verbale_sequestro, trasgressore, obbligato, importo_sanzione_ridotta, importo_sanzione_ultraridotta

in

SELECT 
date_part('year'::text, controllo.assigned_date) AS anno_controllo,
controllo.ticketid AS id_controllo,
t.ticketid AS id_sanzione,
controllo.assigned_date AS data_accertamento,
asl.description AS asl,
CASE WHEN nucleo.in_dpat THEN 'ASL '::text || asl.description::text ELSE nucleo.description::text END AS ente1,
CASE WHEN nucleo2.in_dpat THEN 'ASL '::text || asl.description::text ELSE nucleo2.description::text END AS ente2,
CASE WHEN nucleo3.in_dpat THEN 'ASL '::text || asl.description::text ELSE nucleo3.description::text END AS ente3,
t.tipo_richiesta AS numero_verbale,
t.verbale_sequestro AS numero_verbale_sequestro,
t.trasgressore,
t.obbligatoinsolido AS obbligato,
t.pagamento::text AS importosanzioneridotta,
CASE WHEN t.pagamento_ultraridotto > 0::double precision THEN 'SI '::text || t.pagamento_ultraridotto ELSE 'NO'::text END AS importo_sanzione_ultraridotta

FROM ticket t
JOIN ticket controllo ON controllo.tipologia = 3 AND t.id_controllo_ufficiale::text = controllo.id_controllo_ufficiale::text
LEFT JOIN nucleo_ispettivo_mv mv_nucleo ON mv_nucleo.id_controllo_ufficiale = controllo.ticketid
LEFT JOIN lookup_qualifiche nucleo ON nucleo.description::text = mv_nucleo.nucleo_ispettivo::text
LEFT JOIN lookup_qualifiche nucleo2 ON nucleo2.description::text = mv_nucleo.nucleo_ispettivo_due::text
LEFT JOIN lookup_qualifiche nucleo3 ON nucleo3.description::text = mv_nucleo.nucleo_ispettivo_tre::text
LEFT JOIN lookup_site_id asl ON asl.code = controllo.site_id
    
WHERE 
t.trashed_date IS NULL 
AND t.tipologia = 1 
AND controllo.trashed_date IS NULL 
AND controllo.assigned_date >= '2015-03-01 00:00:00'::timestamp without time zone 
AND controllo.status_id <> 1 
AND t.id_nonconformita > 0
AND ((_anno > 0 AND date_part('year', controllo.assigned_date) = _anno) OR (_anno = -1))
  
UNION
 
SELECT 
date_part('year'::text, t.assigned_date) AS anno_controllo,
NULL::integer AS id_controllo,
t.ticketid AS id_sanzione,
t.assigned_date AS data_accertamento,
asl.description AS asl,
''::text AS ente1,
''::text AS ente2,
''::text AS ente3,
t.tipo_richiesta AS numero_verbale,
t.verbale_sequestro AS numero_verbale_sequestro,
t.trasgressore,
t.obbligatoinsolido AS obbligato,
t.pagamento::text AS importo_sanzione_ridotta,
CASE WHEN t.pagamento_ultraridotto > 0::double precision THEN 'SI '::text || t.pagamento_ultraridotto ELSE 'NO'::text END AS importo_sanzione_ultraridotta
FROM ticket t
LEFT JOIN lookup_site_id asl ON asl.code = t.site_id
WHERE 
t.trashed_date IS NULL
AND t.tipologia = 1 
AND t.assigned_date >= '2015-03-01 00:00:00'::timestamp without time zone 
AND t.note_internal_use_only ~~* '%RECORD GENERATO AUTOMATICAMENTE PER INSERIMENTO SANZIONE FORZATA NEL REGISTRO TRASGRESSORI%'::text
AND ((_anno > 0 AND date_part('year', t.assigned_date) = _anno) OR (_anno = -1))

    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$;


CREATE OR REPLACE FUNCTION public.registro_trasgressori_get_dati_registro(_anno integer)
    RETURNS TABLE(
		
		anno_controllo integer, 
		id_controllo integer, 
		id_sanzione integer, 
		data_accertamento timestamp without time zone, 
		asl text, 
		ente1 text, 
		ente2 text, 
		ente3 text, 
		numero_verbale text, 
		numero_verbale_sequestro text, 
		trasgressore text, 
		obbligato text, 
		importo_sanzione_ridotta text, 
		importo_sanzione_ultraridotta text,
		
		rt_id integer, 
		progressivo integer,
		data_inserimento timestamp without time zone, 
		data_modifica timestamp without time zone, 
		id_utente_modifica integer, 
		data_prot_entrata timestamp without time zone, 
		pv_oblato_ridotta boolean, 
		fi_assegnatario text, 
		presentati_scritti boolean, 
		presentata_richiesta_riduzione boolean, 
		presentata_richiesta_audizione boolean, 
		ordinanza_emessa text, 
		importo_sanzione_ingiunta integer, 
		data_emissione timestamp without time zone, 
		giorni_lavorazione integer, 
		ordinanza_ingiunzione_oblata boolean, 
		sentenza_favorevole boolean, 
		importo_stabilito integer, 
		ordinanza_ingiunzione_sentenza boolean,
		num_ordinanza text,
		iscrizione_ruoli_sattoriali boolean, 
		note1 text, 
		note2 text, 
		presentata_opposizione boolean, 
		trashed_date timestamp without time zone, 
		richiesta_rateizzazione boolean, 
		rata1 boolean, 
		rata2 boolean, 
		rata3 boolean, 
		rata4 boolean, 
		rata5 boolean, 
		rata6 boolean, 
		rata7 boolean, 
		rata8 boolean, 
		rata9 boolean, 
		rata10 boolean, 
		importo_effettivamente_versato1 integer, 
		importo_effettivamente_versato2 double precision, 
		importo_effettivamente_versato3 integer, 
		importo_effettivamente_versato4 integer, 
		competenza_regionale boolean, 
		data_ultima_notifica timestamp without time zone, 
		data_pagamento timestamp without time zone, 
		pagamento_ridotto_consentito boolean, 
		data_ultima_notifica_ordinanza timestamp without time zone, 
		data_pagamento_ordinanza timestamp without time zone, 
		pagamento_ridotto_consentito_ordinanza boolean, 
		ae_pagati boolean, 
		esistente boolean, 
		allegato_rt text,
		allegato_pv text, 
		allegato_al text, 
		allegato_ae text,
		pagopa_pv_iuv text,
		pagopa_no_iuv text, 
		pagopa_pv_oblato_ridotta boolean, 
		pagopa_pv_oblato_ultraridotta boolean, 
		pagopa_pv_data_pagamento timestamp without time zone, 
		pagopa_tipo text,
		pratica_chiusa boolean


				 ) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
r RECORD;	
BEGIN

FOR 

anno_controllo, 
id_controllo, 
id_sanzione, 
data_accertamento,
asl, 
ente1, 
ente2, 
ente3, 
numero_verbale,
numero_verbale_sequestro, 
trasgressore, 
obbligato, 
importo_sanzione_ridotta,
importo_sanzione_ultraridotta,

rt_id, 
progressivo,
data_inserimento, 
data_modifica, 
id_utente_modifica, 
data_prot_entrata, 
pv_oblato_ridotta, 
fi_assegnatario, 
presentati_scritti, 
presentata_richiesta_riduzione, 
presentata_richiesta_audizione, 
ordinanza_emessa, 
importo_sanzione_ingiunta, 
data_emissione, 
giorni_lavorazione, 
ordinanza_ingiunzione_oblata, 
sentenza_favorevole, 
importo_stabilito, 
ordinanza_ingiunzione_sentenza, 
num_ordinanza,
iscrizione_ruoli_sattoriali, 
note1, 
note2, 
presentata_opposizione, 
trashed_date, 
richiesta_rateizzazione, 
rata1, 
rata2, 
rata3, 
rata4, 
rata5, 
rata6, 
rata7, 
rata8, 
rata9, 
rata10, 
importo_effettivamente_versato1, 
importo_effettivamente_versato2, 
importo_effettivamente_versato3, 
importo_effettivamente_versato4, 
competenza_regionale, 
data_ultima_notifica, 
data_pagamento, 
pagamento_ridotto_consentito, 
data_ultima_notifica_ordinanza, 
data_pagamento_ordinanza, 
pagamento_ridotto_consentito_ordinanza, 
ae_pagati,
esistente, 
allegato_rt,
allegato_pv, 
allegato_al, 
allegato_ae,
pagopa_pv_iuv,
pagopa_no_iuv, 
pagopa_pv_oblato_ridotta, 
pagopa_pv_oblato_ultraridotta, 
pagopa_pv_data_pagamento, 
pagopa_tipo,
pratica_chiusa

in

 SELECT 
 
 s.anno_controllo, 
 s.id_controllo, 
 s.id_sanzione, 
 s.data_accertamento,
 s.asl,
 s.ente1, 
 s.ente2, 
 s.ente3,
 s.numero_verbale, 
 s.numero_verbale_sequestro, 
 s.trasgressore, 
 s.obbligato, 
 s.importo_sanzione_ridotta, 
 s.importo_sanzione_ultraridotta,
 
 rt.id as rt_id,
 rt.progressivo,
 rt.data_inserimento,
 rt.data_modifica,
 rt.id_utente_modifica,
 rt.data_prot_entrata,
 rt.pv_oblato_ridotta,
 rt.fi_assegnatario,
 rt.presentati_scritti,
 rt.presentata_richiesta_riduzione,
 rt.presentata_richiesta_audizione,
 rt.ordinanza_emessa,
 rt.importo_sanzione_ingiunta,
 rt.data_emissione,
 rt.giorni_lavorazione,
 rt.ordinanza_ingiunzione_oblata,
 rt.sentenza_favorevole,
 rt.importo_stabilito,
 rt.ordinanza_ingiunzione_sentenza,
 rt.num_ordinanza,
 rt.iscrizione_ruoli_sattoriali,
 rt.note1,
 rt.note2,
 rt.presentata_opposizione,
 rt.trashed_date,
 rt.richiesta_rateizzazione,
 rt.rata1,
 rt.rata2,
 rt.rata3,
 rt.rata4,
 rt.rata5,
 rt.rata6,
 rt.rata7,
 rt.rata8,
 rt.rata9,
 rt.rata10,
 rt.importo_effettivamente_versato1,
 CASE WHEN rt.data_emissione >= '2022-04-19 00:00:00'::timestamp without time zone AND count(pagopa_no.id) > 0 THEN ( SELECT get_registro_trasgressori_importo_effettivamente_introitato_2(s.id_sanzione) AS get_registro_trasgressori_importo_effettivamente_introitato_2) ELSE rt.importo_effettivamente_versato2::double precision END AS importo_effettivamente_versato2,
 rt.importo_effettivamente_versato3,
 rt.importo_effettivamente_versato4,
 rt.competenza_regionale,
 rt.data_ultima_notifica,
 rt.data_pagamento,
 rt.pagamento_ridotto_consentito,
 rt.data_ultima_notifica_ordinanza,
 rt.data_pagamento_ordinanza,
 rt.pagamento_ridotto_consentito_ordinanza,
 rt.ae_pagati,
 CASE WHEN rt.id IS NOT NULL THEN true ELSE false END AS esistente,
 string_agg(DISTINCT concat(sa_rt.header_allegato, '#', sa_rt.oggetto, '#', sa_rt.nome_client), ';'::text) AS allegato_rt,
 string_agg(DISTINCT concat(sa_pv.header_allegato, '#', sa_pv.oggetto, '#', sa_pv.nome_client), ';'::text) AS allegato_pv,
 string_agg(DISTINCT concat(sa_al.header_allegato, '#', sa_al.oggetto, '#', sa_al.nome_client), ';'::text) AS allegato_al,
 string_agg(DISTINCT concat(sa_ae.header_allegato, '#', sa_ae.oggetto, '#', sa_ae.nome_client), ';'::text) AS allegato_ae,
 string_agg(DISTINCT concat_ws('#'::text, pagopa_pv.identificativo_univoco_versamento, pagopa_pv.url_file_avviso,    pagopa_pv.stato_pagamento), '##'::text) AS pagopa_pv_iuv,
  string_agg(DISTINCT concat_ws('#'::text, pagopa_no.identificativo_univoco_versamento, pagopa_no.url_file_avviso, pagopa_no.stato_pagamento), '##'::text) AS pagopa_no_iuv,
  CASE WHEN rt.forzato THEN rt.forzato_pv_oblato_r ELSE pagopa_pv_r."check" END AS pagopa_pv_oblato_ridotta,
  CASE WHEN rt.forzato THEN rt.forzato_pv_oblato_ur ELSE pagopa_pv_ur."check" END AS pagopa_pv_oblato_ultraridotta,
  CASE WHEN rt.forzato THEN rt.forzato_pv_data_pagamento ELSE COALESCE(pagopa_pv_r.data_esito_singolo_pagamento, pagopa_pv_ur.data_esito_singolo_pagamento)::timestamp without time zone END AS pagopa_pv_data_pagamento,
  CASE WHEN count(pagopa_pv.id) > 0 THEN 'PV'::text WHEN count(pagopa_no.id) > 0 THEN 'NO'::text ELSE ''::text END AS pagopa_tipo,
rt.pratica_chiusa 
      
   FROM registro_trasgressori_get_dati_sanzioni(_anno) s
     LEFT JOIN sanzioni_allegati sa_pv ON sa_pv.id_sanzione = s.id_sanzione AND sa_pv.tipo_allegato = 'SanzionePV'::text AND sa_pv.trashed_date IS NULL
     LEFT JOIN sanzioni_allegati sa_al ON sa_al.id_sanzione = s.id_sanzione AND sa_al.tipo_allegato = 'SanzioneAL'::text AND sa_al.trashed_date IS NULL
     LEFT JOIN sanzioni_allegati sa_rt ON sa_rt.id_sanzione = s.id_sanzione AND sa_rt.tipo_allegato = 'RegistroTrasgressori'::text AND sa_rt.trashed_date IS NULL
     LEFT JOIN sanzioni_allegati sa_ae ON sa_ae.id_sanzione = s.id_sanzione AND sa_ae.tipo_allegato = 'RegistroTrasgressoriAE'::text AND sa_ae.trashed_date IS NULL
     LEFT JOIN registro_trasgressori_values rt ON s.id_sanzione = rt.id_sanzione
     LEFT JOIN pagopa_pagamenti pagopa_pv ON pagopa_pv.id_sanzione = s.id_sanzione AND pagopa_pv.trashed_date IS NULL AND pagopa_pv.tipo_pagamento = 'PV'::text
     LEFT JOIN pagopa_pagamenti pagopa_no ON pagopa_no.id_sanzione = s.id_sanzione AND pagopa_no.trashed_date IS NULL AND pagopa_no.tipo_pagamento = 'NO'::text
	  LEFT JOIN pagopa_pagamenti pagopa_no_rate_pagate ON pagopa_no_rate_pagate.id_sanzione = s.id_sanzione AND pagopa_no_rate_pagate.trashed_date IS NULL AND pagopa_no_rate_pagate.tipo_pagamento = 'NO'::text and pagopa_no_rate_pagate.stato_pagamento = 'PAGAMENTO COMPLETATO'
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id,
            pagopa_pagamenti.data_esito_singolo_pagamento,
            true AS "check"
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'PV'::text AND pagopa_pagamenti.tipo_riduzione = 'R'::text AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_pv_r ON pagopa_pv_r.id_sanzione = s.id_sanzione
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id,
            pagopa_pagamenti.data_esito_singolo_pagamento,
            true AS "check"
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'PV'::text AND pagopa_pagamenti.tipo_riduzione = 'U'::text AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_pv_ur ON pagopa_pv_ur.id_sanzione = s.id_sanzione

  
  GROUP BY s.anno_controllo, s.id_controllo, s.id_sanzione, s.data_accertamento, s.asl, s.ente1, s.ente2, s.ente3, s.numero_verbale, s.numero_verbale_sequestro, s.trasgressore, s.obbligato, s.importo_sanzione_ridotta, s.importo_sanzione_ultraridotta, rt.id, pagopa_pv_r.check, pagopa_pv_ur.check, pagopa_pv_r.data_esito_singolo_pagamento, pagopa_pv_ur.data_esito_singolo_pagamento
  
    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$;

select * from registro_trasgressori_get_dati_registro(2021)

-- bisogna eliminare i campi pagopa_no_rate_pagate e pagopa_no_tutte_rate_pagate dal bean;
-- bisogna costruirlo con le dbi quando si istanzia il bean
-- bisogna settare pratica chiusa se tutte rate pagate = true