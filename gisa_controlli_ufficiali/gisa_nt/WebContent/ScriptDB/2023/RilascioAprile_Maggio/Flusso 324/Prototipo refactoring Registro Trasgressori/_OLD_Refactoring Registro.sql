-- Tabella materializzata

CREATE TABLE registro_trasgressori_materializzato (
	id_controllo_ufficiale integer,
	anno_controllo integer,
	id_sanzione integer PRIMARY KEY,
	asl text,
	ente1 text,
	ente2 text,
	ente3 text,
	numero_verbale text,
	numero_verbale_sequestro text,
	importo_sanzione_ultraridotta text,
	data_accertamento timestamp without time zone,
	trasgressore text,
	obbligato text,
	importo_sanzione_ridotta text,
	rt_id integer,
	rt_data_prot_entrata timestamp without time zone,
    rt_pv_oblato_ridotta boolean,
    rt_fi_assegnatario text,
    rt_presentati_scritti boolean,
    rt_presentata_richiesta_riduzione boolean,
    rt_presentata_richiesta_audizione boolean,
	rt_ordinanza_emessa text,
    rt_importo_sanzione_ingiunta integer,
    rt_data_emissione timestamp without time zone, 
    rt_giorni_lavorazione integer,
    rt_ordinanza_ingiunzione_oblata boolean,
    rt_sentenza_favorevole boolean,
    rt_importo_stabilito integer,
    rt_ordinanza_ingiunzione_sentenza boolean,
    rt_iscrizione_ruoli_sattoriali boolean,
    rt_note1 text,
    rt_note2 text,
    rt_data_inserimento timestamp without time zone,
    rt_data_modifica timestamp without time zone,
    rt_id_utente_modifica integer,
    rt_presentata_opposizione boolean,
    rt_trashed_date timestamp without time zone,
    rt_richiesta_rateizzazione boolean,
    rt_rata1 boolean,
    rt_rata2 boolean,
    rt_rata3 boolean,
    rt_rata4 boolean,
    rt_rata5 boolean,
    rt_rata6 boolean,
    rt_rata7 boolean,
    rt_rata8 boolean,
    rt_rata9 boolean,
    rt_rata10 boolean,
    allegato_rt text,
    rt_importo_effettivamente_versato1 integer,
	rt_importo_effettivamente_versato2 double precision,
    rt_importo_effettivamente_versato3 integer,
    rt_importo_effettivamente_versato4 integer,
    rt_competenza_regionale boolean,
    rt_pratica_chiusa boolean,
    rt_data_ultima_notifica timestamp without time zone,
    rt_data_pagamento timestamp without time zone,
    rt_pagamento_ridotto_consentito boolean,
    rt_data_ultima_notifica_ordinanza timestamp without time zone,
    rt_data_pagamento_ordinanza timestamp without time zone,
    rt_pagamento_ridotto_consentito_ordinanza boolean,
    rt_esistente boolean,
    rt_progressivo integer,
    rt_num_ordinanza text,
    allegato_pv text,
    allegato_al text,
    pagopa_pv_iuv text,
    pagopa_no_iuv text,
 	pagopa_pv_oblato_ridotta text,
	pagopa_pv_oblato_ultraridotta text,
    pagopa_pv_data_pagamento timestamp without time zone,
	pagopa_tipo text,
    allegato_ae text,
    rt_ae_pagati text);

-- Pregresso

    insert into registro_trasgressori_materializzato 

select

idcontrollo, anno, idsanzione, asl, ente1, ente2, ente3, numeroverbale, numeroverbalesequestri, importosanzioneultraridotta,
dataaccertamento, trasgressore, obbligato, importosanzioneridotta, id, data_prot_entrata, pv_oblato_ridotta,
fi_assegnatario, presentati_scritti, presentata_richiesta_riduzione,  presentata_richiesta_audizione, 
	ordinanza_emessa ,
    importo_sanzione_ingiunta ,
    data_emissione , 
    giorni_lavorazione ,
    ordinanza_ingiunzione_oblata ,
    sentenza_favorevole ,
    importo_stabilito ,
    ordinanza_ingiunzione_sentenza ,
    iscrizione_ruoli_sattoriali ,
    note1 ,
    note2 ,
    data_inserimento ,
    data_modifica ,
    id_utente_modifica ,
    presentata_opposizione ,
    trashed_date ,
    richiesta_rateizzazione ,
    rata1 ,
    rata2 ,
    rata3 ,
    rata4 ,
    rata5 ,
    rata6 ,
    rata7 ,
    rata8 ,
    rata9 ,
    rata10 ,
    allegato_rt ,
    importo_effettivamente_versato1 ,
	importo_effettivamente_versato2 ,
    importo_effettivamente_versato3 ,
    importo_effettivamente_versato4 ,
    competenza_regionale ,
    pratica_chiusa ,
    data_ultima_notifica ,
    data_pagamento ,
    pagamento_ridotto_consentito ,
    data_ultima_notifica_ordinanza ,
    data_pagamento_ordinanza ,
    pagamento_ridotto_consentito_ordinanza ,
    esistente ,
    progressivo ,
    num_ordinanza ,
    allegato_pv ,
    allegato_al ,
    pagopa_pv_iuv ,
    pagopa_no_iuv ,
 	pagopa_pv_oblato_ridotta ,
	pagopa_pv_oblato_ultraridotta ,
    pagopa_pv_data_pagamento ,
	pagopa_tipo ,
    allegato_ae ,
    ae_pagati
	from registro_trasgressori_vista;


       -- Dbi refresh
    
	
	CREATE OR REPLACE FUNCTION public.refresh_registro_trasgressori(_id integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$

DECLARE
	ret text;
	_tipologia integer;
	sanzione record;
BEGIN

ret := '';

select tipologia into _tipologia from ticket where ticketid = _id;

IF _tipologia = 3 THEN

  for sanzione in SELECT ticketid FROM ticket where id_controllo_ufficiale::integer = _id and trashed_date is null and tipologia =1
    loop 
	ret:= ret||(select * from refresh_registro_trasgressori_sanzione(sanzione.ticketid))||'; ';
    end loop;

ELSIF _tipologia = 1 OR _id = -1 THEN

ret := (select * from refresh_registro_trasgressori_sanzione(_id));

ELSE

ret := 'Dati di input non validi.';

END IF;

 RETURN ret;
 END;
$BODY$;
	
	CREATE OR REPLACE FUNCTION public.refresh_registro_trasgressori_sanzione(_idsanzione integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$

DECLARE
	ret text;
	_new_id_sanzione integer;
	_new_rt_id integer;
BEGIN

delete from registro_trasgressori_materializzato where 
((_idsanzione > 0 and id_sanzione = _idsanzione) or _idsanzione =-1);

insert into registro_trasgressori_materializzato

 SELECT controllo.ticketid AS idcontrollo,
    date_part('year'::text, controllo.assigned_date) AS anno_controllo,
    t.ticketid AS idsanzione,
    asl.description AS asl,
        CASE
            WHEN nucleo.in_dpat THEN 'ASL '::text || asl.description::text
            ELSE nucleo.description::text
        END AS ente1,
        CASE
            WHEN nucleo2.in_dpat THEN 'ASL '::text || asl.description::text
            ELSE nucleo2.description::text
        END AS ente2,
        CASE
            WHEN nucleo3.in_dpat THEN 'ASL '::text || asl.description::text
            ELSE nucleo3.description::text
        END AS ente3,
    t.tipo_richiesta AS numeroverbale,
    t.verbale_sequestro AS numeroverbalesequestri,
        CASE
            WHEN t.pagamento_ultraridotto > 0::double precision THEN 'SI '::text || t.pagamento_ultraridotto
            ELSE 'NO'::text
        END AS importosanzioneultraridotta,
    controllo.assigned_date AS dataaccertamento,
    t.trasgressore,
    t.obbligatoinsolido AS obbligato,
    t.pagamento::text AS importosanzioneridotta,
    rt.id,
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
    rt.iscrizione_ruoli_sattoriali,
    rt.note1,
    rt.note2,
    rt.data_inserimento,
    rt.data_modifica,
    rt.id_utente_modifica,
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
    string_agg(DISTINCT concat(sa_rt.header_allegato, '#', sa_rt.oggetto, '#', sa_rt.nome_client), ';'::text) AS allegato_rt,
    rt.importo_effettivamente_versato1,
        CASE
            WHEN rt.data_emissione >= '2022-04-19 00:00:00'::timestamp without time zone AND count(pagopa_no.id) > 0 THEN ( SELECT get_registro_trasgressori_importo_effettivamente_introitato_2(t.ticketid) AS get_registro_trasgressori_importo_effettivamente_introitato_2)
            ELSE rt.importo_effettivamente_versato2::double precision
        END AS importo_effettivamente_versato2,
    rt.importo_effettivamente_versato3,
    rt.importo_effettivamente_versato4,
    rt.competenza_regionale,
   case when (SELECT * FROM get_registro_trasgressori_tutte_rate_pagate(t.ticketid)) then true else rt.pratica_chiusa end as pratica_chiusa,
    rt.data_ultima_notifica,
    rt.data_pagamento,
    rt.pagamento_ridotto_consentito,
    rt.data_ultima_notifica_ordinanza,
    rt.data_pagamento_ordinanza,
    rt.pagamento_ridotto_consentito_ordinanza,
        CASE
            WHEN rt.id IS NOT NULL THEN true
            ELSE false
        END AS esistente,
    rt.progressivo,
    rt.num_ordinanza,
    string_agg(DISTINCT concat(sa_pv.header_allegato, '#', sa_pv.oggetto, '#', sa_pv.nome_client), ';'::text) AS allegato_pv,
    string_agg(DISTINCT concat(sa_al.header_allegato, '#', sa_al.oggetto, '#', sa_al.nome_client), ';'::text) AS allegato_al,
    string_agg(DISTINCT concat_ws('#'::text, pagopa_pv.identificativo_univoco_versamento, pagopa_pv.url_file_avviso, pagopa_pv.stato_pagamento), '##'::text) AS pagopa_pv_iuv,
    string_agg(DISTINCT concat_ws('#'::text, pagopa_no.identificativo_univoco_versamento, pagopa_no.url_file_avviso, pagopa_no.stato_pagamento), '##'::text) AS pagopa_no_iuv,
        CASE
            WHEN rt.forzato THEN rt.forzato_pv_oblato_r
            ELSE pagopa_pv_r."check"
        END AS pagopa_pv_oblato_ridotta,
        CASE
            WHEN rt.forzato THEN rt.forzato_pv_oblato_ur
            ELSE pagopa_pv_ur."check"
        END AS pagopa_pv_oblato_ultraridotta,
        CASE
            WHEN rt.forzato THEN rt.forzato_pv_data_pagamento
            ELSE COALESCE(pagopa_pv_r.data_esito_singolo_pagamento, pagopa_pv_ur.data_esito_singolo_pagamento)::timestamp without time zone
        END AS pagopa_pv_data_pagamento,
        CASE
            WHEN count(pagopa_pv.id) > 0 THEN 'PV'::text
            WHEN count(pagopa_no.id) > 0 THEN 'NO'::text
            ELSE ''::text
        END AS pagopa_tipo,
    string_agg(DISTINCT concat(sa_ae.header_allegato, '#', sa_ae.oggetto, '#', sa_ae.nome_client), ';'::text) AS allegato_ae,
    rt.ae_pagati,
	(SELECT * FROM get_registro_trasgressori_rate_pagate(t.ticketid)) as pagopa_no_rate_pagate,
	(SELECT * FROM get_registro_trasgressori_tutte_rate_pagate(t.ticketid)) as pagopa_no_tutte_rate_pagate
   FROM ticket t
     JOIN ticket controllo ON controllo.tipologia = 3 AND t.id_controllo_ufficiale::text = controllo.id_controllo_ufficiale::text
     LEFT JOIN nucleo_ispettivo_mv mv_nucleo ON mv_nucleo.id_controllo_ufficiale = controllo.ticketid
     LEFT JOIN lookup_qualifiche nucleo ON nucleo.description::text = mv_nucleo.nucleo_ispettivo::text
     LEFT JOIN lookup_qualifiche nucleo2 ON nucleo2.description::text = mv_nucleo.nucleo_ispettivo_due::text
     LEFT JOIN lookup_qualifiche nucleo3 ON nucleo3.description::text = mv_nucleo.nucleo_ispettivo_tre::text
     LEFT JOIN lookup_site_id asl ON asl.code = controllo.site_id
     LEFT JOIN sanzioni_allegati sa_pv ON sa_pv.id_sanzione = t.ticketid AND sa_pv.tipo_allegato = 'SanzionePV'::text AND sa_pv.trashed_date IS NULL
     LEFT JOIN sanzioni_allegati sa_al ON sa_al.id_sanzione = t.ticketid AND sa_al.tipo_allegato = 'SanzioneAL'::text AND sa_al.trashed_date IS NULL
     LEFT JOIN sanzioni_allegati sa_rt ON sa_rt.id_sanzione = t.ticketid AND sa_rt.tipo_allegato = 'RegistroTrasgressori'::text AND sa_rt.trashed_date IS NULL
     LEFT JOIN sanzioni_allegati sa_ae ON sa_ae.id_sanzione = t.ticketid AND sa_ae.tipo_allegato = 'RegistroTrasgressoriAE'::text AND sa_ae.trashed_date IS NULL
     LEFT JOIN registro_trasgressori_values rt ON t.ticketid = rt.id_sanzione
     LEFT JOIN pagopa_pagamenti pagopa_pv ON pagopa_pv.id_sanzione = t.ticketid AND pagopa_pv.trashed_date IS NULL AND pagopa_pv.tipo_pagamento = 'PV'::text
     LEFT JOIN pagopa_pagamenti pagopa_no ON pagopa_no.id_sanzione = t.ticketid AND pagopa_no.trashed_date IS NULL AND pagopa_no.tipo_pagamento = 'NO'::text
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id,
            pagopa_pagamenti.data_esito_singolo_pagamento,
            true AS "check"
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'PV'::text AND pagopa_pagamenti.tipo_riduzione = 'R'::text AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_pv_r ON pagopa_pv_r.id_sanzione = t.ticketid
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id,
            pagopa_pagamenti.data_esito_singolo_pagamento,
            true AS "check"
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'PV'::text AND pagopa_pagamenti.tipo_riduzione = 'U'::text AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_pv_ur ON pagopa_pv_ur.id_sanzione = t.ticketid
  WHERE ((_idsanzione > 0 AND t.ticketid = _idsanzione) or _idsanzione = -1) AND t.trashed_date IS NULL AND t.tipologia = 1 AND controllo.trashed_date IS NULL AND controllo.assigned_date >= '2015-03-01 00:00:00'::timestamp without time zone AND controllo.status_id <> 1 AND t.id_nonconformita > 0
  GROUP BY controllo.ticketid, t.ticketid, asl.description, nucleo.in_dpat, nucleo.description, nucleo2.in_dpat, nucleo2.description, nucleo3.in_dpat, nucleo3.description, rt.id, rt.id_sanzione, rt.id_controllo_ufficiale, rt.anno, rt.data_prot_entrata, rt.pv_oblato_ridotta, rt.fi_assegnatario, rt.presentati_scritti, rt.presentata_richiesta_riduzione, rt.presentata_richiesta_audizione, rt.ordinanza_emessa, rt.importo_sanzione_ingiunta, rt.data_emissione, rt.giorni_lavorazione, rt.ordinanza_ingiunzione_oblata, rt.sentenza_favorevole, rt.importo_stabilito, rt.ordinanza_ingiunzione_sentenza, rt.iscrizione_ruoli_sattoriali, rt.note1, rt.note2, rt.data_inserimento, rt.data_modifica, rt.id_utente_modifica, rt.presentata_opposizione, rt.trashed_date, rt.richiesta_rateizzazione, rt.rata1, rt.rata2, rt.rata3, rt.rata4, rt.rata5, rt.rata6, rt.rata7, rt.rata8, rt.rata9, rt.rata10, rt.allegato_documentale, rt.importo_effettivamente_versato1, rt.importo_effettivamente_versato2, rt.importo_effettivamente_versato3, rt.importo_effettivamente_versato4, rt.competenza_regionale, rt.pratica_chiusa, rt.data_ultima_notifica, rt.data_pagamento, rt.pagamento_ridotto_consentito, rt.data_ultima_notifica_ordinanza, rt.data_pagamento_ordinanza, rt.pagamento_ridotto_consentito_ordinanza, pagopa_pv_r."check", pagopa_pv_ur."check", pagopa_pv_r.data_esito_singolo_pagamento, pagopa_pv_ur.data_esito_singolo_pagamento
UNION
 SELECT NULL::integer AS idcontrollo,
    date_part('year'::text, t.assigned_date) AS anno_controllo,
    t.ticketid AS idsanzione,
    asl.description AS asl,
    ''::text AS ente1,
    ''::text AS ente2,
    ''::text AS ente3,
    t.tipo_richiesta AS numeroverbale,
    t.verbale_sequestro AS numeroverbalesequestri,
        CASE
            WHEN t.pagamento_ultraridotto > 0::double precision THEN 'SI '::text || t.pagamento_ultraridotto
            ELSE 'NO'::text
        END AS importosanzioneultraridotta,
    t.assigned_date AS dataaccertamento,
    t.trasgressore,
    t.obbligatoinsolido AS obbligato,
    t.pagamento::text AS importosanzioneridotta,
    rt.id,
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
    rt.iscrizione_ruoli_sattoriali,
    rt.note1,
    rt.note2,
    rt.data_inserimento,
    rt.data_modifica,
    rt.id_utente_modifica,
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
    string_agg(DISTINCT concat(sa_rt.header_allegato, '#', sa_rt.oggetto, '#', sa_rt.nome_client), ';'::text) AS allegato_rt,
    rt.importo_effettivamente_versato1,
    rt.importo_effettivamente_versato2,
    rt.importo_effettivamente_versato3,
    rt.importo_effettivamente_versato4,
    rt.competenza_regionale,
    rt.pratica_chiusa,
    rt.data_ultima_notifica,
    rt.data_pagamento,
    rt.pagamento_ridotto_consentito,
    rt.data_ultima_notifica_ordinanza,
    rt.data_pagamento_ordinanza,
    rt.pagamento_ridotto_consentito_ordinanza,
        CASE
            WHEN rt.id IS NOT NULL THEN true
            ELSE false
        END AS esistente,
    rt.progressivo,
    rt.num_ordinanza,
    ''::text AS allegato_pv,
    ''::text AS allegato_al,
    ''::text AS pagopa_pv_iuv,
    ''::text AS pagopa_no_iuv,
    NULL::boolean AS pagopa_pv_oblato_ridotta,
    NULL::boolean AS pagopa_pv_oblato_ultraridotta,
    NULL::timestamp without time zone AS pagopa_pv_data_pagamento,
    ''::text AS pagopa_tipo,
    string_agg(DISTINCT concat(sa_ae.header_allegato, '#', sa_ae.oggetto, '#', sa_ae.nome_client), ';'::text) AS allegato_ae,
    rt.ae_pagati,
	  ''::text AS pagopa_no_rate_pagate,
	  false as pagopa_no_tutte_rate_pagate
   FROM ticket t
     LEFT JOIN lookup_site_id asl ON asl.code = t.site_id
     LEFT JOIN sanzioni_allegati sa_rt ON sa_rt.id_sanzione = t.ticketid AND sa_rt.tipo_allegato = 'RegistroTrasgressori'::text AND sa_rt.trashed_date IS NULL
     LEFT JOIN sanzioni_allegati sa_ae ON sa_ae.id_sanzione = t.ticketid AND sa_ae.tipo_allegato = 'RegistroTrasgressoriAE'::text AND sa_ae.trashed_date IS NULL
     LEFT JOIN registro_trasgressori_values rt ON t.ticketid = rt.id_sanzione
  WHERE ((_idsanzione > 0 AND t.ticketid = _idsanzione) or _idsanzione = -1) AND t.trashed_date IS NULL AND t.tipologia = 1 AND t.assigned_date >= '2015-03-01 00:00:00'::timestamp without time zone AND t.note_internal_use_only ~~* '%RECORD GENERATO AUTOMATICAMENTE PER INSERIMENTO SANZIONE FORZATA NEL REGISTRO TRASGRESSORI%'::text
  GROUP BY t.ticketid, asl.description, rt.id, rt.id_sanzione, rt.id_controllo_ufficiale, rt.anno, rt.data_prot_entrata, rt.pv_oblato_ridotta, rt.fi_assegnatario, rt.presentati_scritti, rt.presentata_richiesta_riduzione, rt.presentata_richiesta_audizione, rt.ordinanza_emessa, rt.importo_sanzione_ingiunta, rt.data_emissione, rt.giorni_lavorazione, rt.ordinanza_ingiunzione_oblata, rt.sentenza_favorevole, rt.importo_stabilito, rt.ordinanza_ingiunzione_sentenza, rt.iscrizione_ruoli_sattoriali, rt.note1, rt.note2, rt.data_inserimento, rt.data_modifica, rt.id_utente_modifica, rt.presentata_opposizione, rt.trashed_date, rt.richiesta_rateizzazione, rt.rata1, rt.rata2, rt.rata3, rt.rata4, rt.rata5, rt.rata6, rt.rata7, rt.rata8, rt.rata9, rt.rata10, rt.allegato_documentale, rt.importo_effettivamente_versato1, rt.importo_effettivamente_versato2, rt.importo_effettivamente_versato3, rt.importo_effettivamente_versato4, rt.competenza_regionale, rt.pratica_chiusa, rt.data_ultima_notifica, rt.data_pagamento, rt.pagamento_ridotto_consentito, rt.data_ultima_notifica_ordinanza, rt.data_pagamento_ordinanza, rt.pagamento_ridotto_consentito_ordinanza;
  
select id_sanzione, rt_id into _new_id_sanzione, _new_rt_id from registro_trasgressori_materializzato where id_sanzione = _idsanzione;  
select concat('Registro Trasgressori aggiornato. Id Sanzione: ', _new_id_sanzione, '; RT Id: ', _new_rt_id) into ret;

 RETURN ret;
 END;
$BODY$;



select * from refresh_registro_trasgressori (1880632);



    